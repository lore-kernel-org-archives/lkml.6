Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBEJNb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:13:31 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:56624 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750962AbeBEJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:13:29 -0500
From: Tomer Maimon <tmaimon77@gmail.com>
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com, tali.perry1@gmail.com, avifishman70@gmail.com,
        brendanhiggins@google.com, joel@jms.id.au
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] clk: npcm: add NPCM7xx clock driver
Date: Mon,  5 Feb 2018 10:22:53 +0200
Message-Id: <1517818975-11427-1-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds clock support for the Nuvoton NPCM7xx Baseboard
Management Controller (BMC).

The clock controller generates the clocks for the Graphics Core,
Memory interface, CPU, AMBA buses and all the engine modules. 
The NPCM7xx includes four PLL modules. 
The clock source is selectable from either PLL or the external clock input. 
Several clock signals have a configurable divide from the clock source

Tomer Maimon (2):
  dt-binding: clock: document NPCM7xx clock DT bindings
  clk: npcm: add NPCM7xx clock driver

 .../bindings/clock/nuvoton,npcm7xx-clk.txt         |  84 +++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-npcm7xx.c                          | 751 +++++++++++++++++++++
 3 files changed, 836 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm7xx-clk.txt
 create mode 100644 drivers/clk/clk-npcm7xx.c

-- 
2.14.1
