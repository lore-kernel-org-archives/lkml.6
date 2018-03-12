Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbeCLQLM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:11:12 -0400
Received: from h1.radempa.de ([176.9.142.194]:56630 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932147AbeCLQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:11:09 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com,
        Harald Geyer <harald@ccbib.org>
Subject: arm64: allwinner: Add support for TERES I laptop
Date: Mon, 12 Mar 2018 16:10:45 +0000
Message-Id: <20180312161050.7647-1-harald@ccbib.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the TERES I open hardware laptop produced
by olimex. With these patches and a bootloader capable of setting up
simple framebuffer the laptop is quite useable.

Patches 1-4 add some pin descriptions and devices in the A64 dtsi, which
are useful to have on the teres.
Patch 5 finally adds the board dts itself.

best regards,
Harald

Harald Geyer (5):
  arm64: dts: allwinner: a64: Add i2c0 pins
  arm64: dts: allwinner: a64: Add watchdog
  arm64: dts: allwinner: a64: add simplefb for A64 SoC
  arm64: dts: allwinner: a64: Add pwm device
  arm64: allwinner: a64: Add support for TERES I laptop

 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 308 +++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  44 +++
 3 files changed, 353 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts

-- 
2.11.0
