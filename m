Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeCGPaz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:30:55 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33493 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933888AbeCGPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:30:50 -0500
X-Google-Smtp-Source: AG47ELuiRxVLeisE3gB5G1lEgXTcgkgS9ajWi0UFVER5hpyYklCHT1DwRnoEWDkbn4DUwx86vMRpCfjQU1Thoda5FOU=
MIME-Version: 1.0
In-Reply-To: <20180306180124.8987-5-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org> <20180306180124.8987-5-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:30:48 +0100
X-Google-Sender-Auth: cz2kmgTM0ZIu1DbSfTM261uMfPs
Message-ID: <CAK8P3a14jEtA2uDLOWgA_+WEpinU1kUo2nxqRO6aNQb7zxNu0w@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] ARM: exynos: mach for v4.17
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.17
>
> for you to fetch changes up to cc14b2b1f0b98926b6640bdd66861188ded850eb:
>
>   ARM: EXYNOS: Extend cpuidle support to Midas boards (2018-02-19 17:55:49 +0100)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.17
>
> 1. Add few remaining SPDX license identifiers.
> 2. Add cpuidle support to all Midas-based boards (including new
>    GT-I9300/GT-I9305/GT-N7100/GT-N7105).

Pulled into next/soc, thanks!

         Arnd
