Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeCECQB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:16:01 -0500
Received: from out3140-226.mail.aliyun.com ([42.120.140.226]:15691 "EHLO
        out3140-226.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752017AbeCECQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:16:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2839575|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=zhenwei.pi@youruncloud.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.BB4XszM_1520216155;
From: "zhenwei.pi" <zhenwei.pi@youruncloud.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        "zhenwei.pi" <zhenwei.pi@youruncloud.com>
Subject: [PATCH] x86/kconfig: Remove residual "no-hlt" boot parameter reference
Date: Mon,  5 Mar 2018 10:15:54 +0800
Message-Id: <1520216154-13737-1-git-send-email-zhenwei.pi@youruncloud.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "no-hlt" boot parameter has been removed ~5 years ago :
	The commit 27be457000211a6903968dfce06d5f73f051a217
	("x86 idle: remove 32-bit-only "no-hlt" parameter, hlt_works_ok flag")

Remove a stale reference from the documentation as well.

Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
---
 arch/x86/Kconfig | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f..bdb17b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2494,19 +2494,18 @@ menuconfig APM
 
 	  1) make sure that you have enough swap space and that it is
 	  enabled.
-	  2) pass the "no-hlt" option to the kernel
-	  3) switch on floating point emulation in the kernel and pass
+	  2) switch on floating point emulation in the kernel and pass
 	  the "no387" option to the kernel
-	  4) pass the "floppy=nodma" option to the kernel
-	  5) pass the "mem=4M" option to the kernel (thereby disabling
+	  3) pass the "floppy=nodma" option to the kernel
+	  4) pass the "mem=4M" option to the kernel (thereby disabling
 	  all but the first 4 MB of RAM)
-	  6) make sure that the CPU is not over clocked.
-	  7) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
-	  8) disable the cache from your BIOS settings
-	  9) install a fan for the video card or exchange video RAM
-	  10) install a better fan for the CPU
-	  11) exchange RAM chips
-	  12) exchange the motherboard.
+	  5) make sure that the CPU is not over clocked.
+	  6) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
+	  7) disable the cache from your BIOS settings
+	  8) install a fan for the video card or exchange video RAM
+	  9) install a better fan for the CPU
+	  10) exchange RAM chips
+	  11) exchange the motherboard.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called apm.
-- 
2.7.4
