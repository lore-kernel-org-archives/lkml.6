Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeCFSCE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753986AbeCFSCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:02:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423F2179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] ARM: exynos: mach for v4.17
Date: Tue,  6 Mar 2018 19:01:24 +0100
Message-Id: <20180306180124.8987-5-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180306180124.8987-1-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.17

for you to fetch changes up to cc14b2b1f0b98926b6640bdd66861188ded850eb:

  ARM: EXYNOS: Extend cpuidle support to Midas boards (2018-02-19 17:55:49 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v4.17

1. Add few remaining SPDX license identifiers.
2. Add cpuidle support to all Midas-based boards (including new
   GT-I9300/GT-I9305/GT-N7100/GT-N7105).

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: EXYNOS: Add SPDX license identifiers

Simon Shields (1):
      ARM: EXYNOS: Extend cpuidle support to Midas boards

 arch/arm/include/debug/exynos.S  |  7 ++-----
 arch/arm/include/debug/samsung.S | 10 +++-------
 arch/arm/mach-exynos/exynos.c    |  3 ++-
 include/linux/serial_s3c.h       | 17 ++---------------
 4 files changed, 9 insertions(+), 28 deletions(-)
