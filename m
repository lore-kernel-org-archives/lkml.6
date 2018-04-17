Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeDQPW4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:22:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbeDQPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:22:53 -0400
Date: Tue, 17 Apr 2018 08:22:46 -0700
From: "tip-bot for Liu, Changcheng" <tipbot@zytor.com>
Message-ID: <tip-f0ae6a0321222864ed8675a924cc8ee2cb042c31@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        changcheng.liu@intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, changcheng.liu@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20180412075701.GA38952@sofia>
References: <20180412075701.GA38952@sofia>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timers: Remove stale struct tvec_base forward
 declaration
Git-Commit-ID: f0ae6a0321222864ed8675a924cc8ee2cb042c31
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

Commit-ID:  f0ae6a0321222864ed8675a924cc8ee2cb042c31
Gitweb:     https://git.kernel.org/tip/f0ae6a0321222864ed8675a924cc8ee2cb042c31
Author:     Liu, Changcheng <changcheng.liu@intel.com>
AuthorDate: Thu, 12 Apr 2018 15:57:01 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 17:18:04 +0200

timers: Remove stale struct tvec_base forward declaration

struct tvec_base is a leftover of the original timer wheel implementation
and not longer used. Remove the forward declaration.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Link: https://lkml.kernel.org/r/20180412075701.GA38952@sofia

---
 include/linux/timer.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 2448f9cc48a3..7b066fd38248 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -8,8 +8,6 @@
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
 
-struct tvec_base;
-
 struct timer_list {
 	/*
 	 * All fields that change during normal runtime grouped to the
