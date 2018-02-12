Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeBLUNt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:13:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeBLUNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:13:47 -0500
Date: Mon, 12 Feb 2018 21:13:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: x86-ml <x86@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, hpa@zytor.com, brgerst@gmail.com,
        linux@dominikbrodowski.net, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH] x86/entry/64: Remove unused icebp macro
Message-ID: <20180212201318.GD14640@pd.tnic>
References: <20180211104949.12992-8-linux@dominikbrodowski.net>
 <tip-5a10e729bc0aa9420a23a70b169eadd229c27bc1@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-5a10e729bc0aa9420a23a70b169eadd229c27bc1@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 02:18:55AM -0800, tip-bot for Dominik Brodowski wrote:
> Commit-ID:  5a10e729bc0aa9420a23a70b169eadd229c27bc1
> Gitweb:     https://git.kernel.org/tip/5a10e729bc0aa9420a23a70b169eadd229c27bc1
> Author:     Dominik Brodowski <linux@dominikbrodowski.net>
> AuthorDate: Sun, 11 Feb 2018 11:49:48 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 12 Feb 2018 08:06:37 +0100
> 
> x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly

Ontop:

---
From: Borislav Petkov <bp@suse.de>

That macro was touched around 2.5.8 times, judging by the full history
linux repo, but it was unused even then. Get rid of it already.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/entry/calling.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 6985440c68fa..dce7092ab24a 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -159,10 +159,6 @@ For 32-bit we have the following conventions - kernel is built with
 	.if \pop_rdi
 	popq %rdi
 	.endif
-	.endm
-
-	.macro icebp
-	.byte 0xf1
 .endm
 
 /*
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
