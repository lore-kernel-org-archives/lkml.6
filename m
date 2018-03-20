Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeCTNnE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:43:04 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:58800 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753239AbeCTNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:43:01 -0400
From: tali.perry1@gmail.com
To: brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        raltherr@google.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v11 0/2] clk: npcm750: Add NPCM7XX Clock driver and binding
Date: Tue, 20 Mar 2018 15:40:47 +0200
Message-Id: <1521553249-6971-1-git-send-email-tali.perry1@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tali Perry <tali.perry1@gmail.com>


Nuvoton NPCM7XX Clock Controller

Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
generates and supplies clocks to all modules within the BMC.

---

10 ==> 11
update documentation. "eth" replaced with "ethernet" in use case eaxample.

2 ==> 10
update documentation. add external clocks as inputs to clk driver.
fix SPDX comment.

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>


Tali Perry (2):
  clk: npcm750: Add binding for Nuvoton NPCM7XX clock Controller
  clk: npcm7xx: Add Nuvoton NPCM7XX Clock Controller driver

 .../bindings/clock/nuvoton,npcm750-clk.txt         | 100 +++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-npcm7xx.c                          | 757 +++++++++++++++++++++
 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  44 ++
 4 files changed, 902 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
 create mode 100644 drivers/clk/clk-npcm7xx.c
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

-- 
2.14.1
