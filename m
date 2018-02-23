Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeBWI3O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:29:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBWI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:29:12 -0500
Date: Fri, 23 Feb 2018 00:28:48 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-0c52f7c5499dc708a64742da0cb7eb4f6d94588b@git.kernel.org>
Cc: mingo@kernel.org, douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        douly.fnst@cn.fujitsu.com, tglx@linutronix.de
In-Reply-To: <20180222084812.14497-1-douly.fnst@cn.fujitsu.com>
References: <20180222084812.14497-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/topology: Fix function name in documentation
Git-Commit-ID: 0c52f7c5499dc708a64742da0cb7eb4f6d94588b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0c52f7c5499dc708a64742da0cb7eb4f6d94588b
Gitweb:     https://git.kernel.org/tip/0c52f7c5499dc708a64742da0cb7eb4f6d94588b
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Thu, 22 Feb 2018 16:48:12 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:40:12 +0100

x86/topology: Fix function name in documentation

topology_sibling_cpumask() is the correct thread-related topology
function in the kernel:

  s/topology_sibling_mask/topology_sibling_cpumask

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222084812.14497-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/topology.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index f3e9d7e9ed6c..2953e3ec9a02 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -108,7 +108,7 @@ The topology of a system is described in the units of:
 
     The number of online threads is also printed in /proc/cpuinfo "siblings."
 
-  - topology_sibling_mask():
+  - topology_sibling_cpumask():
 
     The cpumask contains all online threads in the core to which a thread
     belongs.
