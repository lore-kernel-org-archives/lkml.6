Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbeD3V16 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:27:58 -0400
Received: from anholt.net ([50.246.234.109]:40762 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755085AbeD3V14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:27:56 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 1/3] bcm2835-dt-next-2018-04-30
Date: Mon, 30 Apr 2018 14:27:48 -0700
Message-Id: <20180430212750.12303-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-04-30

for you to fetch changes up to bdd6d1fe1cd84806429467ce62a735bdc6bdbae7:

  arm64: dts: broadcom: Add reference to Raspberry Pi 3 B+ (2018-04-23 15:03:07 -0700)

----------------------------------------------------------------
This pull request brings in Raspberry Pi 3 B+ support and connects
HDMI hotplug, LEDs, and wifi/bluetooth on the Raspberry Pi 3.

----------------------------------------------------------------
Stefan Wahren (5):
      ARM: dts: bcm283x: Fix PWM pin assignment
      ARM: dts: bcm2837: Add missing GPIOs of Expander
      dt-bindings: bcm: Add Raspberry Pi 3 B+
      ARM: dts: bcm2837: Add Raspberry Pi 3 B+
      arm64: dts: broadcom: Add reference to Raspberry Pi 3 B+

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   6 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   6 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   6 --
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   6 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         | 108 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  26 ++++-
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi         |  27 ++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts     |   2 +
 14 files changed, 205 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
