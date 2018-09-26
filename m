Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E8320843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E8320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeIZTZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:25:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIZTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:25:50 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQ5jC-1gRErs41Ue-00M645; Wed, 26 Sep 2018 15:12:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Jake Moroni <mail@jakemoroni.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: dpaa: remove unused variables
Date:   Wed, 26 Sep 2018 15:12:13 +0200
Message-Id: <20180926131225.2661703-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:DngBfBogzBZURkwJM/GqC+x33DXFLQpFllWC94rGQDoz1sDzX5O
 ItpWyQYrIU0tQzm61Vkll7vYxf70YgDNffiBEZ5UWO8IBTOuxV8S99czZQMbbCpfNdZOoDY
 mI80qtqkRIdV4oKEIDoKxqagbHD1Edk0y39J1a3EXWYNzgKD9OORv1D7IAEmp26tlmGZQQf
 ltiztj8UPOxP2VqhL+ODQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/VEmaOEE2jQ=:AhnfjAbqweGv3/aehTbaBr
 dOYnyb4DpgxGRLwIinfgOBa2OEF+nxK7DoZkzJBmjU0PGPEORr/bH4rBlsh6262/+7QNkbpjD
 nx2U15FUIz64dgL7EQZjyipHTMoTm/5/SUQePNfY+qk5bWsuRuYUu+bu+uz9CJjSQ8Pd5CCEI
 BgJ6YqD5ztWZ6r7G2C/SlubTUHNztGleYftYhyisR9IbeZcDuVlEk3MBGjeCttxnq+dgT2m8Y
 +Jyt4+zJ6f1FzLyClfY3wH6lF6FPbWRYq5I5ABnkExKYxNDPHA3V2ubUB0uXfddOWDqRKE0Ek
 fHsNiAc9tEpAV20Cx2uSQ+lLIsdirfMb33pqvZB0mjf5xuasx5Y5fVaIySBfxSFKAkaUUwFhl
 nS69J1EPXAiBWQIUNJFrpwks31WoJ/3z1Id5VrfUgFVz0sVezbnqhfA7J7r/4FpjTZFFbQvzL
 GUkJ7g60Ky+C/L6tNV4SYkhqT8ZfowESbEbFo74eGDpg0u7qa7bt6pBozMf42PkJR/4F0hW2K
 ufS8MBa+fBYixoSVDQbV/NFOR+vm7MvK4nEeQJHRHjcA3UzInEhuS/GcHd+kmcWcii1lQNrop
 G6EuL6vWK5AyJhT8XZXJUeiNv72xuovbMkxxFvP6UbdxnYrc/S9YwG3V0I8Q7m1beKOt3wkcP
 Mq09jiyYhWe1ANJ2mNs1KcgX0h39NfM7QHKuJNpxoE+AZol59K9uhTpCUkzAG0GzFRls=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that removed the only users of the oldadv/newadv variables
accidentally left the now-unused declarations behind:

drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c: In function 'dpaa_set_pauseparam':
drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:185:14: error: unused variable 'oldadv' [-Werror=unused-variable]
drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:185:6: error: unused variable 'newadv' [-Werror=unused-variable]

Fixes: 70814e819c11 ("net: ethernet: Add helper for set_pauseparam for Asym Pause")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 5d0fdf667b82..13d6e2272ece 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -182,7 +182,6 @@ static int dpaa_set_pauseparam(struct net_device *net_dev,
 	struct phy_device *phydev;
 	bool rx_pause, tx_pause;
 	struct dpaa_priv *priv;
-	u32 newadv, oldadv;
 	int err;
 
 	priv = netdev_priv(net_dev);
-- 
2.18.0

