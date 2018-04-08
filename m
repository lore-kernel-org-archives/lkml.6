Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDHJ6J (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 05:58:09 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:16946 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeDHJ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 05:58:06 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <bcousson@baylibre.com>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <paul@pwsan.com>, <lokeshvutla@ti.com>,
        <faiz_abbas@ti.com>, <linux@armlinux.org.uk>
Subject: [PATCH 0/3] Add MCAN Support for dra76x
Date: Sun, 8 Apr 2018 15:28:59 +0530
Message-ID: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add dts and hwmod support for MCAN in TI's
dra76 SOCs.

The patches depend on the following series:
https://patchwork.kernel.org/patch/10221105/

Tested on linux-next

Franklin S Cooper Jr (1):
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (2):
  ARM: dra762: hwmod: Add MCAN support
  ARM: dts: dra762: Add MCAN clock support

 arch/arm/boot/dts/dra76-evm.dts           |  7 +++++
 arch/arm/boot/dts/dra76x.dtsi             | 50 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 ++++++++++++++++++++
 3 files changed, 89 insertions(+)

-- 
2.7.4
