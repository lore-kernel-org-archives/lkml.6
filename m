Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033147AbeBOONk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:13:40 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:56972 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1032782AbeBOONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:13:39 -0500
From: Tali Perry <tali.perry1@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        avifishman70@gmail.com, tmaimon77@gmail.com, raltherr@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v2 0/1] clk: npcm: add NPCM7xx clock driver
Date: Thu, 15 Feb 2018 15:30:53 +0200
Message-Id: <1518701454-22697-1-git-send-email-tali.perry1@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM7xx clock driver.

Nuvoton BMC NPCM7xx contain integrated clock controller which
generates and supplies clock to all modules within the NPCM7xx BMC

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (1):
  clk: npcm7xx: add clock controller. fixed clock at DT

 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm7xx.c | 759 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 760 insertions(+)
 create mode 100644 drivers/clk/clk-npcm7xx.c

-- 
2.14.1
