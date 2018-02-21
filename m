Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225B/DrtnVMlwqNy3yywazNdfsDl5MXMV/6buo4qHTufOx9eEh2SzhxDy5Ydr6mPBu0ztZkY
ARC-Seal: i=1; a=rsa-sha256; t=1519218509; cv=none;
        d=google.com; s=arc-20160816;
        b=fS3M/vkWcbRfuwAy1gKJJrONm/FPDRNxv3vU94muDMVupVDeYnrpg8nMdQN/fDJdyI
         YLcbrWChp17frKCC26BgeEyFGjjgaIdid9qAYQIwiceX2v2Op2hjXbD1eycV7AsLqs0u
         64hQjG7M3r/ICrW3tMTtXKP8dVDkwcqWOeY60nhL4DggS0y1j3VhATBS/G1fRcRCwRQB
         T+G5XHE3+A7i5aXv35bbXTCxunbhdGZB6fpwOZf3ww6/Jzv+wo2Bb3gYdB4QyEJTQ5WE
         2ajKKlZ/ezWAAk6nBaUcnsy2s0KKt25MemHG3TI5hVaZQbQCOq6PS2RV9oxty1fmRGa8
         D+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N5zlt/L+9uOA5RQIJq0X8SeLGBVaH2DuJc44Dbv/Np8=;
        b=b/t28NN0EMih0QuCUJi3d73hZbYDfRPvcPtv/4an4zl5l8LO1kap6XoEj/WV1wV250
         0OpI1vFb4uNLyENpJHhogD2TG47w0kdL4h9riJWi9w/+jvNB6AUuKpF/q4xg5X7LcOsL
         FpeWio5p7B0wEIGE6xSOns9wd/x7AqW0xNhbdS7dYieetO35ajFcluYlcwMvDr3Rk+D+
         UlAvFa8uXVLxzBUKnUwpBg/7+7kkfyvbpFujCgMC3GCa1JDqR4M9+1i08vl2qO1FpPK8
         3H/kjLOh3lRySpcC4gXIjl4nh5C+rXFdF2msaBvAyFPBcBksh+VvUY0WZQXA+y7Tlc0e
         3eJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dan.j.williams@intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 065/163] x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly
Date: Wed, 21 Feb 2018 13:48:14 +0100
Message-Id: <20180221124534.049388365@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015601288879092?=
X-GMAIL-MSGID: =?utf-8?q?1593016068087096177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 92816f571af81e9a71cc6f3dc8ce1e2fcdf7b6b8 upstream.

... same as the other macros in arch/x86/entry/calling.h

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-8-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following convent
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -131,9 +131,9 @@ For 32-bit we have the following convent
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
-	.endm
+.endm
 
-	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
@@ -163,7 +163,7 @@ For 32-bit we have the following convent
 
 	.macro icebp
 	.byte 0xf1
-	.endm
+.endm
 
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
