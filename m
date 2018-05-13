Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeEMPnL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 11:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeEMPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 11:43:10 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/5] ARM: defconfig: Exynos for v4.18
Date: Sun, 13 May 2018 17:42:34 +0200
Message-Id: <20180513154238.22508-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.18

for you to fetch changes up to b0121046cacdbc99475871aceb2e9e57995c2ba1:

  ARM: multi_v7_config: enable S6E63J0X03 panel driver (2018-04-16 20:22:28 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v4.18

1. Enable Samsung S6E63J0X03 DSI panel.

----------------------------------------------------------------
Marek Szyprowski (2):
      ARM: exynos_defconfig: enable S6E63J0X03 panel driver
      ARM: multi_v7_config: enable S6E63J0X03 panel driver

 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)
