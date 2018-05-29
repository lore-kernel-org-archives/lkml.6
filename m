Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524644-1527568660-5-17364925318879523832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527568660; b=AU+xSQLZRy2BMl5HJM3/c6xvM+4bSpFa+LTUZOABly1Nbx/0/c
    zDpQlo5zjGL/F9zaFyucKEjMMSXR0L3few8OGcUTWNF2qDKo1Xtzdfyr2Jkjbdgi
    XvEJ3LE85ItkhITvhiydJ1rebyDmId8EE2ryMJi0iMtXMf20fUQto18LtvgVeP7G
    QL020YFEj1i/gYNpqcJtc/AGaV1+Mmg2I+lIRWh06Y29Py0CxQcLL1OQ//iYm0Ml
    /rRrGpWHj7gYD52Y1KWR1HOSMxyx7yBc9RRN//Wnch7h+ikrCopGGtEuVLHLKEys
    DheOsDB/YcgtVgbcHtgza8tiMn2K5/F+zklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527568660; bh=rc19uRg27Us5fp28EehDRtY5guGaXR
    Slaz0GPfVoE68=; b=K8Hee2K2GiJe90BvQKyjxFWe4cFBe/oCgGxaVwCJKUwjcV
    aM3xczajFeEUmgc86ABkUfXeNEbOl+TK5fOpJpXVLmuBhVKgE0JOfvo2fVukWpTw
    tb9LZNdmakEiIkIgqxq9S3lvjCTAbpJ+Qcuj3Pg3zbPiwWY6jhed07Rn8tFGU79h
    u6YHPBEel8SsbGDIf9qhvi/9rG4HoG7Ep4qDgFBH1M0mXlC2k8C8iM819yv5j/yF
    Xax3K5hiBtuqLlcn5w5naFBlue3rr4AVaSaSNFNe37kEpWaDuCQsI7bg5UZcAnk2
    GRmXlzEyZPRHy/4OeaTdxKu7VjIkVci6VKcgRcbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=K79fDo7E
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=CFi/tWSQ;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=K79fDo7E
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=CFi/tWSQ;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDUhZlZzGvgrEASjqapj868wgy8y/u3a9QCRnaeVQq+VgENZy1CF7Ath74nYGAeTKAsPpUPvaL81j2PdmQP4F9jyemjHQLk4JTE0cXvGb7KVx4unoq/x
    xpPgmfKQhe8CrGpZdH1bkVP4V2l+To6W9hX4qZ7IhuUgWiNkkDBtGi9OR1tXvxlLVIqbSsuIbtznPSuLXAcoHkza/mZWm0koj8Nt0PNubBKNJ1WI6Zn8cqYU
    HEirOMnACxABSRHRMYHpEQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=agizdKYkGd8A:10
    a=VUJBJC2UJ8kA:10 a=o4cBDJ48AAAA:8 a=VwQbUJbxAAAA:8 a=CL9bXbnIb7Vg_NEitggA:9
    a=hkQhBpQTBlgK7Mks:21 a=DPOZexylbpBtvwBO:21 a=x8gzFH9gYPwA:10
    a=OOX4_xUL_TWpQX1oCgna:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeE2Ehh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 00:37:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47008 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeE2Ehf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 00:37:35 -0400
X-Google-Smtp-Source: AB8JxZpLfI7Cyrxl32wg5iElXkrM0sr04HdeZ1hsllIvnlOZdpa8lGezK9tTMcOu9ycBB7FoJMYGXA==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: [PATCH 0/4] migrate swapper_pg_dir
Date: Tue, 29 May 2018 12:37:28 +0800
Message-Id: <20180529043728.27738-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Because the offset between swapper_pg_dir and _text is fixed, when
attackers break KASLR, they can calculate the address of swapper_pg_dir,
and then they can apply KSMA(Kernel Space Mirror Attack). The principle
of KSMA is to insert an entry to PGD, and this entry has type of block
with AP = 01, so attackers can read/write kernel memory directly. Details
can reference:

https://www.blackhat.com/docs/asia-18/asia-18-WANG-KSMA-Breaking-Android-kernel-isolation-and-Rooting-with-ARM-MMU-features.pdf

These patches migrate swapper_pg_dir to new place, and there is no
relationship between swapper_pg_dir and _text. Because this is done
during kernel booting, the physical address of new swapper_pg_dir may
be fixed. Do we need to further randomize it?

YaoJun (4):
  Introduce a variable to record physical address of swapper_pg_dir.
  Introduce a variable to record new virtual address of swapper_pg_dir.
  Make tramp_pg_dir and swapper_pg_dir adjacent
  Migrate swapper_pg_dir and tramp_pg_dir.

 arch/arm64/include/asm/mmu_context.h |  6 +--
 arch/arm64/include/asm/pgtable.h     |  2 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/entry.S            |  4 +-
 arch/arm64/kernel/head.S             | 10 ++--
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/sleep.S            |  2 +
 arch/arm64/kernel/vmlinux.lds.S      | 10 ++--
 arch/arm64/mm/kasan_init.c           |  6 +--
 arch/arm64/mm/mmu.c                  | 72 +++++++++++++++++++---------
 10 files changed, 74 insertions(+), 42 deletions(-)

-- 
2.17.0

