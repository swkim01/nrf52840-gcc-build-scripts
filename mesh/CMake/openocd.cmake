find_program(OPENOCD
    openocd)

find_program(MERGEHEX
    mergehex)

if (OPENOCD AND MERGEHEX)
    add_custom_target(merge)
    function(add_flash_target target)
        # Both the manual <merge> and <flash> target and depends on
        # the custom command that generates the merged hexfile.
        add_custom_target(merge_${target}
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex)

        add_dependencies(merge merge_${target})

        add_custom_target(flash_${target}
            COMMAND ${OPENOCD} -f interface/stlink.cfg -f target/nrf52.cfg -c \"init \; reset halt \; nrf5 mass_erase \; sleep 500 \; program ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex verify reset \; shutdown\"
            USES_TERMINAL
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex)

        add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex
            COMMAND ${MERGEHEX} -m ${${SOFTDEVICE}_HEX_FILE} ${CMAKE_CURRENT_BINARY_DIR}/${target}.hex -o ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex
            DEPENDS ${target}
            VERBATIM)
    endfunction(add_flash_target)
else ()
    message(STATUS "Could not find command line tools(`mergehex` and `openocd`).
   See http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.tools/dita/tools/nrf5x_command_line_tools/nrf5x_installation.html?cp=5_1_1 and https://openocd.org
   Flash target will not be supported.")
    function(add_flash_target target)
        # Not supported
    endfunction(add_flash_target)
endif (OPENOCD AND MERGEHEX)
