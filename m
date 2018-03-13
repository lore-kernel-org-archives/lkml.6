Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935051AbeCMPrW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:47:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933831AbeCMPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:47:20 -0400
From: Colin King <colin.king@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] x86/tme: fix spelling mistake: "configuation" -> "configuration"
Date: Tue, 13 Mar 2018 15:47:09 +0000
Message-Id: <20180313154709.1015-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_err_once error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b862067bb33c..e86d622592f5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -541,7 +541,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 	if (mktme_status != MKTME_UNINITIALIZED) {
 		if (tme_activate != tme_activate_cpu0) {
 			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuation is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
 			pr_err_once("x86/tme: MKTME is not usable\n");
 			mktme_status = MKTME_DISABLED;
 
-- 
2.15.1
