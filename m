Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1789591-1526350980-2-2486098943081046963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350980; b=bumh1pWkMpiEZSjOL04O0pj33bm88YjXCTXqLI59COG38DtMW8
    NDYYTJAEXGbiOCWh5xroNcuWsPCgsEAQyWYm4iujDPCYVA78W+h5CCCicdl5WtFw
    8CpAUolsGeSjFynEv8s2Duv8Q1CQ3spk0i3Ra2l78cXaUdSsZthHj0YZXW5oEWkn
    PUlhUGslYB9CVwfAjFhlIc+As/k//AuqTwG0cwfVwJjTeu7t49XuY+nxCb9Rp4w8
    q6Jy0jIUwr31ANMQvSDqJOvBQ1uGSn9WbzxdyFaiupUOtwCxOcMjDdCrWak2lCOa
    ubG2dmP032mNjscXXWdVyRFUzP/C8fUY8A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526350980; bh=WUP2K60WNn/p8XJUiAHAiwfM1jXLfU
    IPXhGtT8oMiDM=; b=mf80Sl+aS8JJSWKhOvnG/cDb6QxIwaMM3q6JsPzAPniVpW
    GS46mYIyJklfCXcNz5pBdyWNal27o+iKUz2Uny7JdEWUKp2LKrAOcWp5eur28TnL
    Nag5K10lrDsXJCrSXn3vW3lO9vT75RPoLGiERQ+4db4BvY+F8jwCB0SPfJj5lUSx
    w6wf24SZCAwLmlGlU8z6hsY4tgZPHye8wySWdNjlKNy3NpbVvbMTkGOjw9AYhL96
    HHQhnlKX+/68d+dIRCu651+I/NM7S4Edha3clMsSkuRS3Xbse3N84ysHI0uX/QtQ
    pB7ZYDdZvz+mMBAhcKermnGUt+eWo8L2IodA3CBQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
    header.i=@nifty.com header.b=odOrta5V x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
      header.i=@nifty.com header.b=odOrta5V x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK5ulhH+dALAe6AqKW1By9HGVnEHuQUVIYJjSUP1TeLnBqhBPAWCFxR9revO0TYzlxz0Vz8E4U484PPbQDrVBSQe+lNHVH/Ib4XzDHgG3BZuyCvLQsdP
    9/2OY5v6pMqN/ld+sWK7sHXkEBairP3lv6GjBnn/lpbk4T4wgwzU1hWv7bAozKddEUj2XNfscWsNKkUkbvfJzTO8f6WzYCW5pn61Cl/COFPj4Stz6bypehQM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=c-n4J4-pAAAA:8
    a=5pKQR4BlgJI2SITdlo0A:9 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeEOCW4 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 22:22:56 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:33550 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeEOCW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 22:22:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4F2M8PH020933
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] int-ll64.h: define u{8,16,32,64} and s{8,16,32,64} based on uapi header
Date: Tue, 15 May 2018 11:22:03 +0900
Message-Id: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

<uapi/asm-generic/int-ll64.h> has the same typedefs except that it
prefixes them with double-underscore for user space.  Use them for
the kernel space typedefs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/int-ll64.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/int-ll64.h b/include/asm-generic/int-ll64.h
index ffb68d6..a248545 100644
--- a/include/asm-generic/int-ll64.h
+++ b/include/asm-generic/int-ll64.h
@@ -13,17 +13,14 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
+typedef __s8  s8;
+typedef __u8  u8;
+typedef __s16 s16;
+typedef __u16 u16;
+typedef __s32 s32;
+typedef __u32 u32;
+typedef __s64 s64;
+typedef __u64 u64;
 
 #define S8_C(x)  x
 #define U8_C(x)  x ## U
-- 
2.7.4
