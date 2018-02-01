Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeBAESB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 23:18:01 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:42807 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeBAESA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 23:18:00 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] <asm-generic/siginfo.h>: fix language in comments
Message-ID: <1a5a021c-0207-f793-7f07-addca26772d5@infradead.org>
Date: Wed, 31 Jan 2018 20:17:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix grammar and add an omitted word.

Fixes: f9886bc50a8e ("signal: Document the strange si_codes used by ptrace event stops")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/uapi/asm-generic/siginfo.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- orig/include/uapi/asm-generic/siginfo.h
+++ next/include/uapi/asm-generic/siginfo.h
@@ -280,8 +280,8 @@ typedef struct siginfo {
 #define NSIGTRAP	4
 
 /*
- * There are an additional set of SIGTRAP si_codes used by ptrace
- * that of the form: ((PTRACE_EVENT_XXX << 8) | SIGTRAP)
+ * There is an additional set of SIGTRAP si_codes used by ptrace
+ * that are of the form: ((PTRACE_EVENT_XXX << 8) | SIGTRAP)
  */
 
 /*
