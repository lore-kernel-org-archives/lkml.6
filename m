Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932913AbeCOWnW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:43:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34630 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932526AbeCOWnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:43:21 -0400
X-Google-Smtp-Source: AG47ELuhL5btsbxWwhNQkB2a2oM11SIgsXuf/3EsVgJQl9XmDpSu0vDoUTUYnWw9Lnax8aWuKjDC+Q==
From: Cannon Matthews <cannonmatthews@google.com>
To: linux-kernel@vger.kernel.org
Cc: jmattson@google.com, Cannon Matthews <cannonmatthews@google.com>
Subject: [PATCH] netlink: Remove trailing whitespace and spaces.
Date: Thu, 15 Mar 2018 15:41:46 -0700
Message-Id: <20180315224146.69633-1-cannonmatthews@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---
 include/uapi/linux/netlink.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index 776bc92e9118..a35ee3f2274f 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -16,7 +16,7 @@
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ISCSI		8	/* Open-iSCSI */
 #define NETLINK_AUDIT		9	/* auditing */
-#define NETLINK_FIB_LOOKUP	10
+#define NETLINK_FIB_LOOKUP	10
 #define NETLINK_CONNECTOR	11
 #define NETLINK_NETFILTER	12	/* netfilter subsystem */
 #define NETLINK_IP6_FW		13
@@ -32,13 +32,13 @@

 #define NETLINK_INET_DIAG	NETLINK_SOCK_DIAG

-#define MAX_LINKS 32
+#define MAX_LINKS 32

 struct sockaddr_nl {
 	__kernel_sa_family_t	nl_family;	/* AF_NETLINK	*/
 	unsigned short	nl_pad;		/* zero		*/
 	__u32		nl_pid;		/* port ID	*/
-       	__u32		nl_groups;	/* multicast groups mask */
+	__u32		nl_groups;	/* multicast groups mask */
 };

 struct nlmsghdr {
--
2.16.2.804.g6dcf76e118-goog
