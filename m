Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeD3LVR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:21:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50830 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeD3LVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:21:15 -0400
X-Google-Smtp-Source: AB8JxZrS7GPIGe4pHHAvOWmvl1vmiO0LaMYpD0U9ZzVzTdxRBeBVRooNcSJ1uwfBMiutKyiEEBEIBA==
From: Christina Quast <cquast@baylibre.com>
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com, Christina Quast <cquast@baylibre.com>
Subject: [PATCH 0/2] Add macro defines for AM335x
Date: Mon, 30 Apr 2018 13:20:04 +0200
Message-Id: <20180430112006.20861-1-cquast@baylibre.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the register offsets for am335x with macro defines.
The values are extraced from the "AM335x SitaraTM Processors Technical
Reference Manual".

Christina Quast (2):
  ARM: dts: am335x: Replace numeric pinmux address with macro defines
  ARM: dts: am335x: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  17 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  39 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  43 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   7 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 141 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  49 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi     | 105 +++----
 .../arm/boot/dts/am335x-boneblack-common.dtsi |  55 ++--
 .../boot/dts/am335x-boneblack-wireless.dts    |  29 +-
 arch/arm/boot/dts/am335x-boneblue.dts         | 105 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   5 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  29 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  67 ++---
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  35 +--
 arch/arm/boot/dts/am335x-cm-t335.dts          | 155 +++++-----
 arch/arm/boot/dts/am335x-evm.dts              | 221 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 279 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 117 ++++----
 arch/arm/boot/dts/am335x-igep0033.dtsi        |  41 +--
 arch/arm/boot/dts/am335x-lxm.dts              | 121 ++++----
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 117 ++++----
 arch/arm/boot/dts/am335x-nano.dts             | 141 ++++-----
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  75 ++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 171 +++++------
 arch/arm/boot/dts/am335x-pepper.dts           | 201 ++++++-------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  61 ++--
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 113 +++----
 arch/arm/boot/dts/am335x-shc.dts              | 225 +++++++-------
 arch/arm/boot/dts/am335x-sl50.dts             | 153 +++++-----
 arch/arm/boot/dts/am335x-wega.dtsi            |  69 ++---
 include/dt-bindings/pinctrl/am335x.h          | 236 +++++++++++++++
 31 files changed, 1744 insertions(+), 1478 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am335x.h

-- 
2.17.0
