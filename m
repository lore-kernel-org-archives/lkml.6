Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeBTRBc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:01:32 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33931 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeBTRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:01:25 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, linux-arm-kernel@axis.com, devicetree@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] ARTPEC-6 ARM SoC device tree updates
Date: Tue, 20 Feb 2018 18:00:41 +0100
Message-Id: <20180220170049.22809-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here comes some ARTPEC-6 ARM SoC device tree updates.

Regards,
Niklas

Niklas Cassel (8):
  ARM: dts: artpec: disable Accelerator Coherency Port
  ARM: dts: artpec: use 1 GiB RAM
  ARM: dts: artpec: remove 0x prefix from clkctrl unit address
  ARM: dts: artpec: migrate ethernet to stmmac binding
  ARM: dts: artpec: add and utilize artpec6 pin controller
  ARM: dts: artpec: add and utilize nbpfaxi DMA controllers
  ARM: dts: artpec: add disabled node for PCIe endpoint mode
  ARM: dts: artpec: add node for hardware crypto accelerator

 arch/arm/boot/dts/artpec6-devboard.dts |   3 +-
 arch/arm/boot/dts/artpec6.dtsi         | 165 +++++++++++++++++++++++++++++++--
 2 files changed, 157 insertions(+), 11 deletions(-)

-- 
2.14.2
