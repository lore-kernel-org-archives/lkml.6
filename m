Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0590CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42122086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfBTPLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:11:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46265 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:11:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id z25so5786678qti.13;
        Wed, 20 Feb 2019 07:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEEPtxp2Y5ETsK7WypMIxYWNL9klWIeujbQUbiSChoA=;
        b=j24t8XbTXYW+Pb/a9+rGLglDRVdALn50WzCH0cEkBUNQUxOv3j7hgUOSZ/CyUJAgsV
         A2lmebYuxNgUwvrk1NW2Oj1ZBFT6iHapR4WCSzUuu4F42hi4oOFzrnFNV4UrwZ5OW3Xr
         bpufn/DMLRY36sHar2t17+OMDAEtYru845SrRpW9sTZSWcXKYtBXT/lggoxLc4qo844s
         HhEsZ1pfqJRlMlE3le8nyExYyvNzYJjzg5G383Q4YTg038m/AW0TtuzVBeM8M1LpMjgP
         5j813fUe0goU/x0yR4SuneXZHkzlrkuNpQOMut4C3FuroAqRFkLEDC8OzXv5BKbwrCuN
         QUfg==
X-Gm-Message-State: AHQUAubdIPXd5UBhI2I+MuyDYCjXZpkDRp0tBzlCNY6kP6ndUWYxVtG7
        o/TsYgfO3NyWyopi50tJDLfL1tPslscl5HCI7VB3/Q==
X-Google-Smtp-Source: AHgI3IZMvoSZ2OHJb3c4jDm41Od5dyIXeWsOpBdmcvqIcFOSNL+hKjF5qoDXdNpMuOFHuO9pWttlANvGB8Lcotegpr0=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr27002924qtb.319.1550675495036;
 Wed, 20 Feb 2019 07:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20190219185214.5544-1-krzk@kernel.org>
In-Reply-To: <20190219185214.5544-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 16:11:16 +0100
Message-ID: <CAK8P3a06-C5TpkSnnvgFTbiXX6FdcOU4RMFVr62YAxm+LEtrbA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: exynos: Second pull for v5.1
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 7:52 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit ec33745bccc8f336957c751f4153421cc9ef5a54:
>
>   ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3 (2019-01-25 20:18:10 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.1-2
>
> for you to fetch changes up to 625c731d1b2af487fc6be10b9a505699c045813a:
>
>   ARM: dts: exynos: Add support for secondary DAI to Odroid XU4 (2019-02-18 20:52:25 +0100)
>
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v5.1, part 2
>
> 1. Enable ADC on Odroid HC1 board.
> 2. Fix clkout register failure on Exynos3250.
> 3. Allow using earlycon on Arndale board.
> 4. Disable ARM PMU on Odroid XU3 Lite because it is locked by Trusted
>    Firmware.
> 5. Add support for secondary DAI to Odroid XU3 and XU4 boards.


Pulled into arm/dt, thanks!

      Arnd
