Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0975C2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfBONte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:49:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45059 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfBONte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:49:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so821621qtg.12;
        Fri, 15 Feb 2019 05:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBw/Pod8wkX1IQvxEqgRS7Wflvc/zg8OZbViWAWKiwc=;
        b=ZEYnAZ9Kv9JyhmHtUPPFOM9UTWpPhkIHd1CJ0SXaHuF0TFc7ZfP+hcQe/hxhjepwNf
         DhAwMrZn5ySFeb4AcAnmP95K825pguA1DHwuu09Ed5L93lVdyQarubS01lwaH81yv7Jk
         VkSNilvQUydEJv39hB6OwDc1hEBL6JVcqdz5eZK6s3gBK+dorAcA+pQ4Wh5Emd8F70yh
         QSpDqrL5AHZzrtqXXpMnrx2TwaWrSQie2B4r36DB2+ysNNs/vCKfBK8y/fS93eCnosVI
         x5AFpMElrmHFynGdk5PSE0g7ink/JHbOK9yZ6RWyoQ3+baRIvZXUP77lO8nMp6NZsO/R
         LXYg==
X-Gm-Message-State: AHQUAuawCrJnI4fKmRg7xR3sITel0y323nAFo53ezo+Cftco95Cy23XX
        W1kEf+FSQv/l+YL49djf1w2w5vPs8WuTvXcNBKU=
X-Google-Smtp-Source: AHgI3IbeFe+r4HyFHx44vkZKdIRTU7h6NrfDjfOxxvffjZcye+3b9jRoeeWomm1r+k95UghXCijssgqk3Gu4PfclTvw=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7462381qtb.319.1550238573419;
 Fri, 15 Feb 2019 05:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201191720.20464-1-krzk@kernel.org> <20190201191720.20464-2-krzk@kernel.org>
In-Reply-To: <20190201191720.20464-2-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 14:49:16 +0100
Message-ID: <CAK8P3a0CXTc0tAPXcA31EtdFWEANj5c1RbzfkQJMp3RmKg0nWQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] ARM: dts: samsung: exynos and s5pv210 for v5.1
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

On Fri, Feb 1, 2019 at 8:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung DTS ARM changes for v5.1
>
> 1. Extend support for Aries family of mobile devices (e.g. Samsung
>    Galaxy S) based on S5Pv210 SoC: DRM Rotator, FIMD, PWM vibrator,
>    power off, touchscreen, Broadcom BCM4329 Bluetooth and cpufreq.
> 2. Remove hardcoded bootargs on Galaxy S family (proper support in
>    U-Boot).
> 3. Fix minor DTC warnings.
> 4. Fix Exynos4412 Odroid X2/U3 conflicting eMMC GPIO settings and regulator
>    properties.
> 5. Fix the eMMC RTSN pin breaking proper reboot on X2.


Pulled into arm/dt, thanks!

     Arnd
