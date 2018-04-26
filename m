Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757181AbeDZX5P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:57:15 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:39848 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756405AbeDZX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:57:13 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [RFC PATCH] MAINTAINERS: add davem in NETWORKING DRIVERS
Date: Thu, 26 Apr 2018 19:47:35 -0400
Message-Id: <20180426234735.30112-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"./scripts/get_maintainer.pl -f" does not actually show us David as the
maintainer of drivers/net directories such as team, bonding, phy or dsa.
Adding him in an M: entry of NETWORKING DRIVERS fixes this.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a52800867850..21038e0dadc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9732,6 +9732,7 @@ W:	https://fedorahosted.org/dropwatch/
 F:	net/core/drop_monitor.c
 
 NETWORKING DRIVERS
+M:	"David S. Miller" <davem@davemloft.net>
 L:	netdev@vger.kernel.org
 W:	http://www.linuxfoundation.org/en/Net
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
-- 
2.17.0
