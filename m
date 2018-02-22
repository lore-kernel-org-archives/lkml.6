Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeBVIso (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:48:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12507 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752786AbeBVIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:48:42 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37168771"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/documentation: Document the correct function name
Date: Thu, 22 Feb 2018 16:48:12 +0800
Message-ID: <20180222084812.14497-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: EAA4648AE761.A1719
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

topology_sibling_cpumask() is the correct thread-related topology
information in the kernel.

S/topology_sibling_mask/topology_sibling_cpumask

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
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
-- 
2.14.3
