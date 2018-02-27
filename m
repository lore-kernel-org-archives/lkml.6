Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeB0G0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:26:21 -0500
Received: from mx58.baidu.com ([61.135.168.58]:43381 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750770AbeB0G0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:26:20 -0500
From: Li RongQing <lirongqing@baidu.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: fenghua.yu@intel.com, tglx@linutronix.de
Subject: [PATCH] Documentation: fix the wrong path in intel_rdt_ui.txt
Date: Tue, 27 Feb 2018 14:17:51 +0800
Message-Id: <1519712271-8802-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the note says "Move the cpus 4-7 over to p1", but echo command
writes f0 to p0/cpus

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index 756fd76b78a6..71c30984e94d 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -671,7 +671,7 @@ occupancy of the real time threads on these cores.
 # mkdir p1
 
 Move the cpus 4-7 over to p1
-# echo f0 > p0/cpus
+# echo f0 > p1/cpus
 
 View the llc occupancy snapshot
 
-- 
2.11.0
