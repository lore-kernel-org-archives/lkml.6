Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-722281-1525689885-2-4724122328000638984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525689885; b=B+Xd+C2/yzodyQoDwVkFXRrQkEuEacKHmv4H5eYYhPE33djV9M
    gCCIxNR3Od0GN4KchSV4ofHL/0nEinuGO4dwcaaTWpm6n+07EfwIYYGtRlDpKM8O
    7dEiiLMBBuwXApmD1TqBRWYO7QeRXlYUGOg+OJYK4tTF70uEI5BwwNYSfTMZXODT
    uzkEoUpt+yQmfBjveVYh5rsoVvyKxy6Bf3jV+sCh3SO3222Dr+mXFmuroyNDxfqO
    Qs/SbLJqaplUOCJpZpCi7HExoMlaFZdAGnyj45WR6QIaFzWEbAs2VPlQDMFyJZjN
    eu3Ngugl2WiRJVqRuJL3IV6sNl7vPL9mmLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525689885; bh=
    PTNSL307hN6TuBUwZjKrUPvOqxudW+GpR536POFupE4=; b=FOaozTwjANVaKMkq
    Jbm+sT4cCdYSOMk0KiFoZv48RK9BRhLA5W6wYhDuqtHMcXCmL7JB3PBWB6bx9Wt9
    aAB6035s/9+wmlHYmuqyTDLJFEZu0mUvwxTRojSt9zGwZkMOwUSLWMhwrRfMci4I
    bwNIz1wINWIO4AHXTGSxMLgi6aaJOoQMpDGxIXtwSjGUkkhgEuYOQKFrBuYF9sm9
    uoBqPDpX/ByzfpQt7Wa/7canVtgScHwWctcS8GBM1xBmCDv8/zAwGB5WU8sz2gyN
    o9FIDe/XRz6MAio4HEc2Es9xgM/eXFyH8HCKkWcPotG2HJ+mAsKZ8d+hUO/lxh2J
    PMOA+g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
    header.i=@amarulasolutions.com header.b=WKMrmAga x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=VAc/oOF8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amarulasolutions.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
      header.i=@amarulasolutions.com header.b=WKMrmAga x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=VAc/oOF8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amarulasolutions.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ39oddVyEklFAnS01g3MimXa4puMydOh73duSLKxXh9eFxV6qllmB1OYghlA+QmIwp1K65uoCokEIdYgj8V7Sdt0msHeqzarcK12YxlBoTEEIbv3E7X
    tT5BrDYN0JgE6QlwXE5KJ6c2B9miDLId0dg6ynlRoLrCVj3M6pAqTuINEbvqnNeOjq4tfpo9Y4fYHVVU1olbrR/nD8Dp6O7+lZrQqGQoUoM77VjD+L+bng5O
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=iP-xVBlJAAAA:8 a=07d9gI8wAAAA:8 a=Z4Rwk6OoAAAA:8 a=UE4STpl7IwCjGXJJhu0A:9
    a=AjGcO6oz07-iQ99wixmX:22 a=lHLH-nfn2y1bM_0xSXwp:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEGKom (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 06:44:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51022 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeEGKof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 06:44:35 -0400
X-Google-Smtp-Source: AB8JxZrSrAl3qGxYuZDETeEpKsrGvXR2lukahyKBC2sl7Bfvns3RuQse4HbyCGM77hHfQ4dVQ0is1Q==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 6/6] Documentation/features/vm: Remove arch support status file for 'pte_special'
Date: Mon,  7 May 2018 12:43:43 +0200
Message-Id: <1525689823-3340-7-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .../features/vm/pte_special/arch-support.txt       | 33 ----------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 Documentation/features/vm/pte_special/arch-support.txt

diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
deleted file mode 100644
index 6a608a6dcf71d..0000000000000
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Feature name:          pte_special
-#         Kconfig:       __HAVE_ARCH_PTE_SPECIAL
-#         description:   arch supports the pte_special()/pte_mkspecial() VM APIs
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: |  ok  |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: | TODO |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: | TODO |
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |       riscv: | TODO |
-    |        s390: |  ok  |
-    |          sh: |  ok  |
-    |       sparc: |  ok  |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: | TODO |
-    -----------------------
-- 
2.7.4
