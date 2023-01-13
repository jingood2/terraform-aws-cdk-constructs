# read the workflow templatikkkjje
APPLY_WORKFLOW_TEMPLATE=$(cat .github/apply-workflow-template.yml)
SYNTH_WORKFLOW_TEMPLATE=$(cat .github/synth-workflow-template.yml)

ROOT_DIR='modules'
#BUILD_ACCOUNT='037729278610'
BUILD_ACCOUNT='484752921218'
#TARGET_DEPLOY_ACCOUNTS=('037729278610') 
TARGET_DEPLOY_ACCOUNTS=('484752921218') 
#BRANCH_NAMES=('feat' 'develop' 'main' )
# ACCOUNT 수만큼 reusable template에 deploy-prod 추가
for CATEGORY in $(ls ${ROOT_DIR}); do
    echo "generating workflow for ${ROOT_DIR}/${CATEGORY}"

    for PROJECT in $(ls ${ROOT_DIR}/${CATEGORY}); do
      APPLY_WORKFLOW_TEMPLATE=$(echo "${APPLY_WORKFLOW_TEMPLATE}" | sed "s/{{ROOT_DIR}}/${ROOT_DIR}/g" | sed "s/{{TARGET_ACCOUNT}}/${ACCOUNT}/g" | sed "s/{{STACK_NAME}}/${PROJECT}/g" | sed "s/{{CATEGORY}}/${CATEGORY}/g" )
      echo "${APPLY_WORKFLOW_TEMPLATE}" > .github/workflows/apply-${CATEGORY}-${PROJECT}.yml
      SYNTH_WORKFLOW_TEMPLATE=$(echo "${SYNTH_WORKFLOW_TEMPLATE}" | sed "s/{{ROOT_DIR}}/${ROOT_DIR}/g" | sed "s/{{TARGET_ACCOUNT}}/${ACCOUNT}/g" | sed "s/{{STACK_NAME}}/${PROJECT}/g" | sed "s/{{CATEGORY}}/${CATEGORY}/g" )
      echo "${SYNTH_WORKFLOW_TEMPLATE}" > .github/workflows/synth-${CATEGORY}-${PROJECT}.yml
    done

done