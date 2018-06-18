Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56545C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AA02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="af+pCnWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AA02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935510AbeFRVlt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755076AbeFRVls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:41:48 -0400
Received: from localhost (unknown [198.217.64.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168E720693;
        Mon, 18 Jun 2018 21:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529358108;
        bh=ByktAGxblbcmKtyQWeSXbmNn3tqcUBs4k7WpQnjllvg=;
        h=From:To:Cc:Subject:Date:From;
        b=af+pCnWTh1eC4UyFHKG0pu9kBqfSzA11Oz1bwoLxdnKpOlZDArd5H7rKYqYhShGQJ
         WTHB9wNoId0W9uhI35THc+5FRqpAaKljQMc2f+Hg5cfSVykHtYVKHieozio+tpxvMI
         DC6EejEBmgDG1lI8osOOTgoX7XaYN1YNTWzbhGF0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Add me as an x86 entry code maintainer
Date:   Mon, 18 Jun 2018 14:41:36 -0700
Message-Id: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And update my email address.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Linus has been saying that I might as well maintain this stuff for years.
What do you all think?

MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..624c3fd11d04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15575,6 +15575,13 @@ S:	Maintained
 F:	Documentation/x86/
 F:	arch/x86/
 
+X86 ENTRY CODE
+M:	Andy Lutomirski <luto@kernel.org>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
+S:	Maintained
+F:	arch/x86/entry/
+
 X86 MCE INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
@@ -15597,7 +15604,7 @@ F:	drivers/platform/x86/
 F:	drivers/platform/olpc/
 
 X86 VDSO
-M:	Andy Lutomirski <luto@amacapital.net>
+M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
 S:	Maintained
-- 
2.17.1

