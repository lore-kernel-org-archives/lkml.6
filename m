Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032989AbeBONnv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:43:51 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:56959 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1032856AbeBONnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:43:49 -0500
From: Tali Perry <tali.perry1@gmail.com>
To: brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        raltherr@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v2 0/1] clk: npcm: move fixed clocks to DT
Date: Thu, 15 Feb 2018 15:41:54 +0200
Message-Id: <1518702115-22990-1-git-send-email-tali.perry1@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed clocks defined at driver/clk/clk-npcm7xx.c moved to DT. 

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (1):
  npcm750: add fixed clocks (moved from drivers/clk/clk-npcm7xx.c)

 arch/arm/boot/dts/nuvoton-npcm750.dtsi | 1223 ++++++++++++++++++++++++++++++++
 1 file changed, 1223 insertions(+)
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi

-- 
2.14.1
