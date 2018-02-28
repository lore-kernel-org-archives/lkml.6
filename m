Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935129AbeB1Vjx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:39:53 -0500
Received: from anholt.net ([50.246.234.109]:34548 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935101AbeB1Vjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:39:51 -0500
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 1/2] bcm2835-dt-next-2018-02-28
Date: Wed, 28 Feb 2018 13:39:44 -0800
Message-Id: <20180228213945.6781-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-02-28

for you to fetch changes up to bcc76c4014dce4e3834dbd5b7f6593cbcfbfebe0:

  ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode (2018-02-26 15:02:23 -0800)

----------------------------------------------------------------
This pull request adds automatic BT probing to the Pi Zero W, OTG mode
for the Zero W, the GPIO expander on the Pi3, and fixes I2S probe
(which is disabled by default, but often used downstream)

----------------------------------------------------------------
Baruch Siach (2):
      ARM: dts: bcm2835: make the firmware node into a bus
      ARM: dts: bcm2837-rpi-3-b: add GPIO expander

Henry Zhang (1):
      ARM: dts: bcm283x: Fix pin function of JTAG pins

Stefan Wahren (5):
      dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
      ARM: dts: bcm283x: Fix probing of bcm2835-i2s
      ARM: dts: bcm283x: Apply pull settings to Zero W relevant groups
      ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
      ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode

 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt        |  4 ++--
 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt      |  9 ++++-----
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts                | 16 ++++++++++++++--
 arch/arm/boot/dts/bcm2835-rpi.dtsi                      |  4 +++-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts                   | 17 +++++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi                          |  9 ++++++---
 6 files changed, 46 insertions(+), 13 deletions(-)
