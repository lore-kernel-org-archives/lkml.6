Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fCiceVHG90e63ocuBjnKmCwqPyekwZ8KV6v5daxifdACu/8WcVvgFEol0FfZ7BbVoEMGx
ARC-Seal: i=1; a=rsa-sha256; t=1517855094; cv=none;
        d=google.com; s=arc-20160816;
        b=oqEZVz8R+R2eybbPPr5+DscPXJ6ptjFFNgQWxMCm/dZGPs6G3V/KSEbaAWJKxKZ747
         GhoqDAWc2c1Wwajq/slp/9y5Ri545SwKAE16oy5ileTjNPSODYgBUZntBqBrDAYdK3Bi
         YvVgxcHPeQTW4H4Ef6rwmqT3ohW46xfKlgp3K9sJB21Ww4bYYtGqt7xCLIJF75TDixs4
         mdaBCjCdBL0DIhXlKTO5AS5TDS+T96lSlP3pi+whHX/CB/zvFND/mA2cYvg9QM6iKOzO
         xxn2b8bq79wQvszzdAYJ4/Z0bwibAwaQ+SPHGu8IdfGnM9iq6u4u4J4ELQI12AcoELKl
         CgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LxR3sAtbUWrUKWNfajd8JWqV3/OXPOj2uSRD253vRTw=;
        b=ApNcSob+dXxazsu1l8AAFUbamLCu/7OgQQK1OQiPeXx/DseSoOnJQJm7qOqnVq6fXT
         qPjIyNf69lE+x+Cb6wKdiaYwthrhwQYw6+zB1s5UU0HKWu1T0QhbI2OWcNR6kwZO9VrK
         hVOR1Md3LhGFyWt1iVnM4iQXOuP0YUhO6k7NjuSx5g929uP6miY8qKwsC6jWq57VwZ0D
         /XBUoToNEe+CXF6urEv4qf9/NLsNDmuu1jLQu1AHHDjMXRRQgs9McQwCpdSjV6q6Hfp1
         eRlQ3TN1iP80HJ3fSqIahPtKwHiylFeU4H3usOY7/C2OefS0t+mIdHqV73EvQ4aW+Qvo
         ltGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	riel@redhat.com,
	ak@linux.intel.com,
	peterz@infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	jikos@kernel.org,
	luto@amacapital.net,
	dave.hansen@intel.com,
	torvalds@linux-foundation.org,
	keescook@google.com,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	tim.c.chen@linux.intel.com,
	pjt@google.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 12/60] x86/nospec: Fix header guards names
Date: Mon,  5 Feb 2018 10:22:45 -0800
Message-Id: <20180205182214.432175952@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586339077269588?=
X-GMAIL-MSGID: =?utf-8?q?1591586424362965906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@suse.de

commit 7a32fc51ca938e67974cbb9db31e1a43f98345a9

... to adhere to the _ASM_X86_ naming scheme.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-3-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/nospec-branch.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __NOSPEC_BRANCH_H__
-#define __NOSPEC_BRANCH_H__
+#ifndef _ASM_X86_NOSPEC_BRANCH_H_
+#define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
@@ -232,4 +232,4 @@ static inline void indirect_branch_predi
 }
 
 #endif /* __ASSEMBLY__ */
-#endif /* __NOSPEC_BRANCH_H__ */
+#endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
