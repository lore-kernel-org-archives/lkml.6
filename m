Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEMPrl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 11:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbeEMPrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 11:47:40 -0400
X-Google-Smtp-Source: AB8JxZp6mMjr7pQG/klVDHU2FoIxOaO/lE49nKbOVEXdYzw5pKrckxlXHQo+4LY/9Nmpt7/f2GRaDhV3/q1nwU/7Gb4=
MIME-Version: 1.0
In-Reply-To: <20180513154238.22508-6-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org> <20180513154238.22508-6-krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 13 May 2018 17:47:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfn5VTR5=qiHwC=gRKohGJ5db_2sgni5YOdOHEZz3Vsvw@mail.gmail.com>
Message-ID: <CAJKOXPfn5VTR5=qiHwC=gRKohGJ5db_2sgni5YOdOHEZz3Vsvw@mail.gmail.com>
Subject: Re: [GIT PULL 5/5] ARM: exynos: mach/soc for v4.18
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 5:42 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.18
>
> for you to fetch changes up to 9ad9a2183bf51da7f8840f2e7087816c0fc8c91d:
>
>   ARM: exynos: Remove unused soc_is_exynos{4,5} (2018-05-13 14:07:03 +0200)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.18
>
> 1. Remove at24_platform_data in S3C2440.
> 2. Fix invalid SPDX identifier.
> 3. Remove Exynos5440 entirely.
> 4. Cleanups.
> 5. Remove static mapping of SCU SFR and rely on DTS.
>
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (1):
>       ARM: exynos: no need to select ARCH_HAS_BANDGAP any longer
>
> Bartosz Golaszewski (1):
>       ARM: s3c24xx: mini2440: Use device properties for at24 eeprom
>
> Krzysztof Kozlowski (1):
>       ARM: exynos: Remove support for Exynos5440

I forgot to mention here possible conflict with dma-mapping tree and
its commit 4965a68780c5 ("arch: define the ARCH_DMA_ADDR_T_64BIT
config symbol in lib/Kconfig"). Since Exynos5440 is going away,
conflict is easy to solve - just remove.

Best regards,
Krzysztof
