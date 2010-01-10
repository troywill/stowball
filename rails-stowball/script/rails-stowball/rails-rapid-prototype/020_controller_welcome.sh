source ./tdw-lib.sh
${SCRIPT_DIR}/generate controller welcome index login logout view1 view2
${EDITOR} ${TOP_DIR}/config/routes.rb
rm -i ${TOP_DIR}/public/index.html

