Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeCZKHT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:07:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4407 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750972AbeCZKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:07:18 -0400
X-UUID: a082c9abfd184a4a88d5b9ad57c8f8e2-20180326
From: <sean.wang@mediatek.com>
To: <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <vivien.didelot@savoirfairelinux.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net 1/2] net: dsa: mt7530: remove redundant MODULE_ALIAS entries
Date: Mon, 26 Mar 2018 18:07:09 +0800
Message-ID: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-4.063600-8.000000-10
X-TMASE-MatchedRID: yFGXaP8bkQPLqx3pQDUvTo0JVVcEm48nXs5nqGvDCfOl4EP+dy+wBGEj
        04n4UkciNMW1025grLlEOP/MktCQ9nEjLiYgp5vhA9lly13c/gH6rVj794QCttzOQo7mTgA+RtW
        kGiser322b29ZkF3sdYAy6p60ZV62JW+71yEen6Zq8/xv2Um1avoLR4+zsDTt9VPDReA7LdpUhZ
        OAl5dYSpHcxFW7O9OWjgNIuROEf4ChO7qS+5OmfPPZN+fTfGhMCMKvvxu8zHtk8l0x+l/9p5UsT
        6pavlpwYMIU3vZURpHaQLtLC8aUqEPBvsmCWGHWUWQ7Bol0IqC+I8SpxyUS3MC+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.063600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/dsa/mt7530.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8a0bb00..d31246c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1424,4 +1424,3 @@ mdio_module_driver(mt7530_mdio_driver);
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("Driver for Mediatek MT7530 Switch");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:mediatek-mt7530");
-- 
2.7.4
