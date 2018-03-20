Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeCTLHl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:07:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7319 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752832AbeCTLFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:15 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38002750"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 2/5] x86/cpu_hotplug: Update the link of cpu_hotplug.rst
Date: Tue, 20 Mar 2018 19:04:29 +0800
Message-ID: <20180320110432.28127-3-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: A49F648AE76C.A2096
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original cpu_hotplug.txt documents describing CPU hotplug support in
Linux kernel. it was moved in to core-api/ and renamed cpu_hotplug.rst.

Update it's link in other documents

Fixes: ff58fa7f556c ("Documentation: Update CPU hotplug and move it to core-api")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 Documentation/00-INDEX        |  2 --
 Documentation/cputopology.txt | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 7f3a0728ccf2..3773c67ea9e5 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -104,8 +104,6 @@ core-api/
 	- documentation on kernel core components.
 cpu-freq/
 	- info on CPU frequency and voltage scaling.
-cpu-hotplug.txt
-	- document describing CPU hotplug support in the Linux kernel.
 cpu-load.txt
 	- document describing how CPU load statistics are collected.
 cpuidle/
diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index c6e7e9196a8b..e05b0879fe91 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -117,9 +117,9 @@ source for the output is in brackets ("[]").
 		[NR_CPUS-1]
 
     offline:	CPUs that are not online because they have been
-		HOTPLUGGED off (see cpu-hotplug.txt) or exceed the limit
-		of CPUs allowed by the kernel configuration (kernel_max
-		above). [~cpu_online_mask + cpus >= NR_CPUS]
+		HOTPLUGGED off (see core-api/cpu_hotplug.rst) or exceed
+		the limit of CPUs allowed by the kernel configuration
+		(kernel_max above). [~cpu_online_mask + cpus >= NR_CPUS]
 
     online:	CPUs that are online and being scheduled [cpu_online_mask]
 
@@ -155,5 +155,5 @@ online.)::
        possible: 0-127
         present: 0-3
 
-See cpu-hotplug.txt for the possible_cpus=NUM kernel start parameter
-as well as more information on the various cpumasks.
+See core-api/cpu_hotplug.rst for the possible_cpus=NUM kernel start
+parameter as well as more information on the various cpumasks.
-- 
2.14.3
