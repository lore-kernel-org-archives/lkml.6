Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeCRUP2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:15:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52776 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeCRUPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:15:18 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: enable Vybrid OCOTP driver
Date: Sun, 18 Mar 2018 21:15:10 +0100
Message-Id: <20180318201510.13086-3-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318201510.13086-1-stefan@agner.ch>
References: <20180318201510.13086-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the OCOTP NVMEM driver for Vybrid (vf610) SoCs.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 67db78f8c9df..6ce94333be5c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -380,6 +380,7 @@ CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
 CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_MMIO=y
-- 
2.16.2
