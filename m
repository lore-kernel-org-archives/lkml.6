Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeEASlC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:41:02 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:43230 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756479AbeEASk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:40:59 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-m68k@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/defconfig: Update defconfigs for v4.17-rc3
Date: Tue,  1 May 2018 20:10:29 +0200
Message-Id: <1525198229-11521-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be combined with "m68k/defconfig: Update defconfigs for v4.17-rc1".
---
 arch/m68k/configs/amiga_defconfig    | 6 +++---
 arch/m68k/configs/apollo_defconfig   | 6 +++---
 arch/m68k/configs/atari_defconfig    | 6 +++---
 arch/m68k/configs/bvme6000_defconfig | 6 +++---
 arch/m68k/configs/hp300_defconfig    | 6 +++---
 arch/m68k/configs/mac_defconfig      | 6 +++---
 arch/m68k/configs/multi_defconfig    | 6 +++---
 arch/m68k/configs/mvme147_defconfig  | 6 +++---
 arch/m68k/configs/mvme16x_defconfig  | 6 +++---
 arch/m68k/configs/q40_defconfig      | 6 +++---
 arch/m68k/configs/sun3_defconfig     | 6 +++---
 arch/m68k/configs/sun3x_defconfig    | 6 +++---
 12 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index b5abd401cec95a63..a874e54404d10c94 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -233,12 +233,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 078a623459af2a17..8ce39e23aa427244 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -231,12 +231,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 5dde4f130d173ab5..e6c7011fddd784a6 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -231,12 +231,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 6b1e98d54b7b1e8e..fca9c7aa71a34e07 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -229,12 +229,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index f509accf4944c397..f9eab174915c59bb 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -231,12 +231,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index ffee9473702c92fb..b52e597899eb33f4 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -230,12 +230,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 10edf06d75a7812e..2a84eeec5b02af12 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -240,12 +240,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index dc48192cc843c37f..476e69994340ebdf 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -228,12 +228,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index fa68748d6aca9236..1477cda9146e7692 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -229,12 +229,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 0daea9c01d9f35e9..b3a543dc48a072ef 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -229,12 +229,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 97979ebca8e86936..d543ed5dfa967b56 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -226,12 +226,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 403fd2da935435ac..a67e54246023e5e4 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -226,12 +226,12 @@ CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_NF_SOCKET_IPV6=m
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
-CONFIG_NFT_DUP_IPV6=m
-CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_MASQ_IPV6=m
 CONFIG_NFT_REDIR_IPV6=m
+CONFIG_NFT_DUP_IPV6=m
+CONFIG_NFT_FIB_IPV6=m
+CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
-- 
2.7.4
