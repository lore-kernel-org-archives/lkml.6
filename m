Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeEFMNc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:13:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeEFMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:13:29 -0400
Date: Sun, 6 May 2018 05:13:10 -0700
From: tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-e0f6d1a526b6adfa9ca3b336b83ece0eed345033@git.kernel.org>
Cc: torvalds@linux-foundation.org, hpa@zytor.com, jannh@google.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jannh@google.com,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180504175935.104085-1-jannh@google.com>
References: <20180504175935.104085-1-jannh@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/vdso: Remove unused file
Git-Commit-ID: e0f6d1a526b6adfa9ca3b336b83ece0eed345033
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

Commit-ID:  e0f6d1a526b6adfa9ca3b336b83ece0eed345033
Gitweb:     https://git.kernel.org/tip/e0f6d1a526b6adfa9ca3b336b83ece0eed345033
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 4 May 2018 19:59:35 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 5 May 2018 09:02:36 +0200

x86/vdso: Remove unused file

commit da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
left this file behind; nothing is using it anymore.

Signed-off-by: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@amacapital.net
Link: http://lkml.kernel.org/r/20180504175935.104085-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vdso32/vdso-fakesections.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c b/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
deleted file mode 100644
index 541468e25265..000000000000
--- a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
+++ /dev/null
@@ -1 +0,0 @@
-#include "../vdso-fakesections.c"
