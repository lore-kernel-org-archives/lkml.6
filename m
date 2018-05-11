Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeEKPsc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:48:32 -0400
Received: from m12-13.163.com ([220.181.12.13]:59398 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeEKPsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:48:31 -0400
From: Chen Lin <chen45464546@163.com>
To: tglx@linutronix.de
Cc: john.stultz@linaro.org, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen45464546@163.com>
Subject: [PATCH] time: remove unused function pointer define
Date: Fri, 11 May 2018 23:47:29 +0800
Message-Id: <1526053649-24229-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowADn91sZu_Va3IIuBA--.34387S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2S_MUUUUU
X-Originating-IP: [171.221.138.154]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiygFDnlQG+XYHPgAAsy
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove 'printf_fn_t' define not used

Signed-off-by: Chen Lin <chen45464546@163.com>
---
 kernel/time/timer_list.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 0ed768b..ddc1d58 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -28,8 +28,6 @@ struct timer_list_iter {
 	u64 now;
 };
 
-typedef void (*print_fn_t)(struct seq_file *m, unsigned int *classes);
-
 /*
  * This allows printing both to /proc/timer_list and
  * to the console (on SysRq-Q):
-- 
2.7.4
