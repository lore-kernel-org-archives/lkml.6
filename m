Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeCYMLS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 08:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbeCYMLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 08:11:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4217217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [GIT PULL] ARM: exynos: mach for v4.17, part two
Date: Sun, 25 Mar 2018 14:10:49 +0200
Message-Id: <20180325121049.15357-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Second pull request for mach code. On top of previous pull request.


Best regards,
Krzysztof


The following changes since commit cc14b2b1f0b98926b6640bdd66861188ded850eb:

  ARM: EXYNOS: Extend cpuidle support to Midas boards (2018-02-19 17:55:49 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.17-2

for you to fetch changes up to ae35c4835699933335e76ab2d6a245303592ceea:

  ARM: EXYNOS: Simplify code in coupled CPU idle hot path (2018-03-21 18:51:39 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v4.17, part two

1. Fix coupled CPU idle freeze on Exynos4210.
2. Simplify hot-path in coupled CPU idle.

----------------------------------------------------------------
Marek Szyprowski (2):
      ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
      ARM: EXYNOS: Simplify code in coupled CPU idle hot path

 arch/arm/mach-exynos/pm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
