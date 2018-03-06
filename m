Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeCFSCD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754003AbeCFSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:02:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3527321795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] arm64: dts: exynos: DTS for v4.17
Date: Tue,  6 Mar 2018 19:01:23 +0100
Message-Id: <20180306180124.8987-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180306180124.8987-1-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.17

for you to fetch changes up to 6ca620371ab2dab89a7645fc363453d2e26c992e:

  arm64: dts: exynos: add OF graph between MHL and USB connector (2018-03-06 17:48:07 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.17

1. Add support for HDMI audio on Exynos 5433 TM2/TM2E boards.
2. Add support for USB-MHL connector on Exynos 5433 TM2/TM2E boards.

----------------------------------------------------------------
Andrzej Hajda (2):
      arm64: dts: exynos: add micro-USB connector node to TM2 platforms
      arm64: dts: exynos: add OF graph between MHL and USB connector

Sylwester Nawrocki (3):
      ARM: dts: exynos: Add I2S1 device node to exynos5433
      ARM: dts: exynos: Update I2S0 device node in exynos5433
      ARM: dts: exynos: Add support for HDMI audio on Exynos 5433 TM2 board

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 90 ++++++++++++++++++++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 24 +++++-
 2 files changed, 106 insertions(+), 8 deletions(-)
