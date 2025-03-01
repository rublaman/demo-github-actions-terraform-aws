#!/bin/bash
# Script para inicializar la infraestructura básica necesaria para el proyecto

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verifica si se proporcionaron todos los argumentos
if [ "$#" -ne 2 ]; then
    echo -e "${RED}Error: Argumentos insuficientes${NC}"
    echo -e "Uso: $0 <environment> <region>"
    echo -e "Ejemplo: $0 dev eu-west-1"
    exit 1
fi

ENVIRONMENT=$1
REGION=$2
BUCKET_NAME="${ENVIRONMENT}-rublaman-terraform-state-bucket"

# Verifica que el entorno sea válido
if [[ ! "$ENVIRONMENT" =~ ^(dev|stg|pro)$ ]]; then
    echo -e "${RED}Error: El entorno debe ser 'dev', 'stg' o 'pro'${NC}"
    exit 1
fi

# Verifica que la región sea válida
if [ "$REGION" != "eu-west-3" ]; then
    echo -e "${YELLOW}Advertencia: La región especificada no es 'eu-west-3' (Paris) como se recomienda en el proyecto${NC}"
    read -p "¿Desea continuar? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
        echo -e "${RED}Operación cancelada${NC}"
        exit 1
    fi
fi

echo -e "${BLUE}Verificando credenciales de AWS...${NC}"
# Verificar si las credenciales de AWS están configuradas
if ! aws sts get-caller-identity &>/dev/null; then
    echo -e "${RED}Error: No se pueden verificar las credenciales de AWS${NC}"
    echo -e "Por favor, configure sus credenciales de AWS con:"
    echo -e "  aws configure"
    echo -e "O establezca las variables de entorno AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY"
    exit 1
fi

CALLER_IDENTITY=$(aws sts get-caller-identity --query "Arn" --output text)
echo -e "${GREEN}Usando identidad AWS: ${CALLER_IDENTITY}${NC}"

echo -e "${BLUE}Creando bucket de estado de Terraform para el entorno $ENVIRONMENT en la región $REGION...${NC}"

# Comprobar si el bucket ya existe
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    echo -e "${YELLOW}El bucket $BUCKET_NAME ya existe. Omitiendo la creación.${NC}"
else
    # Crear el bucket de estado de Terraform
    if aws s3api create-bucket \
        --bucket $BUCKET_NAME \
        --region $REGION \
        --create-bucket-configuration LocationConstraint=$REGION; then
        echo -e "${GREEN}Bucket $BUCKET_NAME creado exitosamente${NC}"
    else
        echo -e "${RED}Error al crear el bucket $BUCKET_NAME${NC}"
        exit 1
    fi
fi

# Habilitar el versionado del bucket
echo -e "${BLUE}Habilitando el versionado del bucket...${NC}"
if aws s3api put-bucket-versioning \
    --bucket $BUCKET_NAME \
    --versioning-configuration Status=Enabled; then
    echo -e "${GREEN}Versionado habilitado exitosamente${NC}"
else
    echo -e "${RED}Error al habilitar el versionado${NC}"
    exit 1
fi

# Configurar el bucket como privado
echo -e "${BLUE}Configurando el bucket como privado...${NC}"
if aws s3api put-public-access-block \
    --bucket $BUCKET_NAME \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"; then
    echo -e "${GREEN}Configuración de acceso público bloqueada exitosamente${NC}"
else
    echo -e "${RED}Error al configurar el bloqueo de acceso público${NC}"
    exit 1
fi

USER_ARN=$CALLER_IDENTITY

# Asegurarse de que el bucket tenga los permisos adecuados para los locks
echo -e "${BLUE}Configurando política de bucket para soportar lockfiles de Terraform...${NC}"
POLICY='{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "'$USER_ARN'"
      },
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::'$BUCKET_NAME'",
        "arn:aws:s3:::'$BUCKET_NAME'/*"
      ]
    }
  ]
}'

if aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy "$POLICY"; then
    echo -e "${GREEN}Política de bucket configurada exitosamente${NC}"
else
    echo -e "${RED}Error al configurar la política del bucket${NC}"
    exit 1
fi

echo -e "${GREEN}¡Configuración completada!${NC}"
echo -e "Bucket de estado de Terraform: ${YELLOW}$BUCKET_NAME${NC}"
echo -e "\nRecuerde configurar las siguientes variables en GitHub Environment '${ENVIRONMENT}':"
echo -e "${YELLOW}AWS_REGION:${NC} $REGION"
echo -e "${YELLOW}ENVIRONMENT:${NC} $ENVIRONMENT"
echo -e "${YELLOW}TERRAFORM_STATE_BUCKET:${NC} $BUCKET_NAME"
echo -e "${YELLOW}S3_BUCKET_LANDING:${NC} ${ENVIRONMENT}-rublaman-landing_s3"
echo -e "${YELLOW}S3_BUCKET_RAW:${NC} ${ENVIRONMENT}-rublaman-raw_s3"
echo -e "${YELLOW}S3_BUCKET_CURATED:${NC} ${ENVIRONMENT}-rublaman-curated_s3"
echo -e "${YELLOW}S3_BUCKET_READY:${NC} ${ENVIRONMENT}-rublaman-ready_s3"
echo -e "\nY los siguientes secretos:"
echo -e "${YELLOW}AWS_ACCESS_KEY_ID${NC}"
echo -e "${YELLOW}AWS_SECRET_ACCESS_KEY${NC}"