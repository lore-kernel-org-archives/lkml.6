Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeCIKSy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:18:54 -0500
Received: from mail.phycore.de ([217.6.246.34]:41235 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIKSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:18:53 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: linux@armlinux.org.uk, krzk@kernel.org
Cc: arnd@arndb.de, davem@davemloft.net, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: multi_v7_defconfig: enable CONFIG_DP83867_PHY
Date: Fri, 9 Mar 2018 11:18:51 +0100
Message-Id: <1520590731-34556-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.03.2018 11:18:51,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.03.2018 11:18:51,
        Serialize complete at 09.03.2018 11:18:51
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the driver for TI's DP83867 ethernet phy.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
	v2: Re-submit with more recipients.
	Sorry, I only added Russell and vger in v1.

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index da73876..62ad2c6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -270,6 +270,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_BROADCOM_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_MICREL_PHY=y
-- 
2.7.4
