Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeBUJAS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:00:18 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:43215 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:00:17 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, linux-arm-kernel@axis.com, devicetree@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] ARTPEC-6 ARM SoC device tree updates
Date: Wed, 21 Feb 2018 09:59:52 +0100
Message-Id: <20180221090000.18091-1-niklas.cassel@axis.com>
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
 arch/arm/boot/dts/artpec6.dtsi         | 163 +++++++++++++++++++++++++++++++--
 2 files changed, 155 insertions(+), 11 deletions(-)

-- 
2.14.2
