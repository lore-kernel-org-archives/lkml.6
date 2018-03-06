Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbeCFSB6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753747AbeCFSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:01:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521B521799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] soc: samsung: Driver changes for v4.17
Date: Tue,  6 Mar 2018 19:01:21 +0100
Message-Id: <20180306180124.8987-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180306180124.8987-1-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.17

for you to fetch changes up to 7353c54620732797dcc3b4b1fc6f3cc0c0d9b6ef:

  soc: samsung: pmu: Populate children syscon nodes (2018-02-13 18:47:25 +0100)

----------------------------------------------------------------
Samsung soc drivers changes for v4.17

1. Add SPDX license identifiers.
2. Populate children syscon nodes in PMU driver to properly model HW in
   DeviceTree.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      memory: samsung: Add SPDX license identifiers
      soc: samsung: Add SPDX license identifiers to headers
      soc: samsung: pmu: Populate children syscon nodes

 Documentation/devicetree/bindings/arm/samsung/pmu.txt |  6 ++++++
 drivers/memory/samsung/Kconfig                        |  1 +
 drivers/memory/samsung/Makefile                       |  1 +
 drivers/memory/samsung/exynos-srom.c                  | 18 +++++++-----------
 drivers/memory/samsung/exynos-srom.h                  |  7 ++-----
 drivers/soc/samsung/exynos-pmu.c                      |  7 +++++++
 include/linux/soc/samsung/exynos-pmu.h                |  5 +----
 include/linux/soc/samsung/exynos-regs-pmu.h           |  6 +-----
 8 files changed, 26 insertions(+), 25 deletions(-)
