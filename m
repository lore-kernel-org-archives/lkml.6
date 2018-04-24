Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbeDXLrW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:47:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38171 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeDXLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:47:18 -0400
X-Google-Smtp-Source: AIpwx4+1Xp/yA7CiISlRu7uylwdinw+geo8MXpdm63KxI15J0vj38eGA6leWlGHB6IWn4W/i4PC4Eg==
From: Neil Armstrong <narmstrong@baylibre.com>
To: maxime.ripard@bootlin.com, wens@csie.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: allwinner: Add support for Libre Computer Board ALL-H3-CC H5 ver.
Date: Tue, 24 Apr 2018 13:47:12 +0200
Message-Id: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
Pi B+ form factor single board computer based on the Allwinner H2+, H3,
or H5 SoCs with the same PCB.
The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
and connectors are in the exact same position as on the Raspberry Pi B+.

This patchset enables the H5 variant by moving the H3 board definition to
a common dtsi then include this common dtsi in the H5 dts variant then
declares the correct compatible and model of the H5 variant.

Changes since v1:
- Rebase on sunxi-for-next
- Fix commit log and subject

Neil Armstrong (2):
  arm: dts: sun8i: h3: libretech-all-h3-cc: Move board definition to
    common dtsi
  arm64: dts: allwinner: Add dts file for Libre Computer Board ALL-H3-CC
    H5 ver.

 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 213 +-------------------
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 215 +++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    |  14 ++
 4 files changed, 232 insertions(+), 211 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

-- 
2.7.4
