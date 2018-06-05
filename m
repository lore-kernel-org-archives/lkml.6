Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeFEUTW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:19:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36896 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeFEUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:19:19 -0400
X-Google-Smtp-Source: ADUXVKKFd3dCBF2e2q7rjPPIkHgREpfyNr4mVaCJICOCwXtKzupPGwAjjlsXjQ4g5SFuOMaPt72SGw==
Subject: Re: [PATCH v3 3/6] mtd: rawnand: tegra: add devicetree binding
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org,
        krzk@kernel.org, jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-4-stefan@agner.ch> <20180601093025.2817ff30@bbrezillon>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <faa40dac-ab2a-2d43-3a43-2d46cebcd539@gmail.com>
Date: Tue, 5 Jun 2018 23:19:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180601093025.2817ff30@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.2018 10:30, Boris Brezillon wrote:
> On Fri,  1 Jun 2018 00:16:34 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> This adds the devicetree binding for the Tegra 2 NAND flash
>> controller.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  .../bindings/mtd/nvidia-tegra20-nand.txt      | 64 +++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>> new file mode 100644
>> index 000000000000..5cd984ef046b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>> @@ -0,0 +1,64 @@
>> +NVIDIA Tegra NAND Flash controller
>> +
>> +Required properties:
>> +- compatible: Must be one of:
>> +  - "nvidia,tegra20-nand"
> 
> As discussed previously, I prefer "nvidia,tegra20-nand-controller" or
> "nvidia,tegra20-nfc".
> 
>> +- reg: MMIO address range
>> +- interrupts: interrupt output of the NFC controller
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - nand
>> +- resets: Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names: Must include the following entries:
>> +  - nand
>> +
>> +Optional children nodes:
>> +Individual NAND chips are children of the NAND controller node. Currently
>> +only one NAND chip supported.
>> +
>> +Required children node properties:
>> +- reg: An integer ranging from 1 to 6 representing the CS line to use.
>> +
>> +Optional children node properties:
>> +- nand-ecc-mode: String, operation mode of the NAND ecc mode. Currently only
>> +		 "hw" is supported.
>> +- nand-ecc-algo: string, algorithm of NAND ECC.
>> +		 Supported values with "hw" ECC mode are: "rs", "bch".
>> +- nand-bus-width : See nand.txt
>> +- nand-on-flash-bbt: See nand.txt
>> +- nand-ecc-strength: integer representing the number of bits to correct
>> +		     per ECC step (always 512). Supported strength using HW ECC
>> +		     modes are:
>> +		     - RS: 4, 6, 8
>> +		     - BCH: 4, 8, 14, 16
>> +- nand-ecc-maximize: See nand.txt
>> +- nand-is-boot-medium: Makes sure only ECC strengths supported by the boot ROM
>> +		       are choosen.
>> +- wp-gpios: GPIO specifier for the write protect pin.
>> +
>> +Optional child node of NAND chip nodes:
>> +Partitions: see partition.txt
>> +
>> +  Example:
>> +	nand@70008000 {
> 
> 	nand-controller@70008000 {
> 
>> +		compatible = "nvidia,tegra20-nand";
> 
> 		compatible = "nvidia,tegra20-nand-controller";
> 
> or
> 
> 		compatible = "nvidia,tegra20-nfc";
> 

Maybe it's just me, but when I'm reading "nfc", my first association is the
"Near Field Communication". Probably an explicit
"nvidia,tegra20-nand-controller" variant is more preferable.

>> +		reg = <0x70008000 0x100>;
>> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
>> +		clock-names = "nand";
>> +		resets = <&tegra_car 13>;
>> +		reset-names = "nand";
>> +
>> +		nand-chip@0 {
> 
> 		nand@0 {
> 
>> +			reg = <0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			nand-bus-width = <8>;
>> +			nand-on-flash-bbt;
>> +			nand-ecc-algo = "bch";
>> +			nand-ecc-strength = <8>;
>> +			wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
> 
> With this addressed,
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
