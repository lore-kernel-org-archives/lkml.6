Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBYKP2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:15:28 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57265 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751095AbeBYKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:15:20 -0500
From: Tali Perry <tali.perry1@gmail.com>
To: brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        raltherr@google.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v10 0/3] NPCM750: clk controller, DT and binding
Date: Sun, 25 Feb 2018 12:12:16 +0200
Message-Id: <1519553539-15899-1-git-send-email-tali.perry1@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM7xx clock driver.

Nuvoton BMC NPCM7xx contain integrated clock controller which
generates and supplies clock to all modules within the NPCM7xx BMC

2 ==> 10
update documentation. add external clocks as inputs to clk driver.
fix SPDX comment.

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (3):
  NPCM750: add clock controller to DT
  NPCM750: add clock tree doc and binding
  NPCM750: add clock controller driver

 .../bindings/clock/nuvoton,npcm750-clk.txt         |  100 ++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi             | 1221 ++++++++++++++++++++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-npcm7xx.c                          |  757 ++++++++++++
 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |   44 +
 5 files changed, 2123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
 create mode 100644 drivers/clk/clk-npcm7xx.c
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

-- 
2.14.1
