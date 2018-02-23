Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBWPA3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:00:29 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38767 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeBWPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:00:26 -0500
X-Google-Smtp-Source: AG47ELsYumfu8HQwlbPCNA89Z9XqMJb3w4aWGZqHBGa/e0p4LCfBGYJ/RyVpkQo+GOxpupJ8gdb0/w==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] arm: zynq: Adding new Xilinx boards
Date: Fri, 23 Feb 2018 16:00:18 +0100
Message-Id: <cover.1519398009.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset is adding 5 new dts files which target cc108 and zc770
boards.
Please let me know if you see any issue with them.

Series depends on this one patch
https://lkml.org/lkml/2018/2/23/412

Thanks,
Michal

Changes in v2:
- Record compatible string to xilinx.txt
- Record compatible string to xilinx.txt
- Record compatible string to xilinx.txt
- Record compatible string to xilinx.txt
- use eeprom as node name instead of at25
- Record compatible string to xilinx.txt

Michal Simek (5):
  arm: zynq: Add Xilinx cc108 board
  arm: zynq: Add support for Xilinx zc770 xm010 dc1 board
  arm: zynq: Add support for Xilinx zc770 xm011 dc2 board
  arm: zynq: Add support for Xilinx zc770 xm012 dc3 board
  arm: zynq: Add support for Xilinx zc770 xm013 dc4 board

 Documentation/devicetree/bindings/arm/xilinx.txt | 11 +++
 arch/arm/boot/dts/Makefile                       |  5 ++
 arch/arm/boot/dts/zynq-cc108.dts                 | 75 +++++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm010.dts           | 92 ++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm011.dts           | 64 +++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm012.dts           | 64 +++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm013.dts           | 78 ++++++++++++++++++++
 7 files changed, 389 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-cc108.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm011.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts

-- 
1.9.1
