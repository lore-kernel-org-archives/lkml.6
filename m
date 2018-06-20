Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8053BC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BF52083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BF52083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeFTTTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:19:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34442 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754548AbeFTTTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:19:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so433003wmc.1;
        Wed, 20 Jun 2018 12:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsrTUAvi+lZm0DI3GWnK+oi5v82rTFvIrU0s4yweDbU=;
        b=frVtZ73nLmH3mvy9dZU2/Y4iCBBHNn+aT6BCr9QlIAZKdtLtnQeS7XZi4Asqwm4f0p
         au+3bM7icrDSLFz6YR+m0GSxsrr0YqnHKG1ihOMXm9uQZ1ABnYD90och31zYHEFGgHhL
         Fa3Xin1nbeDfTBSp8QS5OeIxVromxzQZHIjDJ2sjc+NO/INy4Rs66+tU458wbtv5uWgh
         FmtxtR/2r2FqA0gKi0hWqxY5CgyAZur668p6L4K08Qf4OfybdiQFnEC5OAMtL7d9pudB
         OtBTNeYtlWhk1znhjuNBzYCFqRCvdemS76qGDc7lobIGzsdweKTd9oXOYfdVKivw0sR5
         nlxQ==
X-Gm-Message-State: APt69E3Muw+x1mToDrFrhJU6ObgLFOnmQA3z3HNr6TA+g2XZsbi1eZdC
        r7qYcQSaOfLUmhsxqi72tro=
X-Google-Smtp-Source: ADUXVKLXAPaCd6b5l+IU+npZepoeqO1ZpTVaj1HpWutN39IW5mt9Z5EWjppFv4sKQI8jv2ID712j3g==
X-Received: by 2002:a50:aa2f:: with SMTP id o44-v6mr19045642edc.186.1529522387892;
        Wed, 20 Jun 2018 12:19:47 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id x11-v6sm1854800edb.39.2018.06.20.12.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:19:47 -0700 (PDT)
Date:   Wed, 20 Jun 2018 21:19:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] arm64: dts: exynos: remove no longer needed
 samsung thermal properties
Message-ID: <20180620191945.lesqbvweltupnvf3@kozik-lap>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6@epcas1p1.samsung.com>
 <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 12:12:05PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove no longer needed samsung thermal properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
>  .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 10 +++++-----
>  .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
>  arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
>  5 files changed, 6 insertions(+), 66 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
> 

Thanks, applied.

Best regards,
Krzysztof

