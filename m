Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeEGMMY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:12:24 -0400
Received: from 178.27.4.93.rev.sfr.net ([93.4.27.178]:51066 "EHLO
        hofmannsweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:12:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 hofmannsweb.com CDBBA1A8510
From: Georg Hofmann <georg@hofmannsweb.com>
Cc: Georg Hofmann <georg@hofmannsweb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jiri Kosina <trivial@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] trivial: fix inconsistent help texts
Date: Mon,  7 May 2018 14:03:18 +0200
Message-Id: <1525694598-1666-1-git-send-email-georg@hofmannsweb.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes "experimental" from the help text where depends on
CONFIG_EXPERIMENTAL was already removed.

Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
---
 net/ipv6/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 6794ddf..11e4e80 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -34,16 +34,15 @@ config IPV6_ROUTE_INFO
 	bool "IPv6: Route Information (RFC 4191) support"
 	depends on IPV6_ROUTER_PREF
 	---help---
-	  This is experimental support of Route Information.
+	  Support of Route Information.
 
 	  If unsure, say N.
 
 config IPV6_OPTIMISTIC_DAD
 	bool "IPv6: Enable RFC 4429 Optimistic DAD"
 	---help---
-	  This is experimental support for optimistic Duplicate
-	  Address Detection.  It allows for autoconfigured addresses
-	  to be used more quickly.
+	  Support for optimistic Duplicate Address Detection. It allows for
+	  autoconfigured addresses to be used more quickly.
 
 	  If unsure, say N.
 
@@ -280,7 +279,7 @@ config IPV6_MROUTE
 	depends on IPV6
 	select IP_MROUTE_COMMON
 	---help---
-	  Experimental support for IPv6 multicast forwarding.
+	  Support for IPv6 multicast forwarding.
 	  If unsure, say N.
 
 config IPV6_MROUTE_MULTIPLE_TABLES
-- 
2.7.4
