Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4736C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676CC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676CC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeFTTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:17:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54282 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbeFTTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:17:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so1234260wmf.4;
        Wed, 20 Jun 2018 12:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E9EyRwSJnUpCEk/2A6wVFU9WYQvJ+qpnxTqXXMdu3eA=;
        b=Hqke3RcH6X0sg5JlXvYn/tKRrRsaYZSXN4EaisbbO9AN0IsuYWqDWg6vOGWYQHTeWi
         lTX1faHUe4hZe2lHXLhjRoulQZRoL3ytSPfVJZ0389JULAeEYJYde0a0G+eKbyX2oQOZ
         OeYVl3zJzAbsPREoRPsmsgnaji8lVEEO8fK9WLsfPH1JZZy3tu4Ei3Yk9ibTgmYfejBB
         SoZ5E8WG9KZz4nJ3thNEhDZXYWsGGQUqI5myGs2vqxsMjuG1oEQoONu7KwJlb1dkdHdC
         qQ9FVH09NnITjp2J7QtuAzXr7FBOr1GCZaFyTHKhrAlTTCdXxh63yuEEMKudTKDk3o4O
         GHoA==
X-Gm-Message-State: APt69E14lQImRY1eAGIO6W2FHn7PmJ4nGO4Hbb1qwf3knzWztGzXxPCS
        RXJfLS0LIw349q56P958fLo=
X-Google-Smtp-Source: ADUXVKJoX/A1HJY2x41Aa7u/kPanuUyc5ilvNzFqsYG+JaBeCSKufjDGqBOkbHg49NdAkjG41wPq4w==
X-Received: by 2002:a50:9235:: with SMTP id i50-v6mr19066594eda.27.1529522243149;
        Wed, 20 Jun 2018 12:17:23 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id c46-v6sm1660611edc.34.2018.06.20.12.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:17:22 -0700 (PDT)
Date:   Wed, 20 Jun 2018 21:17:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Message-ID: <20180620191720.kywnok5ahod3zmmk@kozik-lap>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0@epcas1p4.samsung.com>
 <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 12:12:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed samsung thermal properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos4.dtsi                    |  2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                 |  8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                 | 10 +++++-----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5440.dtsi                 |  6 +++---
>  9 files changed, 15 insertions(+), 76 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>

A lot of changes came in recently so this does not apply anymore. Could
you rebase on my for-next branch?

Best regards,
Krzysztof

