Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513143-2-652953022826259211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.67', Host='mail-pl0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513143; b=mvvwIyG5mOIK1Ulzm9DC3lfioq5upS1hn38Jg2GzEydcQ0W
    EXvl+2WGptLTGvI3w3zZ54MJY0AawORVtoO7sOPsZ3TRxNI3pehEq0DsivRzlv2d
    2Y6mpVwPwWMD4X8A287hZT2BcZvOgMx0X8qRaJ4EFOAo6U/SWtpoBkkunuMX2x4w
    nPlI5xR2FQuAU05j4O7OJaJaXxhb1DXp9IVNry5yuxLX7TS+9BRnMcxcjKfXJiPg
    sNl+cRP7ZMH4SdvJkbqFRMAD2KGoSXCVW0N3/bnWlHTnVoiWTdUTCXNVkdu1G8wb
    jwO6ECR/W4bwdKsIBzioVvBzV9rLgeC4q6oIDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513143; bh=To7Z/V0CTFvNUfNMUr2UR1McwrflSceQXzPzAzdgKp4=; b=X
    DdExT6Ar6bDWD6FeA0TKnojye0MGppRmFLYtKIwFTNrqAvabQ96xlo69VLN5N5vS
    Z4UT6TrgTPXp1fLPndMviOGZ4eInujyOIzZ3sxfLLez2Ewz0vHmtJ0moJc41cNOt
    BARYrP35rlKjEwlu7F/EfgyJNFbSXmgIjB5+BYkiXyMNHdh1h0jMeADwlYEp3utV
    4k4cYaXf8gxENa8PjhjscrlDXtnp9wS/4vFMs18fIkyvKMsrZYhXECKQpFUhuUW8
    P/4PBbU2R6VYzzA223oSTvzkaq5lrB7tUzE+kLfmfM5wf9frKMmcTVJE6Hme+JiA
    PEx4j/4MgKapXwUGUwa2g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YI0iLQnT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X8H48LmW;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YI0iLQnT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X8H48LmW;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x2247cU6eq2NYnl6ZKlDasK2lEuE12pMkrJyHNSk1tFYxnE2JQZySc5+zn/pHDuWZBwFKe07ikw==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 21/37] nds32: Signal handling support
Date: Tue, 13 Feb 2018 17:09:25 +0800
Message-Id: <9555e01391f4782635b6a23e1805cb890d4ee36f.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for signal handling.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/uapi/asm/sigcontext.h |  60 ++++++
 arch/nds32/kernel/signal.c               | 324 +++++++++++++++++++++++++++++++
 2 files changed, 384 insertions(+)
 create mode 100644 arch/nds32/include/uapi/asm/sigcontext.h
 create mode 100644 arch/nds32/kernel/signal.c

diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..00567b237b0c
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef _ASMNDS32_SIGCONTEXT_H
+#define _ASMNDS32_SIGCONTEXT_H
+
+/*
+ * Signal context structure - contains all info to do with the state
+ * before the signal handler was invoked.  Note: only add new entries
+ * to the end of the structure.
+ */
+
+struct zol_struct {
+	unsigned long nds32_lc;	/* $LC */
+	unsigned long nds32_le;	/* $LE */
+	unsigned long nds32_lb;	/* $LB */
+};
+
+struct sigcontext {
+	unsigned long trap_no;
+	unsigned long error_code;
+	unsigned long oldmask;
+	unsigned long nds32_r0;
+	unsigned long nds32_r1;
+	unsigned long nds32_r2;
+	unsigned long nds32_r3;
+	unsigned long nds32_r4;
+	unsigned long nds32_r5;
+	unsigned long nds32_r6;
+	unsigned long nds32_r7;
+	unsigned long nds32_r8;
+	unsigned long nds32_r9;
+	unsigned long nds32_r10;
+	unsigned long nds32_r11;
+	unsigned long nds32_r12;
+	unsigned long nds32_r13;
+	unsigned long nds32_r14;
+	unsigned long nds32_r15;
+	unsigned long nds32_r16;
+	unsigned long nds32_r17;
+	unsigned long nds32_r18;
+	unsigned long nds32_r19;
+	unsigned long nds32_r20;
+	unsigned long nds32_r21;
+	unsigned long nds32_r22;
+	unsigned long nds32_r23;
+	unsigned long nds32_r24;
+	unsigned long nds32_r25;
+	unsigned long nds32_fp;	/* $r28 */
+	unsigned long nds32_gp;	/* $r29 */
+	unsigned long nds32_lp;	/* $r30 */
+	unsigned long nds32_sp;	/* $r31 */
+	unsigned long nds32_ipc;
+	unsigned long fault_address;
+	unsigned long used_math_flag;
+	/* FPU Registers */
+	struct zol_struct zol;
+};
+
+#endif
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
new file mode 100644
index 000000000000..5d01f6e33cb8
--- /dev/null
+++ b/arch/nds32/kernel/signal.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/ptrace.h>
+#include <linux/personality.h>
+#include <linux/freezer.h>
+#include <linux/tracehook.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/ucontext.h>
+#include <asm/unistd.h>
+
+#include <asm/ptrace.h>
+#include <asm/vdso.h>
+
+struct rt_sigframe {
+	struct siginfo info;
+	struct ucontext uc;
+};
+
+static int restore_sigframe(struct pt_regs *regs,
+			    struct rt_sigframe __user * sf)
+{
+	sigset_t set;
+	int err;
+
+	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
+	if (err == 0) {
+		set_current_blocked(&set);
+	}
+
+	__get_user_error(regs->uregs[0], &sf->uc.uc_mcontext.nds32_r0, err);
+	__get_user_error(regs->uregs[1], &sf->uc.uc_mcontext.nds32_r1, err);
+	__get_user_error(regs->uregs[2], &sf->uc.uc_mcontext.nds32_r2, err);
+	__get_user_error(regs->uregs[3], &sf->uc.uc_mcontext.nds32_r3, err);
+	__get_user_error(regs->uregs[4], &sf->uc.uc_mcontext.nds32_r4, err);
+	__get_user_error(regs->uregs[5], &sf->uc.uc_mcontext.nds32_r5, err);
+	__get_user_error(regs->uregs[6], &sf->uc.uc_mcontext.nds32_r6, err);
+	__get_user_error(regs->uregs[7], &sf->uc.uc_mcontext.nds32_r7, err);
+	__get_user_error(regs->uregs[8], &sf->uc.uc_mcontext.nds32_r8, err);
+	__get_user_error(regs->uregs[9], &sf->uc.uc_mcontext.nds32_r9, err);
+	__get_user_error(regs->uregs[10], &sf->uc.uc_mcontext.nds32_r10, err);
+	__get_user_error(regs->uregs[11], &sf->uc.uc_mcontext.nds32_r11, err);
+	__get_user_error(regs->uregs[12], &sf->uc.uc_mcontext.nds32_r12, err);
+	__get_user_error(regs->uregs[13], &sf->uc.uc_mcontext.nds32_r13, err);
+	__get_user_error(regs->uregs[14], &sf->uc.uc_mcontext.nds32_r14, err);
+	__get_user_error(regs->uregs[15], &sf->uc.uc_mcontext.nds32_r15, err);
+	__get_user_error(regs->uregs[16], &sf->uc.uc_mcontext.nds32_r16, err);
+	__get_user_error(regs->uregs[17], &sf->uc.uc_mcontext.nds32_r17, err);
+	__get_user_error(regs->uregs[18], &sf->uc.uc_mcontext.nds32_r18, err);
+	__get_user_error(regs->uregs[19], &sf->uc.uc_mcontext.nds32_r19, err);
+	__get_user_error(regs->uregs[20], &sf->uc.uc_mcontext.nds32_r20, err);
+	__get_user_error(regs->uregs[21], &sf->uc.uc_mcontext.nds32_r21, err);
+	__get_user_error(regs->uregs[22], &sf->uc.uc_mcontext.nds32_r22, err);
+	__get_user_error(regs->uregs[23], &sf->uc.uc_mcontext.nds32_r23, err);
+	__get_user_error(regs->uregs[24], &sf->uc.uc_mcontext.nds32_r24, err);
+	__get_user_error(regs->uregs[25], &sf->uc.uc_mcontext.nds32_r25, err);
+
+	__get_user_error(regs->fp, &sf->uc.uc_mcontext.nds32_fp, err);
+	__get_user_error(regs->gp, &sf->uc.uc_mcontext.nds32_gp, err);
+	__get_user_error(regs->lp, &sf->uc.uc_mcontext.nds32_lp, err);
+	__get_user_error(regs->sp, &sf->uc.uc_mcontext.nds32_sp, err);
+	__get_user_error(regs->ipc, &sf->uc.uc_mcontext.nds32_ipc, err);
+#if defined(CONFIG_HWZOL)
+	__get_user_error(regs->lc, &sf->uc.uc_mcontext.zol.nds32_lc, err);
+	__get_user_error(regs->le, &sf->uc.uc_mcontext.zol.nds32_le, err);
+	__get_user_error(regs->lb, &sf->uc.uc_mcontext.zol.nds32_lb, err);
+#endif
+
+	/*
+	 * Avoid sys_rt_sigreturn() restarting.
+	 */
+	forget_syscall(regs);
+	return err;
+}
+
+asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	/*
+	 * Since we stacked the signal on a 64-bit boundary,
+	 * then 'sp' should be two-word aligned here.  If it's
+	 * not, then the user is trying to mess with us.
+	 */
+	if (regs->sp & 7)
+		goto badframe;
+
+	frame = (struct rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+
+	if (restore_sigframe(regs, frame))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->uregs[0];
+
+badframe:
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+static int
+setup_sigframe(struct rt_sigframe __user * sf, struct pt_regs *regs,
+	       sigset_t * set)
+{
+	int err = 0;
+
+	__put_user_error(regs->uregs[0], &sf->uc.uc_mcontext.nds32_r0, err);
+	__put_user_error(regs->uregs[1], &sf->uc.uc_mcontext.nds32_r1, err);
+	__put_user_error(regs->uregs[2], &sf->uc.uc_mcontext.nds32_r2, err);
+	__put_user_error(regs->uregs[3], &sf->uc.uc_mcontext.nds32_r3, err);
+	__put_user_error(regs->uregs[4], &sf->uc.uc_mcontext.nds32_r4, err);
+	__put_user_error(regs->uregs[5], &sf->uc.uc_mcontext.nds32_r5, err);
+	__put_user_error(regs->uregs[6], &sf->uc.uc_mcontext.nds32_r6, err);
+	__put_user_error(regs->uregs[7], &sf->uc.uc_mcontext.nds32_r7, err);
+	__put_user_error(regs->uregs[8], &sf->uc.uc_mcontext.nds32_r8, err);
+	__put_user_error(regs->uregs[9], &sf->uc.uc_mcontext.nds32_r9, err);
+	__put_user_error(regs->uregs[10], &sf->uc.uc_mcontext.nds32_r10, err);
+	__put_user_error(regs->uregs[11], &sf->uc.uc_mcontext.nds32_r11, err);
+	__put_user_error(regs->uregs[12], &sf->uc.uc_mcontext.nds32_r12, err);
+	__put_user_error(regs->uregs[13], &sf->uc.uc_mcontext.nds32_r13, err);
+	__put_user_error(regs->uregs[14], &sf->uc.uc_mcontext.nds32_r14, err);
+	__put_user_error(regs->uregs[15], &sf->uc.uc_mcontext.nds32_r15, err);
+	__put_user_error(regs->uregs[16], &sf->uc.uc_mcontext.nds32_r16, err);
+	__put_user_error(regs->uregs[17], &sf->uc.uc_mcontext.nds32_r17, err);
+	__put_user_error(regs->uregs[18], &sf->uc.uc_mcontext.nds32_r18, err);
+	__put_user_error(regs->uregs[19], &sf->uc.uc_mcontext.nds32_r19, err);
+	__put_user_error(regs->uregs[20], &sf->uc.uc_mcontext.nds32_r20, err);
+
+	__put_user_error(regs->uregs[21], &sf->uc.uc_mcontext.nds32_r21, err);
+	__put_user_error(regs->uregs[22], &sf->uc.uc_mcontext.nds32_r22, err);
+	__put_user_error(regs->uregs[23], &sf->uc.uc_mcontext.nds32_r23, err);
+	__put_user_error(regs->uregs[24], &sf->uc.uc_mcontext.nds32_r24, err);
+	__put_user_error(regs->uregs[25], &sf->uc.uc_mcontext.nds32_r25, err);
+	__put_user_error(regs->fp, &sf->uc.uc_mcontext.nds32_fp, err);
+	__put_user_error(regs->gp, &sf->uc.uc_mcontext.nds32_gp, err);
+	__put_user_error(regs->lp, &sf->uc.uc_mcontext.nds32_lp, err);
+	__put_user_error(regs->sp, &sf->uc.uc_mcontext.nds32_sp, err);
+	__put_user_error(regs->ipc, &sf->uc.uc_mcontext.nds32_ipc, err);
+#if defined(CONFIG_HWZOL)
+	__put_user_error(regs->lc, &sf->uc.uc_mcontext.zol.nds32_lc, err);
+	__put_user_error(regs->le, &sf->uc.uc_mcontext.zol.nds32_le, err);
+	__put_user_error(regs->lb, &sf->uc.uc_mcontext.zol.nds32_lb, err);
+#endif
+
+	__put_user_error(current->thread.trap_no, &sf->uc.uc_mcontext.trap_no,
+			 err);
+	__put_user_error(current->thread.error_code,
+			 &sf->uc.uc_mcontext.error_code, err);
+	__put_user_error(current->thread.address,
+			 &sf->uc.uc_mcontext.fault_address, err);
+	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
+
+	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+
+	return err;
+}
+
+static inline void __user *get_sigframe(struct ksignal *ksig,
+					struct pt_regs *regs, int framesize)
+{
+	unsigned long sp;
+
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
+
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = (sigsp(sp, ksig) - framesize);
+
+	/*
+	 * nds32 mandates 8-byte alignment
+	 */
+	sp &= ~0x7UL;
+
+	return (void __user *)sp;
+}
+
+static int
+setup_return(struct pt_regs *regs, struct ksignal *ksig, void __user * frame)
+{
+	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
+	unsigned long retcode;
+
+	retcode = VDSO_SYMBOL(current->mm->context.vdso, rt_sigtramp);
+	regs->uregs[0] = ksig->sig;
+	regs->sp = (unsigned long)frame;
+	regs->lp = retcode;
+	regs->ipc = handler;
+
+	return 0;
+}
+
+static int
+setup_rt_frame(struct ksignal *ksig, sigset_t * set, struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame =
+	    get_sigframe(ksig, regs, sizeof(*frame));
+	int err = 0;
+
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		return -EFAULT;
+
+	__put_user_error(0, &frame->uc.uc_flags, err);
+	__put_user_error(NULL, &frame->uc.uc_link, err);
+
+	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
+	err |= setup_sigframe(frame, regs, set);
+	if (err == 0) {
+		setup_return(regs, ksig, frame);
+		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+			regs->uregs[1] = (unsigned long)&frame->info;
+			regs->uregs[2] = (unsigned long)&frame->uc;
+		}
+	}
+	return err;
+}
+
+/*
+ * OK, we're invoking a handler
+ */
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+{
+	int ret;
+	sigset_t *oldset = sigmask_to_save();
+
+	if (in_syscall(regs)) {
+		/* Avoid additional syscall restarting via ret_slow_syscall. */
+		forget_syscall(regs);
+
+		switch (regs->uregs[0]) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->uregs[0] = -EINTR;
+			break;
+		case -ERESTARTSYS:
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
+				regs->uregs[0] = -EINTR;
+				break;
+			}
+		case -ERESTARTNOINTR:
+			regs->uregs[0] = regs->orig_r0;
+			regs->ipc -= 4;
+			break;
+		}
+	}
+	/*
+	 * Set up the stack frame
+	 */
+	ret = setup_rt_frame(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, 0);
+}
+
+/*
+ * Note that 'init' is a special process: it doesn't get signals it doesn't
+ * want to handle. Thus you cannot kill init even with a SIGKILL even by
+ * mistake.
+ *
+ * Note that we go through the signals twice: once to check the signals that
+ * the kernel can handle, and then we build all the user-level signal handling
+ * stack-frames in one go after that.
+ */
+static void do_signal(struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	if (get_signal(&ksig)) {
+		handle_signal(&ksig, regs);
+		return;
+	}
+
+	/*
+	 * If we were from a system call, check for system call restarting...
+	 */
+	if (in_syscall(regs)) {
+		/* Restart the system call - no handlers present */
+
+		/* Avoid additional syscall restarting via ret_slow_syscall. */
+		forget_syscall(regs);
+
+		switch (regs->uregs[0]) {
+		case -ERESTART_RESTARTBLOCK:
+			regs->uregs[15] = __NR_restart_syscall;
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			regs->uregs[0] = regs->orig_r0;
+			regs->ipc -= 0x4;
+			break;
+		}
+	}
+	restore_saved_sigmask();
+}
+
+asmlinkage void
+do_notify_resume(struct pt_regs *regs, unsigned int thread_flags)
+{
+	if (thread_flags & _TIF_SIGPENDING)
+		do_signal(regs);
+
+	if (thread_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
+}
-- 
2.16.1
