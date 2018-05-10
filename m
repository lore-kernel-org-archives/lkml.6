Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966364AbeEJPyq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:54:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51430 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965033AbeEJPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:54:44 -0400
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/windfarm: fix spelling mistake: "ttarged" -> "ttarget"
Date: Thu, 10 May 2018 16:54:39 +0100
Message-Id: <20180510155439.16582-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in debug messages of a structure
field name

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/macintosh/windfarm_pm121.c | 2 +-
 drivers/macintosh/windfarm_pm81.c  | 2 +-
 drivers/macintosh/windfarm_pm91.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index 4d72d8f58cb6..97634e030991 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -710,7 +710,7 @@ static void pm121_create_cpu_fans(void)
 	wf_cpu_pid_init(&pm121_cpu_state->pid, &pid_param);
 
 	pr_debug("pm121: CPU Fan control initialized.\n");
-	pr_debug("       ttarged=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM,\n",
+	pr_debug("       ttarget=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM,\n",
 		 FIX32TOPRINT(pid_param.ttarget), FIX32TOPRINT(pid_param.tmax),
 		 pid_param.min, pid_param.max);
 
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index d9ea45581b9e..346c91744442 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -455,7 +455,7 @@ static void wf_smu_create_cpu_fans(void)
 	wf_cpu_pid_init(&wf_smu_cpu_fans->pid, &pid_param);
 
 	DBG("wf: CPU Fan control initialized.\n");
-	DBG("    ttarged=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM\n",
+	DBG("    ttarget=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM\n",
 	    FIX32TOPRINT(pid_param.ttarget), FIX32TOPRINT(pid_param.tmax),
 	    pid_param.min, pid_param.max);
 
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 7fd73dcb2b0a..a8a47c62a74b 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -200,7 +200,7 @@ static void wf_smu_create_cpu_fans(void)
 	wf_cpu_pid_init(&wf_smu_cpu_fans->pid, &pid_param);
 
 	DBG("wf: CPU Fan control initialized.\n");
-	DBG("    ttarged=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM\n",
+	DBG("    ttarget=%d.%03d, tmax=%d.%03d, min=%d RPM, max=%d RPM\n",
 	    FIX32TOPRINT(pid_param.ttarget), FIX32TOPRINT(pid_param.tmax),
 	    pid_param.min, pid_param.max);
 
-- 
2.17.0
