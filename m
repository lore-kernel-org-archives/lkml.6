Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeEMPnT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 11:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeEMPnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 11:43:12 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/5] soc: samsung: Stuff for v4.18
Date: Sun, 13 May 2018 17:42:35 +0200
Message-Id: <20180513154238.22508-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.18

for you to fetch changes up to b2b568c591ddbb20d597e256212579d70dbf3000:

  soc: samsung: pm_domains: Deprecate support for clocks (2018-04-17 17:25:42 +0200)

----------------------------------------------------------------
Samsung soc drivers changes for v4.18

1. Clock operations during power domain on/off were moved to respective
   clock driver so clean up obsolete code from power domain driver.

----------------------------------------------------------------
Marek Szyprowski (1):
      soc: samsung: pm_domains: Deprecate support for clocks

 .../devicetree/bindings/power/pd-samsung.txt       | 20 +----
 drivers/soc/samsung/pm_domains.c                   | 90 +---------------------
 2 files changed, 5 insertions(+), 105 deletions(-)
