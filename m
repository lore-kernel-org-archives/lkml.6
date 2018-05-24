Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155607-2-7797644365191408029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155606; b=GzDyLYLtFGGy69fIf8EQTUNxCXGw39XuLEsKPCi3tLOPcVoySB
    lF/s47okElUlHD5sZ5uSmA+aR7Szub74tQHpMotO1bo86BTfWL6R2nmLAR+ZMkfS
    eNSVChl2AWbqaScfQb8ZtgA6qv830i0ialM8vTAlKXMouKZvnw9QGF6jEafyG22M
    4J1PFgsqUm+2k01Bxdp+qu1QAyXvOjsLLS8LpMpeaiMTrmfmbmhh4fsYhP5ihUTc
    Jjdax4sRTlQA26wFsFw+/95bWtiy6H2HljiuNIWfNkuUKTZjJODGuj0udGY4qTGE
    VJ+0i5sEfAurWMlhz8YSrwhLxnZJuU/1H2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155606; bh=CRHBAGfqwMsXowRgKZm7NfWeQp56Jj
    QEqR29zT3qDaY=; b=mazPuS4SA4QMPAB/HP97/ZtUcQWid8GuLX9fy8c/W5ryyz
    KuIEHDyS169oJ3z+LymixUTaXi1n6OuQs67FZzQMoWMs/jTTiN+rQ+cBfzSF0TWT
    O7yrmiH8R+elBGWtY9SKkmCw1t+mpmFVFjE5CJJ+slzXqRAYFbqr3l8t+hGCweCY
    eYvQgU89+G8cEvM8HRfPX1kouG4CAQMTXDS/nw/ab35lII4Nw/fMqqm+/U7aFZM1
    SILN3/4Xts2F/FM+jY66LJU0DmIr1b5VG1Gj0Ak+LuhDcRtFBog4YY8lbZ+mdUUm
    jlL2IXt+JxDClCcqLl5B3W2Hylrb/wBH/tblHsPA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DPRrGfU+ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DPRrGfU+ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJMTNfTBCXQDD75/ZjebHyH0ALNuSrDzR1wQZ7ZFSv1UEZfO+CMxsKYBil7MLq16JgjXvlj8Wm8kKPipJGDYZXdfx5Jrb+LiRpZg30ug5P4LW9t26nZG
    jEiM5BaH4srR9dWBIrn6i9Dz9UIN7cQHm0wXXMJScpEMud9ZNO4JSSjDzJaeXf37jmkOpa+H5PzSYWnFH0bDhfY0qrpULVxnZv1SFP0EF9QAmnbJ4An5CC8N
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=cr4mjWP-PH8plK2SDcIA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968028AbeEXJxW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967476AbeEXJxT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.14 040/165] s390/lib: use expoline for indirect branches
Date: Thu, 24 May 2018 11:37:26 +0200
Message-Id: <20180524093623.603335457@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 arch/s390/lib/mem.S |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

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
 	stc	%r3,0(%r2)
 	cghi	%r4,1
@@ -94,7 +97,7 @@ ENTRY(memset)
 .Lmemset_fill_remainder:
 	larl	%r3,.Lmemset_mvc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_xc:
 	xc	0(1,%r1),0(%r1)
 .Lmemset_mvc:
@@ -117,7 +120,7 @@ ENTRY(memcpy)
 .Lmemcpy_remainder:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)
 	la	%r1,256(%r1)
