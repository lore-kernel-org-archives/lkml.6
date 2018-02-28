Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbeB1TD5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:03:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB1TDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:03:55 -0500
Date: Wed, 28 Feb 2018 11:03:47 -0800
From: tip-bot for Li RongQing <tipbot@zytor.com>
Message-ID: <tip-30009746168da0f1f648881f77083c40e226a8a0@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, lirongqing@baidu.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, lirongqing@baidu.com
In-Reply-To: <1519712271-8802-1-git-send-email-lirongqing@baidu.com>
References: <1519712271-8802-1-git-send-email-lirongqing@baidu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Documentation, x86, resctrl: Make text and sample
 command match
Git-Commit-ID: 30009746168da0f1f648881f77083c40e226a8a0
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

Commit-ID:  30009746168da0f1f648881f77083c40e226a8a0
Gitweb:     https://git.kernel.org/tip/30009746168da0f1f648881f77083c40e226a8a0
Author:     Li RongQing <lirongqing@baidu.com>
AuthorDate: Tue, 27 Feb 2018 14:17:51 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 19:59:05 +0100

Documentation, x86, resctrl: Make text and sample command match

The text says "Move the cpus 4-7 over to p1", but the sample command writes
to p0/cpus.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: linux-doc@vger.kernel.org
Link: https://lkml.kernel.org/r/1519712271-8802-1-git-send-email-lirongqing@baidu.com

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
 
