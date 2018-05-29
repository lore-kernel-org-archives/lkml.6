Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeE2JBp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:01:45 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50678 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932541AbeE2JBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:01:14 -0400
From: Roger Quadros <rogerq@ti.com>
To: <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/5] ARM: dts: dra7/am7xx: USB fixes and enhancements
Date: Tue, 29 May 2018 12:00:53 +0300
Message-ID: <1527584458-6257-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

These are some fixes and enhancements for USB ports on dra7 and am57xx-idk EVMs.
If OK, please queue these for v4.18. Thanks.

Roger Quadros (5):
  ARM: dts: dra7: Disable metastability workaround for USB2
  ARM: dts: am57xx-idk: Enable dual role for USB2 port
  ARM: dts: dra7-evm: Add extcon to USB2 port
  ARM: dts: dra71-evm: Add VBUS GPIO to USB1/USB2 extcon
  ARM: dts: dra76-evm: Add VBUS GPIO to USB1/USB2 extcon

 arch/arm/boot/dts/am571x-idk.dts         |  4 ----
 arch/arm/boot/dts/am572x-idk-common.dtsi |  4 ----
 arch/arm/boot/dts/am57xx-idk-common.dtsi |  7 ++++++-
 arch/arm/boot/dts/dra7-evm-common.dtsi   | 10 ++++++++++
 arch/arm/boot/dts/dra7-evm.dts           |  9 ---------
 arch/arm/boot/dts/dra7.dtsi              |  2 +-
 arch/arm/boot/dts/dra71-evm.dts          |  8 ++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi  |  1 +
 arch/arm/boot/dts/dra76-evm.dts          |  8 ++++++++
 9 files changed, 34 insertions(+), 19 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
