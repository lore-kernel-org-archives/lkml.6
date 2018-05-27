Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032982AbeE0SF4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 14:05:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43443 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032846AbeE0SFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 14:05:53 -0400
X-Google-Smtp-Source: ADUXVKLL7Jw3Gx4A4CR1C57LuQQ95P+IiFCf81n9+E4MkQRfeMxNG1vIFrowTuQdlhRLmUkZgQukfA==
Date: Sun, 27 May 2018 15:05:49 -0300
From: Jefferson Capovilla <jefcap@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-eth: Remove extra line in
 mtk_set_link_ksettings()
Message-ID: <20180527180549.GA11995@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix extra line before end of function.

Signed-off-by: Jefferson Capovilla <jefcap@gmail.com>
---
 drivers/staging/mt7621-eth/ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index b565d2a..e9f4092 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -63,7 +63,6 @@ static int mtk_set_link_ksettings(struct net_device *dev,
 	}
 
 	return phy_ethtool_ksettings_set(mac->phy_dev, cmd);
-
 }
 
 static void mtk_get_drvinfo(struct net_device *dev,
-- 
2.7.4
