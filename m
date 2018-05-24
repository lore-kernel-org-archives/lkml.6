Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034267AbeEXSUw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034251AbeEXSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:20:44 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.18
Date: Thu, 24 May 2018 20:20:15 +0200
Message-Id: <20180524182016.5866-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 83cb529b2ef4f3446e60e75522d76fdaaea4724c:

  ARM: dts: exynos: Update x and y properties for mms114 touchscreen (2018-05-13 15:15:49 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.18-2

for you to fetch changes up to 68605101460ea4c62a966b1ad3e8db90d8fbaa31:

  ARM: dts: exynos: Add support for audio over HDMI for Odroid X/X2/U3 (2018-05-15 18:46:14 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.18, part 2

1. Add support for audio over HDMI for Odroid X/X2/U3.

----------------------------------------------------------------
Sylwester Nawrocki (1):
      ARM: dts: exynos: Add support for audio over HDMI for Odroid X/X2/U3

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 +++++++++++++++----------
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  6 ++---
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  6 ++---
 3 files changed, 26 insertions(+), 19 deletions(-)
