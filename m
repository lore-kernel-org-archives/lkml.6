Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965476AbeBMRMj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:12:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965348AbeBMRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:26 -0500
Date: Tue, 13 Feb 2018 09:00:01 -0800
From: tip-bot for Alexey Dobriyan <tipbot@zytor.com>
Message-ID: <tip-16c5055a5ff5e1ff13c5211e44514a2b1d2c1dae@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        adobriyan@gmail.com, peterz@infradead.org,
        torvalds@linux-foundation.org, bp@suse.de, tglx@linutronix.de
Reply-To: peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, bp@suse.de, adobriyan@gmail.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180113190648.GB23111@avx2>
References: <20180113190648.GB23111@avx2>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Trim clear_page.S includes
Git-Commit-ID: 16c5055a5ff5e1ff13c5211e44514a2b1d2c1dae
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

Commit-ID:  16c5055a5ff5e1ff13c5211e44514a2b1d2c1dae
Gitweb:     https://git.kernel.org/tip/16c5055a5ff5e1ff13c5211e44514a2b1d2c1dae
Author:     Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate: Sat, 13 Jan 2018 22:06:48 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 17:37:07 +0100

x86/asm: Trim clear_page.S includes

After alternatives were shifted to the call site, only 2 headers are
necessary.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180113190648.GB23111@avx2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/lib/clear_page_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 81b1635..88acd34 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,6 +1,4 @@
 #include <linux/linkage.h>
-#include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
 #include <asm/export.h>
 
 /*
