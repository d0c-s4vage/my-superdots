
RS_bright=1.0
RS_gamma=3500
function darker {
    RS_bright=$(python -c "print(max($RS_bright-0.1,0.1))")
    apply_redshift_settings
}
function brighter {
    RS_bright=$(python -c "print(min($RS_bright+0.1,1.0))")
    apply_redshift_settings
}
function apply_redshift_settings {
    echo "     gamma = $RS_gamma"
    echo "brightness = $RS_bright"
    RS_gamma=$(python -c "print(int(float($RS_bright)*3500))")
    CMD=(
        redshift
            -O $RS_gamma
            -b $RS_bright
    )
    "${CMD[@]}" >/dev/null
}
