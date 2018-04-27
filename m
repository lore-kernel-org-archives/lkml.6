Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758735AbeD0TDe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:03:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34067 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758664AbeD0TD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:03:29 -0400
X-Google-Smtp-Source: AB8JxZoa0wvhTglTnYx+CauqMqjFMHFEbLb5ijMMaryDOaHW5NOHeXtxALAEWc5bNX+fWAcbTwlo3Q==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] ARM64: dts: meson-axg: add an 32K alt aoclk
Organization: BayLibre
References: <20180328030130.240336-1-yixun.lan@amlogic.com>
        <20180328030130.240336-3-yixun.lan@amlogic.com>
Date: Fri, 27 Apr 2018 12:03:26 -0700
In-Reply-To: <20180328030130.240336-3-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Wed, 28 Mar 2018 11:01:29 +0800")
Message-ID: <7hmuxo1ngh.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> The ao_clk81 in AO domain have two clock source,
> one from a 32K alt crystal we name it as ao_alt_clk,
> another is the clk81 signal from EE domain.
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

As this one is a stanadlone, I've applied it to v4.18/dt64,

Thanks,

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b0eff7d7f771..40ca49fb94a6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -108,6 +108,13 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	ao_alt_xtal: ao_alt_xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000000>;
> +		clock-output-names = "ao_alt_xtal";
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
