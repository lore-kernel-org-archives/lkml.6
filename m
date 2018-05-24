Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162922-2-328398225937045392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162921; b=Ntt7aLC0yR/pIgNS5UVvKNy5bjFbvQZC8ldYl5ot0bMFSlI6aa
    Tefs130RucS55w8Hncm0wqeNUSoAsiNkZ/XTKGZJzyyoQGSsSGsGPbhOi7W9q3n+
    MNmUWPpZSwoFA035DAO+8VDaT7zVbHQ31SkgjWavv9w2IK+uNZ/Wfei2gjAzdchp
    8ybvaTiu1u3ywHoONSkr0nRX8oF6cO5Un+/ziy+5myYDCbKVdE9pYl36V3HPfRpA
    hgg3E1dNdpv9AMewILEzUEOFJ8elUYKY5CTe/80W1Bm+t7miRRkCHXE0aGvoeJWE
    gIXq0Ybc498xJu8fEX0kzOBNuR/fCLgz/zXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162921; bh=zm6ue2deoqg1Rd3K0BYcLReJaJm+XH
    Gm1oqfMCi0ATk=; b=JiPTXiXy24caNk/G4nJnz8+yFZpIDskJPFsnPu7c+b5TZQ
    htIVW/oX+E1h9QOXsszWq0jE0hJ09n0ualiRF6fzrGFp5032Y1VXWLEdrjHSIfNu
    mVyb7ofEt5x333Q6MqpPd/DZCiV40yflZop1iAdVomRc8EkYiesE1f4d34mDZV7L
    TQxdfMWtDTTJdVkDKeQ60KN3pua0jH2tw1dXCd2AGd4mhQ5jZfBLrLFfuk6CFW+y
    hp1xSw9zZgq9omYSH+uPjCnYBcDA7sOeqKdp5rSSSkqA/DyANWX26HE2myhW4vFp
    xhiX9dy+qVNQmSoqu5ndbI6pYe1MmZcvDLY1+hxw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cfP/K2NF x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cfP/K2NF x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFYD3YfU61nj56xyHjE5rEWHPm/G+wSIHJ/kQ6DSWr8Wpa4QL7MgdSbTrdnQnKa9mDTK/xhFz9Q7p9a4rvyNdVeQpLNwrPQgEv6gRLOT312T/1BPrJCP
    ullzNuosWccigCxctAMeX6SDi47KAWMlWYuOnTLmCBPAjPmHu5FjuUUIaQUPL1YF5jVa1mKkSsGqANmoJ3pEl7/Qi215+sbA7v4vbmhrgJ75HWp45eVtobfg
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=tccZ-iFfY1LpJLNyyLIA:9
    a=UpibYsMeZQRFpsap:21 a=xaEH3FTrtNo7AcMh:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966637AbeEXLzU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966438AbeEXJqF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 77/92] s390: move expoline assembler macros to a header
Date: Thu, 24 May 2018 11:38:54 +0200
Message-Id: <20180524093206.654319837@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 6dd85fbb87d1d6b87a3b1f02ca28d7b2abd2e7ba ]

To be able to use the expoline branches in different assembler
files move the associated macros from entry.S to a new header
nospec-insn.h.

While we are at it make the macros a bit nicer to use.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/nospec-insn.h |  125 ++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/entry.S            |  105 ++++++------------------------
 2 files changed, 149 insertions(+), 81 deletions(-)
 create mode 100644 arch/s390/include/asm/nospec-insn.h

--- /dev/null
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_NOSPEC_ASM_H
+#define _ASM_S390_NOSPEC_ASM_H
+
+#ifdef __ASSEMBLY__
+
+#ifdef CONFIG_EXPOLINE
+
+/*
+ * The expoline macros are used to create thunks in the same format
+ * as gcc generates them. The 'comdat' section flag makes sure that
+ * the various thunks are merged into a single copy.
+ */
+	.macro __THUNK_PROLOG_NAME name
+	.pushsection .text.\name,"axG",@progbits,\name,comdat
+	.globl \name
+	.hidden \name
+	.type \name,@function
+\name:
+	.cfi_startproc
+	.endm
+
+	.macro __THUNK_EPILOG
+	.cfi_endproc
+	.popsection
+	.endm
+
+	.macro __THUNK_PROLOG_BR r1,r2
+	__THUNK_PROLOG_NAME __s390x_indirect_jump_r\r2\()use_r\r1
+	.endm
+
+	.macro __THUNK_BR r1,r2
+	jg	__s390x_indirect_jump_r\r2\()use_r\r1
+	.endm
+
+	.macro __THUNK_BRASL r1,r2,r3
+	brasl	\r1,__s390x_indirect_jump_r\r3\()use_r\r2
+	.endm
+
+	.macro	__DECODE_RR expand,reg,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \reg,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r2
+	\expand \r1,\r2
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_RR failed"
+	.endif
+	.endm
+
+	.macro	__DECODE_RRR expand,rsave,rtarget,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \rsave,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \rtarget,%r\r2
+	.irp r3,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r3
+	\expand \r1,\r2,\r3
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_RRR failed"
+	.endif
+	.endm
+
+	.macro __THUNK_EX_BR reg,ruse
+#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
+	exrl	0,555f
+	j	.
+#else
+	larl	\ruse,555f
+	ex	0,0(\ruse)
+	j	.
+#endif
+555:	br	\reg
+	.endm
+
+	.macro GEN_BR_THUNK reg,ruse=%r1
+	__DECODE_RR __THUNK_PROLOG_BR,\reg,\ruse
+	__THUNK_EX_BR \reg,\ruse
+	__THUNK_EPILOG
+	.endm
+
+	.macro BR_EX reg,ruse=%r1
+557:	__DECODE_RR __THUNK_BR,\reg,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	557b-.
+	.popsection
+	.endm
+
+	.macro BASR_EX rsave,rtarget,ruse=%r1
+559:	__DECODE_RRR __THUNK_BRASL,\rsave,\rtarget,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	559b-.
+	.popsection
+	.endm
+
+#else
+	.macro GEN_BR_THUNK reg,ruse=%r1
+	.endm
+
+	 .macro BR_EX reg,ruse=%r1
+	br	\reg
+	.endm
+
+	.macro BASR_EX rsave,rtarget,ruse=%r1
+	basr	\rsave,\rtarget
+	.endm
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_S390_NOSPEC_ASM_H */
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -23,6 +23,7 @@
 #include <asm/vx-insn.h>
 #include <asm/setup.h>
 #include <asm/nmi.h>
