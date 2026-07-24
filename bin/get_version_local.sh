#!/usr/bin/env bash

# Generate config/version.dtsi with a macro_ver behavior that types the
# build stamp: YYYYMMDD-<branch prefix>-<short commit>-<suffix> + Enter.
# Ported from Adv360-Pro-ZMK. The Makefile runs this before a build and
# restores the committed fallback (which types "ghbuild") afterwards.

date=$(date -u +"%Y%m%d")
branch=$(git rev-parse --abbrev-ref HEAD | cut -c1-4)
commit=$(git rev-parse --short HEAD)
suffix=${1:-"kb44"}

uppercase_char() {
    local char=$1

    (echo $char | tr '[a-z]' '[A-Z]' 2> /dev/null) || echo "${char^^}"
}

# Function to transform characters to ZMK key behaviours
transform_char() {
    local char=$1

    if [[ $char =~ [A-Za-z] ]]; then
        echo "<&kp $(uppercase_char $char)>, "
    elif [[ $char =~ [0-9] ]]; then
        echo "<&kp N${char}>, "
    elif [ "$char" = "." ]; then
        echo "<&kp DOT>, "
    fi
}

formatted=""
for ((i = 0; i < ${#date}; i++)); do
    formatted+=$(transform_char "${date:$i:1}")
done
formatted+="<&kp MINUS>, "
for ((i = 0; i < ${#branch}; i++)); do
    formatted+=$(transform_char "${branch:$i:1}")
done
formatted+="<&kp MINUS>, "
for ((i = 0; i < ${#commit}; i++)); do
    formatted+=$(transform_char "${commit:$i:1}")
done
formatted+="<&kp MINUS>, "
for ((i = 0; i < ${#suffix}; i++)); do
    formatted+=$(transform_char "${suffix:$i:1}")
done
formatted+="<&kp RET>"

echo $formatted

echo '#define VERSION_MACRO' > "config/version.dtsi"
echo 'macro_ver: macro_ver {' >> "config/version.dtsi"
echo 'compatible = "zmk,behavior-macro";' >> "config/version.dtsi"
echo '#binding-cells = <0>;' >> "config/version.dtsi"
echo "bindings = $formatted;" >> "config/version.dtsi"
echo '};' >> "config/version.dtsi"
