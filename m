Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeCaJ2y (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 05:28:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbeCaJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 05:28:53 -0400
Date: Sat, 31 Mar 2018 02:28:26 -0700
From: tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-eaeb8e76cd5751e805f6e4a3fcec91d283e3b0c2@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        colin.king@canonical.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, peterz@infradead.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20180313154709.1015-1-colin.king@canonical.com>
References: <20180313154709.1015-1-colin.king@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/cpu/tme: Fix spelling: "configuation" ->
 "configuration"
Git-Commit-ID: eaeb8e76cd5751e805f6e4a3fcec91d283e3b0c2
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

Commit-ID:  eaeb8e76cd5751e805f6e4a3fcec91d283e3b0c2
Gitweb:     https://git.kernel.org/tip/eaeb8e76cd5751e805f6e4a3fcec91d283e3b0c2
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Tue, 13 Mar 2018 15:47:09 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 10:46:40 +0200

x86/cpu/tme: Fix spelling: "configuation" -> "configuration"

Trivial fix to spelling mistake in the pr_err_once() error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20180313154709.1015-1-colin.king@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 6106d11ceb6b..b9693b80fc21 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -540,7 +540,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 	if (mktme_status != MKTME_UNINITIALIZED) {
 		if (tme_activate != tme_activate_cpu0) {
 			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuation is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
 			pr_err_once("x86/tme: MKTME is not usable\n");
 			mktme_status = MKTME_DISABLED;
 
