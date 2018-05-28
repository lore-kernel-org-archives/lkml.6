Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490967-2-683927074339571538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490966; b=JzTJtb8zRS+o7etyGquU3WTZDq0l+qDlfY7mSuNVRwWBoOCl7w
    tGwC3CUu+5WzlNDEsfgHzU5EP2dOTlpoXHeT/Y1DWIGAx3LC1SX58ZtxQVuWifb0
    vj2FP/MM9jPDDhm8MmgKLvCEvDLtsjdHh7UEHHz34EmfsyXJQbzGZkGv67Rt4ZlS
    uRHlNhQTufd5S/X83CA/nOLlFMSJdi98TjyzU+Q0nn6GNXeVcKQa3OX7ZpuKEzva
    tr17ksN0HKlN2IRmg1yqxG16IIpnVfV+VJcyrUxhQfbzJSEingqYEpwFUMVR4/xc
    edMVvJPqrkN/FRMqEonyNV5w53DcktmW28TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527490966;
    bh=Ve9XtkMvnZ2i6fyzAU8TlOt86x8/YnCHcwKT/UUmHjU=; b=euKA6v6oKDLv
    oyhltvfPSnLbM/5Mxn4udBjV25XDQqetmqjB41zibGsTOwzKr7oQ1B30R/NszeVF
    z8vSOEtNHkHR/1cX90nCIcNiUdCLjhjdk1uQQAmCKG8eUweL6wKV+trT0tzoIChH
    vfoEdidP0mA5u7ll6ULbt/BNuHcZe64sSpjFNqS40KRcyc9xXR9BjxQ/Li9A+XsO
    r9Um7I86nnbgWqUivXDTQWckR3FlxDUtORoMNN/cfpcNNgUCYOVLHjWu2EyXm84a
    56ugjYvIQ0zqLjqAPXJORiBWGgWEMBt3SGJ/msa9CJMP8cQKqRAk0Ccfm1on03Zd
    deb+xNjenA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VRoLURT+ header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VRoLURT+ header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCpyuAYf91DkRKLeSCMu80Dd45TqeR/K7RPEdn4Ds0rTNot0csQA5iwoIB0wzawJrnBXdQ0TiAP0irbXlv9qIPFUzxg0QOpKIErHMQTGuQop6HgnC+AR
    FndOahXW2cBn8kOq5m016rfiqzxEN0jK2IMgcdFRT8bHjLeroqrAN+w12AZSSeIpvIWvGHyp4GpXQAKzSTcvf3Fi+a4vqKhCBYakDBVj7SbZ1rIOC45OgyKf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ETQ_ECji3JOGjVEKxJ8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeE1HCp (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753410AbeE1HCo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:02:44 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org
Subject: [PATCH -tip v4 06/27] arm64: kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:02:18 +0900
Message-Id: <152749093793.15132.14181963929820794622.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/arm64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/include/asm/kprobes.h   |    1 -
 arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 6deb8d726041..d5a44cf859e9 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -48,7 +48,6 @@ struct kprobe_ctlblk {
 	unsigned long saved_irqflag;
 	struct prev_kprobe prev_kprobe;
 	struct kprobe_step_ctx ss_ctx;
-	struct pt_regs jprobe_saved_regs;
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..3ca2351109a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,74 +465,6 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 	return DBG_HOOK_HANDLED;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	/*
-	 * Since we can't be sure where in the stack frame "stacked"
-	 * pass-by-value arguments are stored we just don't try to
-	 * duplicate any of the stack. Do not use jprobes on functions that
-	 * use more than 64 bytes (after padding each to an 8 byte boundary)
-	 * of arguments, or pass individual arguments larger than 16 bytes.
-	 */
-
-	instruction_pointer_set(regs, (unsigned long) jp->entry);
-	preempt_disable();
-	pause_graph_tracing();
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/*
-	 * Jprobe handler return by entering break exception,
-	 * encoded same as kprobe, but with following conditions
-	 * -a special PC to identify it from the other kprobes.
-	 * -restore stack addr to original saved pt_regs
-	 */
-	asm volatile("				mov sp, %0	\n"
-		     "jprobe_return_break:	brk %1		\n"
-		     :
-		     : "r" (kcb->jprobe_saved_regs.sp),
-		       "I" (BRK64_ESR_KPROBES)
-		     : "memory");
-
-	unreachable();
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_addr = kcb->jprobe_saved_regs.sp;
-	long orig_sp = kernel_stack_pointer(regs);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	extern const char jprobe_return_break[];
-
-	if (instruction_pointer(regs) != (u64) jprobe_return_break)
-		return 0;
-
-	if (orig_sp != stack_addr) {
-		struct pt_regs *saved_regs =
-		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
-		pr_err("current sp %lx does not match saved sp %lx\n",
-		       orig_sp, stack_addr);
-		pr_err("Saved registers for jprobe %p\n", jp);
-		__show_regs(saved_regs);
-		pr_err("Current registers\n");
-		__show_regs(regs);
-		BUG();
-	}
-	unpause_graph_tracing();
-	*regs = kcb->jprobe_saved_regs;
-	preempt_enable_no_resched();
-	return 1;
-}
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	if ((addr >= (unsigned long)__kprobes_text_start &&
