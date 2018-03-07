Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933986AbeCGPia (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:38:30 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33322 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933749AbeCGPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:38:27 -0500
X-Google-Smtp-Source: AG47ELvwOSLBMpmaPFpuv2tgcbXElbElOwsiGrdMpSIWNju92MCBSCPjxh69HGnYRCSs9elzpHltwpxFW1s8DpzQ5aw=
MIME-Version: 1.0
In-Reply-To: <20180306180124.8987-4-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org> <20180306180124.8987-4-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:38:25 +0100
X-Google-Sender-Auth: iaIG74CvTC9jD_oZbdDlywA_QNo
Message-ID: <CAK8P3a32AsvfdLubV-_B=1DKYFjVfVRR6TuwRcE8cH3o1S_H1Q@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] arm64: dts: exynos: DTS for v4.17
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 7:01 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.17
>
> for you to fetch changes up to 6ca620371ab2dab89a7645fc363453d2e26c992e:
>
>   arm64: dts: exynos: add OF graph between MHL and USB connector (2018-03-06 17:48:07 +0100)
>
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v4.17
>
> 1. Add support for HDMI audio on Exynos 5433 TM2/TM2E boards.
> 2. Add support for USB-MHL connector on Exynos 5433 TM2/TM2E boards.

Pulled into next/dt, thanks!

       Arnd
