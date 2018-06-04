Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeFDQWj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:22:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38364 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFDQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:22:37 -0400
X-Google-Smtp-Source: ADUXVKJ2w4pPR+wnUvMfLdIu7du2faYtjxekyEjlYDcrDcvM7+HoSs4LhD9v8Rjq8X+rWSyOLhcomQ==
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To: Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
Date: Mon, 4 Jun 2018 09:22:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/18/2018 11:34 AM, Scott Branden wrote:
> Move remaining sata configuration to stingray-sata.dtsi and enable
> ports based on NUM_SATA defined.
> Now, all that needs to be done is define NUM_SATA per board.

Rob could you review this and let us know if this approach is okay or
not? Thank you!

> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 64 --------------------
>  .../boot/dts/broadcom/stingray/bcm958742k.dts      |  2 +
>  .../boot/dts/broadcom/stingray/bcm958742t.dts      |  2 +
>  .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 68 ++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> index 8862ec9..cacc25e 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> @@ -72,70 +72,6 @@
>  	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
>  };
>  
> -&sata0 {
> -	status = "okay";
> -};
> -
> -&sata_phy0{
> -	status = "okay";
> -};
> -
> -&sata1 {
> -	status = "okay";
> -};
> -
> -&sata_phy1{
> -	status = "okay";
> -};
> -
> -&sata2 {
> -	status = "okay";
> -};
> -
> -&sata_phy2{
> -	status = "okay";
> -};
> -
> -&sata3 {
> -	status = "okay";
> -};
> -
> -&sata_phy3{
> -	status = "okay";
> -};
> -
> -&sata4 {
> -	status = "okay";
> -};
> -
> -&sata_phy4{
> -	status = "okay";
> -};
> -
> -&sata5 {
> -	status = "okay";
> -};
> -
> -&sata_phy5{
> -	status = "okay";
> -};
> -
> -&sata6 {
> -	status = "okay";
> -};
> -
> -&sata_phy6{
> -	status = "okay";
> -};
> -
> -&sata7 {
> -	status = "okay";
> -};
> -
> -&sata_phy7{
> -	status = "okay";
> -};
> -
>  &mdio_mux_iproc {
>  	mdio@10 {
>  		gphy0: eth-phy@10 {
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
> index 77efa28..a515346 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
> @@ -32,6 +32,8 @@
>  
>  /dts-v1/;
>  
> +#define NUM_SATA	8
> +
>  #include "bcm958742-base.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
> index 5084b03..6a4d19e 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
> @@ -32,6 +32,8 @@
>  
>  /dts-v1/;
>  
> +#define NUM_SATA	8
> +
>  #include "bcm958742-base.dtsi"
>  
>  / {
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
> index 8c68e0c..7f6d176 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
> @@ -43,7 +43,11 @@
>  			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 0)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata0_port0: sata-port@0 {
>  				reg = <0>;
> @@ -58,7 +62,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 0)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata0_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -73,7 +81,11 @@
>  			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 1)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata1_port0: sata-port@0 {
>  				reg = <0>;
> @@ -88,7 +100,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 1)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata1_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -103,7 +119,11 @@
>  			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 2)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata2_port0: sata-port@0 {
>  				reg = <0>;
> @@ -118,7 +138,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 2)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata2_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -133,7 +157,11 @@
>  			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 3)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata3_port0: sata-port@0 {
>  				reg = <0>;
> @@ -148,7 +176,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 3)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata3_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -163,7 +195,11 @@
>  			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 4)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata4_port0: sata-port@0 {
>  				reg = <0>;
> @@ -178,7 +214,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 4)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata4_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -193,7 +233,11 @@
>  			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 5)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata5_port0: sata-port@0 {
>  				reg = <0>;
> @@ -208,7 +252,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 5)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata5_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -223,7 +271,11 @@
>  			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 6)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata6_port0: sata-port@0 {
>  				reg = <0>;
> @@ -238,7 +290,11 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 6)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata6_phy0: sata-phy@0 {
>  				reg = <0>;
> @@ -253,7 +309,11 @@
>  			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 7)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata7_port0: sata-port@0 {
>  				reg = <0>;
> @@ -268,11 +328,19 @@
>  			reg-names = "phy";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +#if (NUM_SATA > 7)
> +			status = "okay";
> +#else
>  			status = "disabled";
> +#endif
>  
>  			sata7_phy0: sata-phy@0 {
>  				reg = <0>;
>  				#phy-cells = <0>;
>  			};
>  		};
> +
> +#if (NUM_SATA > 8)
> +#error "NUM_SATA > 8"
> +#endif
>  	};
> 


-- 
Florian
