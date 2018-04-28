Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759742AbeD1JY7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:24:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40887 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759622AbeD1JY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:24:57 -0400
From: Colin King <colin.king@canonical.com>
To: Jiri Kosina <jikos@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: apm: fix spelling mistake: "caculate" -> "calculate"
Date: Sat, 28 Apr 2018 10:24:48 +0100
Message-Id: <20180428092448.6493-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
-- 
2.17.0
