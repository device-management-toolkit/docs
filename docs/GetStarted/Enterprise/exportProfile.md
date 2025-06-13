--8<-- "References/abbreviations.md"

### Steps to Export a Profile

1. Export the created profiles to a `.yaml` file that can be given to RPC-Go for device activation and configuration.

2. Click the export button to download profile in `yaml` format.
    - For CCM profiles, Domain Profile selection is not required or prompted. 

        <figure class="figure-image">
            <img src="..\..\..\assets\images\screenshots\Console_ExportProfile.png" alt="Figure 1: Export Profile">
            <figcaption>Figure 1: Export Button</figcaption>
        </figure>

    - For ACM profiles, you will be prompted to select a Domain Profile. If the target device is already activated in ACM, you can select 'Skip Domain', and the exported profile will not include a Domain Profile. 

        <figure class="figure-image">
            <img src="..\..\..\assets\images\screenshots\Console_ExportACMProfile.png" alt="Figure 1: Export ACM Profile">
            <figcaption>Figure 1: Export Button</figcaption>
        </figure>

3. **Save the given Profile Key.** It is only given this once. This key is used by RPC-Go to decode the encrypted config file.

    <figure class="figure-image">
        <img src="..\..\..\assets\images\screenshots\Console_ProfileKey.png" alt="Figure 2: Profile Key">
        <figcaption>Figure 2: Profile Key</figcaption>
    </figure>

4. Move or Copy the new, downloaded `.yaml` config file to the AMT device.

## Next up
**[Activate a Device](activateDevice.md)**