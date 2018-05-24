Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157710-2-14172965278939441708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527157710; b=jC7BYMYc+Z0ZvY2o5yVHyF1nIqgrIGd4wz0qzN7/43ghF/t99p
    v4lmElF86zuoeM8SiUClaQKBZlvQeVvBl5Gm8VJZDS1LB6Gwbtws+tMEOfz9L9zL
    aFbvi6oAMV5wF9Ngroq27ufukOOONHwYwSoJk9fHk0MOfWsryP3lCaEZkvul7qTV
    kC0rgJGa5tkQdSJfzS3wWWvvx82ly199r1fwXcpgr/mVZs5VoJ7OWLtvN9HKYp2v
    BkZCSYb2QKeyj2MbSaemZ4MBsPHqorqku++Zuuk6rnDaxxkZfuqBiUZd7c9dN2V9
    mAFOVHwDpkx8tAWwlJ0K13V+8Tx2uBc1gfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157710; bh=wfc+JUlc33MCoAf6Zb1Tti8VJCzT1K
    NbEo7ykm4++8M=; b=VV8qQF+xKbl1Wk/68anxFaxt8CzDEMbhx7DeuWV0Myv5lh
    Fs+pG22+UjnMupcsstffOadsH3+Hy/FUfgttQtGSjl/61msthBWn1Sv2d/CvYXJL
    dYKX1IiiXLzCEzENWPAYoEcxr+Z8a79j5SN2f8jhZnA5ZfXky+iFtmaldr9JNcmI
    dGSNjaIhQD3eapt2WFSp75G9vrWYtdxWmuWJunjWmEZhk7ecqifQPgBmW8QJd0nF
    xoBVBPvHQlE6l0l/hW0uLW5oNMWKBYw3yLh8G0aUiRIl+DJPYlcJejfNVPW/Ncem
    9ByH3rTkicQSdcVbkJ0Za9d2+TRDzG9iiuV5k34Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=c9wlPaa9 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=c9wlPaa9 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfD6WLc0SZwTLVWM+Dz0xKOkfZzvy+zqA9zeT8w6OK+IFJ+t3Y76MAQ9DN7ennMAUzFaUKbe0A8VbY0q8HaV5EEqRMgMgiZDyDL7PNLd5Kc2Hn7vB+1uD
    6bpj6PT84/HmeSOJQXYW3gYij586nPcWR9U3NX2BFho0fmlThZ/7Pf8F6u/9+hpyTT/96/CQwGVQAgv41JYhVYQsr8HEHndoW/uLfQs/0GTaxCkq3HF8/RYv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=gmnQSCsXYF2Y8wosQKkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031129AbeEXK2Q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030942AbeEXKB2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.16 058/161] s390/lib: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:03 +0200
Message-Id: <20180524093025.442341036@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 97489e0663fa700d6e7febddc43b58df98d7bcda ]

The return from the memmove, memset, memcpy, __memset16, __memset32 and
__memset64 functions are done with "br %r14". These are indirect branches
as well and need to use execute trampolines for CONFIG_EXPOLINE=y.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/lib/mem.S |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -7,6 +7,9 @@
 
 #include <linux/linkage.h>
 #include <asm/export.h>
+#include <asm/nospec-insn.h>
+
+	GEN_BR_THUNK %r14
 
 /*
  * void *memmove(void *dest, const void *src, size_t n)
@@ -33,14 +36,14 @@ ENTRY(memmove)
 .Lmemmove_forward_remainder:
 	larl	%r5,.Lmemmove_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemmove_reverse:
 	ic	%r0,0(%r4,%r3)
 	stc	%r0,0(%r4,%r1)
 	brctg	%r4,.Lmemmove_reverse
 	ic	%r0,0(%r4,%r3)
 	stc	%r0,0(%r4,%r1)
-	br	%r14
+	BR_EX	%r14
 .Lmemmove_mvc:
 	mvc	0(1,%r1),0(%r3)
 EXPORT_SYMBOL(memmove)
@@ -77,7 +80,7 @@ ENTRY(memset)
 .Lmemset_clear_remainder:
 	larl	%r3,.Lmemset_xc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_fill:
 	cghi	%r4,1
 	lgr	%r1,%r2
@@ -95,10 +98,10 @@ ENTRY(memset)
 	stc	%r3,0(%r1)
 	larl	%r5,.Lmemset_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_fill_exit:
 	stc	%r3,0(%r1)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_xc:
 	xc	0(1,%r1),0(%r1)
 .Lmemset_mvc:
@@ -121,7 +124,7 @@ ENTRY(memcpy)
 .Lmemcpy_remainder:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)
 	la	%r1,256(%r1)
@@ -159,10 +162,10 @@ ENTRY(__memset\bits)
 	\insn	%r3,0(%r1)
 	larl	%r5,.L__memset_mvc\bits
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .L__memset_exit\bits:
 	\insn	%r3,0(%r2)
-	br	%r14
+	BR_EX	%r14
 .L__memset_mvc\bits:
 	mvc	\bytes(1,%r1),0(%r1)
 .endm
