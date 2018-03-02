Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425982AbeCBOiN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:38:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52971 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424588AbeCBOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:38:10 -0500
X-Google-Smtp-Source: AG47ELsKrA+SWz9LGMeMSHAkf8b0Odyt/WVW8WBhYBQK8Lh8dMbl0ApNCXnnOjf/kxRsh3UtvQYXiA==
From: Jan Glauber <jglauber@cavium.com>
To: arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/2] arm64: defconfig: enable THUNDER_NIC_VF
Date: Fri,  2 Mar 2018 15:37:36 +0100
Message-Id: <20180302143737.10788-1-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this option the NIC on ThunderX1 is not coming up
so enable it to get a working network interface.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373785c4..3594aefa496f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -197,6 +197,7 @@ CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_THUNDER_NIC_VF=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
-- 
2.7.4