+#include <asm/nospec-insn.h>
 
 __PT_R0      =	__PT_GPRS
 __PT_R1      =	__PT_GPRS + 8
@@ -225,74 +226,16 @@ _PIF_WORK	= (_PIF_PER_TRAP)
 	.popsection
 	.endm
 
-#ifdef CONFIG_EXPOLINE
-
-	.macro GEN_BR_THUNK name,reg,tmp
-	.section .text.\name,"axG",@progbits,\name,comdat
-	.globl \name
-	.hidden \name
-	.type \name,@function
-\name:
-	.cfi_startproc
-#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
-	exrl	0,0f
-#else
-	larl	\tmp,0f
-	ex	0,0(\tmp)
-#endif
-	j	.
-0:	br	\reg
-	.cfi_endproc
-	.endm
-
-	GEN_BR_THUNK __s390x_indirect_jump_r1use_r9,%r9,%r1
-	GEN_BR_THUNK __s390x_indirect_jump_r1use_r14,%r14,%r1
-	GEN_BR_THUNK __s390x_indirect_jump_r11use_r14,%r14,%r11
-
-	.macro BASR_R14_R9
-0:	brasl	%r14,__s390x_indirect_jump_r1use_r9
-	.pushsection .s390_indirect_branches,"a",@progbits
-	.long	0b-.
-	.popsection
-	.endm
-
-	.macro BR_R1USE_R14
-0:	jg	__s390x_indirect_jump_r1use_r14
-	.pushsection .s390_indirect_branches,"a",@progbits
-	.long	0b-.
-	.popsection
-	.endm
-
-	.macro BR_R11USE_R14
-0:	jg	__s390x_indirect_jump_r11use_r14
-	.pushsection .s390_indirect_branches,"a",@progbits
-	.long	0b-.
-	.popsection
-	.endm
-
-#else	/* CONFIG_EXPOLINE */
-
-	.macro BASR_R14_R9
-	basr	%r14,%r9
-	.endm
-
-	.macro BR_R1USE_R14
-	br	%r14
-	.endm
-
-	.macro BR_R11USE_R14
-	br	%r14
-	.endm
-
-#endif /* CONFIG_EXPOLINE */
-
+	GEN_BR_THUNK %r9
+	GEN_BR_THUNK %r14
+	GEN_BR_THUNK %r14,%r11
 
 	.section .kprobes.text, "ax"
 
 ENTRY(__bpon)
 	.globl __bpon
 	BPON
