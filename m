Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeEUD6l (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:58:41 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33685 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEUD6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:58:38 -0400
X-Google-Smtp-Source: AB8JxZpI2Px2GyQ0PYV7ImeEUkpsmrdZXzQ8DpQOMLQzHc8Mn1zzYsnuvIv0avQ9Xz1xk3YuEWACzA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Moritz Fischer <mdf@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ethernet: Sort Kconfig sourcing alphabetically
Date: Sun, 20 May 2018 20:58:28 -0700
Message-Id: <20180521035830.7897-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of entries were not alphabetically sorted, remedy that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 54d71e1c48d5..af766fd61151 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -33,9 +33,9 @@ source "drivers/net/ethernet/aquantia/Kconfig"
 source "drivers/net/ethernet/arc/Kconfig"
 source "drivers/net/ethernet/atheros/Kconfig"
 source "drivers/net/ethernet/aurora/Kconfig"
-source "drivers/net/ethernet/cadence/Kconfig"
 source "drivers/net/ethernet/broadcom/Kconfig"
 source "drivers/net/ethernet/brocade/Kconfig"
+source "drivers/net/ethernet/cadence/Kconfig"
 source "drivers/net/ethernet/calxeda/Kconfig"
 source "drivers/net/ethernet/cavium/Kconfig"
 source "drivers/net/ethernet/chelsio/Kconfig"
@@ -72,16 +72,16 @@ source "drivers/net/ethernet/dec/Kconfig"
 source "drivers/net/ethernet/dlink/Kconfig"
 source "drivers/net/ethernet/emulex/Kconfig"
 source "drivers/net/ethernet/ezchip/Kconfig"
-source "drivers/net/ethernet/neterion/Kconfig"
 source "drivers/net/ethernet/faraday/Kconfig"
 source "drivers/net/ethernet/freescale/Kconfig"
 source "drivers/net/ethernet/fujitsu/Kconfig"
 source "drivers/net/ethernet/hisilicon/Kconfig"
 source "drivers/net/ethernet/hp/Kconfig"
 source "drivers/net/ethernet/huawei/Kconfig"
+source "drivers/net/ethernet/i825xx/Kconfig"
 source "drivers/net/ethernet/ibm/Kconfig"
 source "drivers/net/ethernet/intel/Kconfig"
-source "drivers/net/ethernet/i825xx/Kconfig"
+source "drivers/net/ethernet/neterion/Kconfig"
 source "drivers/net/ethernet/xscale/Kconfig"
 
 config JME
@@ -114,8 +114,8 @@ source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
-source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/moxa/Kconfig"
+source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/myricom/Kconfig"
 
 config FEALNX
@@ -161,20 +161,21 @@ source "drivers/net/ethernet/packetengines/Kconfig"
 source "drivers/net/ethernet/pasemi/Kconfig"
 source "drivers/net/ethernet/qlogic/Kconfig"
 source "drivers/net/ethernet/qualcomm/Kconfig"
+source "drivers/net/ethernet/rdc/Kconfig"
 source "drivers/net/ethernet/realtek/Kconfig"
 source "drivers/net/ethernet/renesas/Kconfig"
-source "drivers/net/ethernet/rdc/Kconfig"
 source "drivers/net/ethernet/rocker/Kconfig"
 source "drivers/net/ethernet/samsung/Kconfig"
 source "drivers/net/ethernet/seeq/Kconfig"
-source "drivers/net/ethernet/silan/Kconfig"
-source "drivers/net/ethernet/sis/Kconfig"
 source "drivers/net/ethernet/sfc/Kconfig"
 source "drivers/net/ethernet/sgi/Kconfig"
+source "drivers/net/ethernet/silan/Kconfig"
+source "drivers/net/ethernet/sis/Kconfig"
 source "drivers/net/ethernet/smsc/Kconfig"
 source "drivers/net/ethernet/socionext/Kconfig"
 source "drivers/net/ethernet/stmicro/Kconfig"
 source "drivers/net/ethernet/sun/Kconfig"
+source "drivers/net/ethernet/synopsys/Kconfig"
 source "drivers/net/ethernet/tehuti/Kconfig"
 source "drivers/net/ethernet/ti/Kconfig"
 source "drivers/net/ethernet/toshiba/Kconfig"
@@ -183,6 +184,5 @@ source "drivers/net/ethernet/via/Kconfig"
 source "drivers/net/ethernet/wiznet/Kconfig"
 source "drivers/net/ethernet/xilinx/Kconfig"
 source "drivers/net/ethernet/xircom/Kconfig"
-source "drivers/net/ethernet/synopsys/Kconfig"
 
 endif # ETHERNET
-- 
2.14.1
