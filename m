Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeFDVJN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:09:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43483 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeFDVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:09:11 -0400
X-Google-Smtp-Source: ADUXVKLAx2EngV6hTA8YqjmHOjuNkW63CBvAnK/049j7Icrxl4SFwS8QUBG4rPSRnlNxLVVgEVzMiw==
Subject: Re: [PATCH] arm64: dts: stingray: move common board components to
 stingray-board-base
To: Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527015342-9317-1-git-send-email-scott.branden@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <05b33af8-c938-f124-f918-a9d7f8679d90@gmail.com>
Date: Mon, 4 Jun 2018 14:09:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527015342-9317-1-git-send-email-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 11:55 AM, Scott Branden wrote:
> Move common board components from base bcm958742 dtsi file to new
> stingray-board-base dtsi file so they can be shared between many stingray
> boards following common design.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>


Applied to devicetree-arm64/next, though this did not apply cleanly,
please check the results at:

https://github.com/Broadcom/stblinux/commit/0b2cf5a855cd235fa95fbdfedfc524a97a71a7fe

> ---
>  .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 35 +--------------
>  .../dts/broadcom/stingray/stingray-board-base.dtsi | 51 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 34 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
> 
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> index cacc25e..d74f6df 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> @@ -30,20 +30,9 @@
>   *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> -#include "stingray.dtsi"
> +#include "stingray-board-base.dtsi"
>  
>  / {
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	aliases {
> -		serial0 = &uart1;
> -		serial1 = &uart0;
> -		serial2 = &uart2;
> -		serial3 = &uart3;
> -	};
> -
>  	sdio0_vddo_ctrl_reg: sdio0_vddo_ctrl {
>  		compatible = "regulator-gpio";
>  		regulator-name = "sdio0_vddo_ctrl_reg";
> @@ -67,23 +56,6 @@
>  	};
>  };
>  
> -&memory { /* Default DRAM banks */
> -	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> -	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
> -};
> -
> -&mdio_mux_iproc {
> -	mdio@10 {
> -		gphy0: eth-phy@10 {
> -			reg = <0x10>;
> -		};
> -	};
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
>  &pwm {
>  	status = "okay";
>  };
> @@ -111,8 +83,6 @@
>  };
>  
>  &enet {
> -	phy-mode = "rgmii-id";
> -	phy-handle = <&gphy0>;
>  	status = "okay";
>  };
>  
> @@ -133,13 +103,10 @@
>  
>  &sdio0 {
>  	vqmmc-supply = <&sdio0_vddo_ctrl_reg>;
> -	non-removable;
> -	full-pwr-cycle;
>  	status = "okay";
>  };
>  
>  &sdio1 {
>  	vqmmc-supply = <&sdio1_vddo_ctrl_reg>;
> -	full-pwr-cycle;
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
> new file mode 100644
> index 0000000..82a2471
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
> +/*
> + *  Copyright(c) 2016-2018 Broadcom
> + */
> +
> +#include "stingray.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart0;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&memory { /* Default DRAM banks */
> +	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> +	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
> +};
> +
> +&enet {
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&gphy0>;
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&sdio0 {
> +	non-removable;
> +	full-pwr-cycle;
> +};
> +
> +&sdio1 {
> +	full-pwr-cycle;
> +};
> +
> +&mdio_mux_iproc {
> +	mdio@10 {
> +		gphy0: eth-phy@10 {
> +			reg = <0x10>;
> +		};
> +	};
> +};
> 


-- 
Florian