-	BR_R1USE_R14
+	BR_EX	%r14
 
 /*
  * Scheduler resume function, called by switch_to
@@ -322,7 +265,7 @@ ENTRY(__switch_to)
 	TSTMSK	__LC_MACHINE_FLAGS,MACHINE_FLAG_LPP
 	jz	0f
 	.insn	s,0xb2800000,__LC_LPP		# set program parameter
-0:	BR_R1USE_R14
+0:	BR_EX	%r14
 
 .L__critical_start:
 
@@ -388,7 +331,7 @@ sie_exit:
 	xgr	%r5,%r5
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
 	lg	%r2,__SF_EMPTY+16(%r15)		# return exit reason code
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lsie_fault:
 	lghi	%r14,-EFAULT
 	stg	%r14,__SF_EMPTY+16(%r15)	# set exit reason code
@@ -445,7 +388,7 @@ ENTRY(system_call)
 	lgf	%r9,0(%r8,%r10)			# get system call add.
 	TSTMSK	__TI_flags(%r12),_TIF_TRACE
 	jnz	.Lsysc_tracesys
-	BASR_R14_R9				# call sys_xxxx
+	BASR_EX	%r14,%r9			# call sys_xxxx
 	stg	%r2,__PT_R2(%r11)		# store return value
 
 .Lsysc_return:
@@ -585,7 +528,7 @@ ENTRY(system_call)
 	lmg	%r3,%r7,__PT_R3(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
 	lg	%r2,__PT_ORIG_GPR2(%r11)
-	BASR_R14_R9			# call sys_xxx
+	BASR_EX	%r14,%r9		# call sys_xxx
 	stg	%r2,__PT_R2(%r11)	# store return value
 .Lsysc_tracenogo:
 	TSTMSK	__TI_flags(%r12),_TIF_TRACE
@@ -609,7 +552,7 @@ ENTRY(ret_from_fork)
 	lmg	%r9,%r10,__PT_R9(%r11)	# load gprs
 ENTRY(kernel_thread_starter)
 	la	%r2,0(%r10)
-	BASR_R14_R9
+	BASR_EX	%r14,%r9
 	j	.Lsysc_tracenogo
 
 /*
@@ -685,7 +628,7 @@ ENTRY(pgm_check_handler)
 	je	.Lpgm_return
 	lgf	%r9,0(%r10,%r1)		# load address of handler routine
 	lgr	%r2,%r11		# pass pointer to pt_regs
-	BASR_R14_R9			# branch to interrupt-handler
+	BASR_EX	%r14,%r9		# branch to interrupt-handler
 .Lpgm_return:
 	LOCKDEP_SYS_EXIT
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
@@ -962,7 +905,7 @@ ENTRY(psw_idle)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
 	lpswe	__SF_EMPTY(%r15)
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lpsw_idle_end:
 
 /*
@@ -1007,7 +950,7 @@ ENTRY(save_fpu_regs)
 .Lsave_fpu_regs_done:
 	oi	__LC_CPU_FLAGS+7,_CIF_FPU
 .Lsave_fpu_regs_exit:
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lsave_fpu_regs_end:
 
 /*
@@ -1054,7 +997,7 @@ load_fpu_regs:
 .Lload_fpu_regs_done:
 	ni	__LC_CPU_FLAGS+7,255-_CIF_FPU
 .Lload_fpu_regs_exit:
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lload_fpu_regs_end:
 
 .L__critical_end:
@@ -1227,7 +1170,7 @@ cleanup_critical:
 	jl	0f
 	clg	%r9,BASED(.Lcleanup_table+104)	# .Lload_fpu_regs_end
 	jl	.Lcleanup_load_fpu_regs
-0:	BR_R11USE_R14
+0:	BR_EX	%r14
 
 	.align	8
 .Lcleanup_table:
@@ -1257,7 +1200,7 @@ cleanup_critical:
 	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
 	larl	%r9,sie_exit			# skip forward to sie_exit
-	BR_R11USE_R14
+	BR_EX	%r14
 #endif
 
 .Lcleanup_system_call:
@@ -1315,7 +1258,7 @@ cleanup_critical:
 	stg	%r15,56(%r11)		# r15 stack pointer
 	# set new psw address and exit
 	larl	%r9,.Lsysc_do_svc
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_system_call_insn:
 	.quad	system_call
 	.quad	.Lsysc_stmg
@@ -1325,7 +1268,7 @@ cleanup_critical:
 
 .Lcleanup_sysc_tif:
 	larl	%r9,.Lsysc_tif
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 .Lcleanup_sysc_restore:
 	# check if stpt has been executed
@@ -1342,14 +1285,14 @@ cleanup_critical:
 	mvc	0(64,%r11),__PT_R8(%r9)
 	lmg	%r0,%r7,__PT_R0(%r9)
 1:	lmg	%r8,%r9,__LC_RETURN_PSW
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_sysc_restore_insn:
 	.quad	.Lsysc_exit_timer
 	.quad	.Lsysc_done - 4
 
 .Lcleanup_io_tif:
 	larl	%r9,.Lio_tif
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 .Lcleanup_io_restore:
 	# check if stpt has been executed
@@ -1363,7 +1306,7 @@ cleanup_critical:
 	mvc	0(64,%r11),__PT_R8(%r9)
 	lmg	%r0,%r7,__PT_R0(%r9)
 1:	lmg	%r8,%r9,__LC_RETURN_PSW
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_io_restore_insn:
 	.quad	.Lio_exit_timer
 	.quad	.Lio_done - 4
@@ -1415,17 +1358,17 @@ cleanup_critical:
 	# prepare return psw
 	nihh	%r8,0xfcfd		# clear irq & wait state bits
 	lg	%r9,48(%r11)		# return from psw_idle
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_idle_insn:
 	.quad	.Lpsw_idle_lpsw
 
 .Lcleanup_save_fpu_regs:
 	larl	%r9,save_fpu_regs
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 .Lcleanup_load_fpu_regs:
 	larl	%r9,load_fpu_regs
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 /*
  * Integer constants
