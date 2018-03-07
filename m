Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934243AbeCGPxM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:53:12 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45578 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeCGPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:53:07 -0500
X-Google-Smtp-Source: AG47ELtRhoUJV7TY7cBw9aBomMquj/SBN0JVoub8bscd00Y+OZNMaOU2jMNeLOqH6CsqyRI+bKgP6hyeefDj8XSr/Rc=
MIME-Version: 1.0
In-Reply-To: <20180306180124.8987-2-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org> <20180306180124.8987-2-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:53:06 +0100
X-Google-Sender-Auth: s4nTEQYXPhqSl6wYXkK-ay6ey58
Message-ID: <CAK8P3a3_izoJZi87y0hk+MD_6HL1EyR=acJtDGh3LDEYvDHaHg@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] soc: samsung: Driver changes for v4.17
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.17
>
> for you to fetch changes up to 7353c54620732797dcc3b4b1fc6f3cc0c0d9b6ef:
>
>   soc: samsung: pmu: Populate children syscon nodes (2018-02-13 18:47:25 +0100)
>
> ----------------------------------------------------------------
> Samsung soc drivers changes for v4.17
>
> 1. Add SPDX license identifiers.
> 2. Populate children syscon nodes in PMU driver to properly model HW in
>    DeviceTree.

Pulled into next/drivers, thanks!

          Arnd
