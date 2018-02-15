Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032993AbeBONl7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:41:59 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:56937 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1032831AbeBONlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:41:44 -0500
From: Tali Perry <tali.perry1@gmail.com>
To: brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        raltherr@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v2 0/1] *clk: npcm750: add clock header to patch, fix typos and content in dt-binding txt
Date: Thu, 15 Feb 2018 15:39:18 +0200
Message-Id: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM7xx clock driver.

Nuvoton BMC NPCM7xx contain integrated clock controller which
generates and supplies clock to all modules within the NPCM7xx BMC

1 ==> 2
This patch includes fix request described here:
https://lkml.org/lkml/2018/2/8/739
(add clock header to patch, fix typos and content in dt-binding txt)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (1):
  clk: npcm750: update text with fixed clocks

 .../bindings/clock/nuvoton,npcm750-clk.txt         | 103 +++++++++++++++++++++
 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  51 ++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

-- 
2.14.1
