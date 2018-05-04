Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3611583-1525407413-2-17614128487755403797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525407412; b=InCAaWMF9aksrwDm7XM2mdgiGLNi1FbYVaJtyR2eVHa75S16Mi
    Z2bxtZGCt9bxPwQ/uwigVr/ocUdIwV8V4UN+USCfq9rU/iRNpyIAk0vOLAglBkkZ
    IAxJwzbeZ1a3o1n35L6XshW5PwOTjVKgHhmxq5SE2j5pxaPpNyouArYYp9YjZk68
    k16nKN6Zi0ON9g8u2RzzAj8og/pnOdjp06LVoOxwTnToktttoscaZWmkl5ydgyBB
    7sKW/BUA6/OSwF7FOlLbl5TiUETsGjUn+BgEw+fCkyTlBaKUnGVo6ILDHIFCm5kO
    VQTrPSK2Faa3bXf62q1u6RWKks4LbHvGPcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525407412;
    bh=DjuVfEogpdgQSyMRRy/18fOfcCEiWQOePuzGmkMwgHc=; b=EMj4hSk7ypXY
    HVYUq/RAFDJsPb7P3hQSI0ZgG57oBZWFLe71+LWtdUmvsIiIk7GNUFuaTbLcqaic
    utOKm4LpYMv5LaMyWnx6vLw5u1T3XvtZbzZJH5DVbEjtDP1vWvGoVF1+8qwsf3cg
    D7Delh3BP5dKKIhAxuco1bf4O193UDFJ+Hll7mzChU+hpPtHk8xDUE8d1SqfnVof
    PKWHWfc1M4An/dM5PNSx7YaVdeTl6PhEaxwUXKvINbwR7/1uOA3SWMq6gi8qaJ7q
    BnbJaLBfpeZvAoaVSkoZYfnk5pnkfzqAYDQIWP9fa06qpeMakswBKQ5Jqd9XUCkQ
    OkOkBoKAcA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VGEeltiS x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VGEeltiS x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIyspHfs4OJDAyIE9WYIQ84kc59WrZ9T0m4Mx4oni94VBaKx9zs4H+wtOI+V3wkbvuBDchgoSZz0a/OJg905nOpGGgiYVJjC2i7j/umFrOzVK/5nJTKM
    obLTJKz9+snATw50gL5z8oX0EjPe87qCMrRxQ1TQR5WtAu7vpU6xtnHWuceStmP3wtHoicakkOGVTY6iAU389go/NyZo0I7u6B1cukQuAk2VyBoroZamlJRB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Bm5lvbky7RdN8-YtJ6kA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeEDEQv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 00:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDEQu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 00:16:50 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, David Long <dave.long@linaro.org>,
        stable@vger.kernel.org
Subject: [BUGFIX PATCH v3 4/4] arm: kprobes: Prohibit kprobes on get_user functions
Date: Fri,  4 May 2018 13:16:27 +0900
Message-Id: <152540738682.29650.10638462666953783065.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152540727123.29650.13679359124038587629.stgit@devbox>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since do_undefinstr() uses get_user to get the undefined
instruction, it can be called before kprobes processes
recursive check. This can cause an infinit recursive
exception.
Prohibit probing on get_user functions.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v2:
  - Fix to add _ASM_NOKPROBE() definition for
    !CONFIG_KPROBES.
---
 arch/arm/include/asm/assembler.h |   10 ++++++++++
 arch/arm/lib/getuser.S           |   10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index bc8d4bbd82e2..9342904cccca 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -536,4 +536,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(entry)				\
+	.pushsection "_kprobe_blacklist", "aw" ;	\
+	.balign 4 ;					\
+	.long entry;					\
+	.popsection
+#else
+#define _ASM_NOKPROBE(entry)
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index df73914e81c8..746e7801dcdf 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -38,6 +38,7 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_1)
+_ASM_NOKPROBE(__get_user_1)
 
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -58,6 +59,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_2)
+_ASM_NOKPROBE(__get_user_2)
 
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -65,6 +67,7 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_4)
+_ASM_NOKPROBE(__get_user_4)
 
 ENTRY(__get_user_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad8
@@ -78,6 +81,7 @@ ENTRY(__get_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_8)
+_ASM_NOKPROBE(__get_user_8)
 
 #ifdef __ARMEB__
 ENTRY(__get_user_32t_8)
@@ -91,6 +95,7 @@ ENTRY(__get_user_32t_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_32t_8)
+_ASM_NOKPROBE(__get_user_32t_8)
 
 ENTRY(__get_user_64t_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad8
@@ -98,6 +103,7 @@ ENTRY(__get_user_64t_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_1)
+_ASM_NOKPROBE(__get_user_64t_1)
 
 ENTRY(__get_user_64t_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad8
@@ -114,6 +120,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_2)
+_ASM_NOKPROBE(__get_user_64t_2)
 
 ENTRY(__get_user_64t_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad8
@@ -121,6 +128,7 @@ ENTRY(__get_user_64t_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_4)
+_ASM_NOKPROBE(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
@@ -131,6 +139,8 @@ __get_user_bad:
 	ret	lr
 ENDPROC(__get_user_bad)
 ENDPROC(__get_user_bad8)
+_ASM_NOKPROBE(__get_user_bad)
+_ASM_NOKPROBE(__get_user_bad8)
 
 .pushsection __ex_table, "a"
 	.long	1b, __get_user_bad
