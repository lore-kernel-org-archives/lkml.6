Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEMPnn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 11:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbeEMPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 11:43:18 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 5/5] ARM: exynos: mach/soc for v4.18
Date: Sun, 13 May 2018 17:42:38 +0200
Message-Id: <20180513154238.22508-6-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.18

for you to fetch changes up to 9ad9a2183bf51da7f8840f2e7087816c0fc8c91d:

  ARM: exynos: Remove unused soc_is_exynos{4,5} (2018-05-13 14:07:03 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.18

1. Remove at24_platform_data in S3C2440.
2. Fix invalid SPDX identifier.
3. Remove Exynos5440 entirely.
4. Cleanups.
5. Remove static mapping of SCU SFR and rely on DTS.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: exynos: no need to select ARCH_HAS_BANDGAP any longer

Bartosz Golaszewski (1):
      ARM: s3c24xx: mini2440: Use device properties for at24 eeprom

Krzysztof Kozlowski (1):
      ARM: exynos: Remove support for Exynos5440

Pankaj Dubey (2):
      ARM: exynos: Remove static mapping of SCU SFR
      ARM: exynos: Remove unused soc_is_exynos{4,5}

Thomas Gleixner (1):
      ARM: s3c24xx: Fix invalid SPDX identifier

Wolfram Sang (1):
      ARM: samsung: simplify getting .drvdata

 arch/arm/mach-exynos/Kconfig                 | 13 ----------
 arch/arm/mach-exynos/common.h                | 17 ++++---------
 arch/arm/mach-exynos/exynos.c                | 37 ++--------------------------
 arch/arm/mach-exynos/include/mach/map.h      |  2 --
 arch/arm/mach-exynos/platsmp.c               | 27 +++++++++++++++-----
 arch/arm/mach-exynos/pm.c                    |  4 +--
 arch/arm/mach-exynos/suspend.c               |  4 +--
 arch/arm/mach-s3c24xx/h1940-bluetooth.c      |  2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c        | 10 ++++----
 arch/arm/plat-samsung/adc.c                  |  3 +--
 arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ---
 11 files changed, 37 insertions(+), 86 deletions(-)
