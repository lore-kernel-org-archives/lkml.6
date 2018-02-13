Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934704AbeBMJqO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:46:14 -0500
Received: from mail.tricorecenter.de ([217.6.246.34]:44471 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934243AbeBMJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:46:07 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_DP83867_PHY
Date: Tue, 13 Feb 2018 10:39:18 +0100
Message-Id: <1518514758-21759-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:39:23,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:39:23,
        Serialize complete at 13.02.2018 10:39:23
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the driver for TI's DP83867 ethernet phy.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 61509c4..8313fa1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -265,6 +265,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_BROADCOM_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_MICREL_PHY=y
-- 
2.7.4
