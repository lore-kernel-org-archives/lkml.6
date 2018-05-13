Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeEMOB3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:01:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeEMOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:01:28 -0400
Date: Sun, 13 May 2018 07:01:16 -0700
From: tip-bot for Chen Lin <tipbot@zytor.com>
Message-ID: <tip-ed772ec873cb0d378c0329d266ae656ec1f2b511@git.kernel.org>
Cc: tglx@linutronix.de, chen45464546@163.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, chen45464546@163.com
In-Reply-To: <1526053649-24229-1-git-send-email-chen45464546@163.com>
References: <1526053649-24229-1-git-send-email-chen45464546@163.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer_list: Remove unused function pointer
 typedef
Git-Commit-ID: ed772ec873cb0d378c0329d266ae656ec1f2b511
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

Commit-ID:  ed772ec873cb0d378c0329d266ae656ec1f2b511
Gitweb:     https://git.kernel.org/tip/ed772ec873cb0d378c0329d266ae656ec1f2b511
Author:     Chen Lin <chen45464546@163.com>
AuthorDate: Fri, 11 May 2018 23:47:29 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:56:01 +0200

timer_list: Remove unused function pointer typedef

Remove the 'printf_fn_t' typedef as it is not used.

Signed-off-by: Chen Lin <chen45464546@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: sboyd@kernel.org
Cc: john.stultz@linaro.org
Link: https://lkml.kernel.org/r/1526053649-24229-1-git-send-email-chen45464546@163.com
---
 kernel/time/timer_list.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 0ed768b56c60..ddc1d58f96c7 100644
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
