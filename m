Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBBODE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:03:04 -0500
Received: from hermes.aosc.io ([199.195.250.187]:48224 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeBBOCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:02:55 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Allwinner V3s audio codec device tree changes
Date: Fri,  2 Feb 2018 22:01:50 +0800
Message-Id: <20180202140153.21549-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the Allwinner V3s audio codec device tree changes, which used to
be blocked by the DMA engine code.

The first patch adds the DMA engine device tree node, and the second
adds the codec nodes (digital and analog).

The thrid patch is for Lichee Pi Zero with Dock board to enable the
audio jack and on-board mic.

Icenowy Zheng (3):
  ARM: dts: sun8i: add DMA engine in V3s DTSI
  ARM: dts: sun8i: add audio codec support into V3s DTSI
  ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock board

 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  9 +++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 28 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.15.1
