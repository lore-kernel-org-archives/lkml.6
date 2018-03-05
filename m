Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933032AbeCEHTD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:19:03 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32068 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932679AbeCEHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:19:01 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37471646"
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
Subject: [PATCH] x86/tools/relocs: comments cleanup
Date: Mon, 5 Mar 2018 15:15:34 +0800
Message-ID: <20180305071534.43448-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: DF65948AE762.A9E14
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. typo fix: there -> their
2. remove superfluous "by"

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/tools/relocs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 5d73c443e778..fcf3fad01b08 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -37,7 +37,7 @@ static struct section *secs;
 
 static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 /*
- * Following symbols have been audited. There values are constant and do
+ * Following symbols have been audited. Their values are constant and do
  * not change if bzImage is loaded at a different physical address than
  * the address for which it has been compiled. Don't warn user about
  * absolute relocations present w.r.t these symbols.
@@ -690,7 +690,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
  *	to the start of the per_cpu area that does not change).
  *
  *	Relocations that apply to the per_cpu area need to have their
- *	offset adjusted by by the value of __per_cpu_load to make them
+ *	offset adjusted by the value of __per_cpu_load to make them
  *	point to the correct place in the loaded image (because the
  *	virtual address of .data..percpu is 0).
  *
-- 
2.14.3
