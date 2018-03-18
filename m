Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754728AbeCRUew (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:34:52 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53997 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754618AbeCRUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:34:48 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de, arnd@arndb.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 6/7] ARM: multi_v7_defconfig: add NXP FlexCAN IP support
Date: Sun, 18 Mar 2018 21:34:41 +0100
Message-Id: <20180318203442.19759-6-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable FlexCAN support as module by default. FlexCAN can be found
on various NXP designs such as the i.MX and Vybrid SoC family.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 984e509d41bf..61968bd6cccc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -174,6 +174,7 @@ CONFIG_CAN_RAW=y
 CONFIG_CAN_BCM=y
 CONFIG_CAN_DEV=y
 CONFIG_CAN_AT91=m
+CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
-- 
2.16.2
