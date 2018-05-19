Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeESMVx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:21:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeESMVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:21:51 -0400
Date: Sat, 19 May 2018 05:21:44 -0700
From: tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-844ea8f62619ac2a5e47d13e3449ac197067b414@git.kernel.org>
Cc: mingo@kernel.org, jikos@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        colin.king@canonical.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, jikos@kernel.org, mingo@kernel.org,
        hpa@zytor.com
In-Reply-To: <20180428092448.6493-1-colin.king@canonical.com>
References: <20180428092448.6493-1-colin.king@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/apm: Fix spelling mistake: "caculate" ->
 "calculate"
Git-Commit-ID: 844ea8f62619ac2a5e47d13e3449ac197067b414
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

Commit-ID:  844ea8f62619ac2a5e47d13e3449ac197067b414
Gitweb:     https://git.kernel.org/tip/844ea8f62619ac2a5e47d13e3449ac197067b414
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Sat, 28 Apr 2018 10:24:48 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 14:18:59 +0200

x86/apm: Fix spelling mistake: "caculate" -> "calculate"

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: kernel-janitors@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180428092448.6493-1-colin.king@canonical.com

---
 arch/x86/kernel/apm_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index dfcbe6924eaf..6b345f35f023 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -2446,7 +2446,7 @@ MODULE_PARM_DESC(idle_threshold,
 	"System idle percentage above which to make APM BIOS idle calls");
 module_param(idle_period, int, 0444);
 MODULE_PARM_DESC(idle_period,
-	"Period (in sec/100) over which to caculate the idle percentage");
+	"Period (in sec/100) over which to calculate the idle percentage");
 module_param(smp, bool, 0444);
 MODULE_PARM_DESC(smp,
 	"Set this to enable APM use on an SMP platform. Use with caution on older systems");
