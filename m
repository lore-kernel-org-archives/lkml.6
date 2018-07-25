Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A97C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2BC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="skIFfuR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2BC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeGYH7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:59:44 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:45623 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbeGYH7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f80iHi2a5LLTr+LEyQgK9gj497L7/oaiqIkpolRoAlM=; b=skIFfuR90BaQo3Q6kyEAKvgox0
        X5XbH1BfjBoRLKH3HYuDOqlnUa54UlB08detcT/qIEPc0vWaMy5M0orWIuNLL0Qw74JNvAuRm5KPh
        iT9P+VxhJho/KJsfJfdDMGG2rAKOuHU+lCT5yDFQJ1k7yfGLKR3jflQPTjNLLdYyGgaI0DHoildh6
        NagqkQ4YnkumVgecHD0+yyor090P53a4akYxvV9f3K3urFhDnQ1FcDFdGUU+U01dipQR3q8nYDgY8
        Mm7E+CyOPDyyVbK7NuWMEE8B8Fqwn0mno6d1PmC50eDypySUj3g+TGn5KRGHM065gdbBU7q547sgV
        ByyPcViA==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDc0-0003CB-6m; Wed, 25 Jul 2018 09:49:28 +0300
Subject: Re: [PATCH 3/7] arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
 <1532090746-15863-4-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <e33f9c5b-1277-c05a-1b4b-babecfefbba3@kapsi.fi>
Date:   Wed, 25 Jul 2018 09:49:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532090746-15863-4-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 20.07.2018 15:45, Aapo Vienamo wrote:
> Add pad voltage configuration nodes for sdmmc pads with configurable
> voltages on Tegra210.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 3be920e..bc1918e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -3,6 +3,7 @@
>   #include <dt-bindings/gpio/tegra-gpio.h>
>   #include <dt-bindings/memory/tegra210-mc.h>
>   #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> +#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/thermal/tegra124-soctherm.h>
>   
> @@ -776,6 +777,26 @@
>   				#power-domain-cells = <0>;
>   			};
>   		};
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins = "sdmmc1";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins = "sdmmc1";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
> +
> +		sdmmc3_3v3: sdmmc3-3v3 {
> +			pins = "sdmmc3";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc3_1v8: sdmmc3-1v8 {
> +			pins = "sdmmc3";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
>   	};
>   
>   	fuse@7000f800 {
> @@ -1027,6 +1048,9 @@
>   		clock-names = "sdhci";
>   		resets = <&tegra_car 14>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc1_3v3>;
> +		pinctrl-1 = <&sdmmc1_1v8>;
>   		status = "disabled";
>   	};
>   
> @@ -1049,6 +1073,9 @@
>   		clock-names = "sdhci";
>   		resets = <&tegra_car 69>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc3_3v3>;
> +		pinctrl-1 = <&sdmmc3_1v8>;
>   		status = "disabled";
>   	};
>   
> 
