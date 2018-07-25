Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC20EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6389020671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EHw2Glsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6389020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeGYIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:01:16 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:55127 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbeGYIBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w4FFHGX0XCT1aLUQ9t/iEkEBL4Wj/29wUAEmQkqhhgw=; b=EHw2Glsd3mvXKMg6St8PF5oi15
        2wTEdGyAmEoDuTU8mKf4pTX10hmfUGi/Mfp2DMADJP2n1IgP0qZ9bcNszc3X8Tg1OyJ3YXTCrO72h
        CfVGtbzWpiHEex1y7vYgxXtYc2fAqOdvqrwCjN+TCmDiSk5KjVqDLKyExlrktmZG90Iv5r6jTYz/Q
        Hf19/EFonBbhE3WDLGyaK1cwhWX4Kcs6dTjUOHgvzj5LiRyEaltfH2VgO1KDFMoATGccCFwekYVwd
        usvOR+k9vwJvRLM+Rai0cZYGHHkypje4gpHKmMAFR1yjquehdT175gvZoY8BzXT54gNV7tANHVb0M
        7KXZDCxg==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDdT-00042l-Ua; Wed, 25 Jul 2018 09:51:00 +0300
Subject: Re: [PATCH 5/7] arm64: dts: tegra210-p2180: Allow ldo2 to go down to
 1.8 V
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
 <1532090746-15863-6-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <2bb6f4a6-5f5d-0ab6-ae62-169bd03739ca@kapsi.fi>
Date:   Wed, 25 Jul 2018 09:50:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532090746-15863-6-git-send-email-avienamo@nvidia.com>
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
> Set regulator-min-microvolt property of ldo2 to 1.8 V in
> tegra210-p2180.dtsi. ldo2 is used by the sdmmc1 SDHCI controller and its
> voltage needs to be adjusted down to 1.8 V to support faster signaling
> modes. It appears that the comment about the SDHCI driver requesting
> invalid voltages no longer applies.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> index 212e663..8496101 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> @@ -178,16 +178,7 @@
>   
>   				vddio_sdmmc: ldo2 {
>   					regulator-name = "VDDIO_SDMMC";
> -					/*
> -					 * Technically this supply should have
> -					 * a supported range from 1.8 - 3.3 V.
> -					 * However, that would cause the SDHCI
> -					 * driver to request 2.7 V upon access
> -					 * and that in turn will cause traffic
> -					 * to be broken. Leave it at 3.3 V for
> -					 * now.
> -					 */
> -					regulator-min-microvolt = <3300000>;
> +					regulator-min-microvolt = <1800000>;
>   					regulator-max-microvolt = <3300000>;
>   					regulator-always-on;
>   					regulator-boot-on;
> 
