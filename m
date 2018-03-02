Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933549AbeCBWtS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:49:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52371 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932936AbeCBWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:49:13 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/6] MIPS: add support for Microsemi MIPS SoCs
Date: Fri,  2 Mar 2018 23:48:05 +0100
Message-Id: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds initial support for the Microsemi MIPS SoCs. It
is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).

Changes in v4:
 - dropped the reset driver as it has already been taken
 - Updated the MAINTAINERS entry (new files, changed email address)
 - moved to the MIPS generic infrastructure
 - corrected the cpu compatible in ocelot.dtsi

Alexandre Belloni (6):
  dt-bindings: Add vendor prefix for Microsemi Corporation
  dt-bindings: mips: Add bindings for Microsemi SoCs
  MIPS: mscc: add ocelot dtsi
  MIPS: mscc: add ocelot PCB123 device tree
  MIPS: generic: Add support for Microsemi Ocelot
  MAINTAINERS: Add entry for Microsemi MIPS SoCs

 Documentation/devicetree/bindings/mips/mscc.txt    |  44 +++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   9 ++
 arch/mips/Makefile                                 |   4 +
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/mscc/Makefile                   |   3 +
 arch/mips/boot/dts/mscc/ocelot.dtsi                | 110 +++++++++++++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |  27 +++++
 arch/mips/configs/generic/board-ocelot.config      |  40 ++++++++
 arch/mips/generic/Kconfig                          |  17 ++++
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ocelot.c                   |  83 ++++++++++++++++
 12 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/generic/board-ocelot.c

-- 
2.16.2
