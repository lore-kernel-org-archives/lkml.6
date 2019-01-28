Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E721738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PvX2DHBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfA1LgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:36:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34804 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfA1LgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:36:23 -0500
Received: from zn.tnic (p200300EC2BC5DE0005C09FB834C9807E.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:de00:5c0:9fb8:34c9:807e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 228741EC0987;
        Mon, 28 Jan 2019 12:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548675382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=+siWNUPOshm1uwz8kA8Z9yfz8LTmM8s+0EMEbF/JfOc=;
        b=PvX2DHBBt1pvd+iiwP1hwGhPaO1uAscSz6lE3RVhIdUHZcMp6RzxGnaTTBjubwP6xdrH82
        p5X7AX+5RjDJIG1OuYuPzqcKqmLEetWgN4X8V/UlmiJoK3miC8VPJg8LTg0PRUMvE7s9o/
        XppV5bnUrHaQ0Rx4/y6169I3Zo4Ctpc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH] MAINTAINERS: Add Andy and Darren as arch/x86/platform/ reviewers
Date:   Mon, 28 Jan 2019 12:36:19 +0100
Message-Id: <20190128113619.19025-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... so that they can get CCed on platform patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: x86@kernel.org
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cef2104d5f2c..825cad5e01e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16652,6 +16652,15 @@ S:	Maintained
 F:	drivers/platform/x86/
 F:	drivers/platform/olpc/
 
+X86 PLATFORM DRIVERS - ARCH
+R:	Darren Hart <dvhart@infradead.org>
+R:	Andy Shevchenko <andy@infradead.org>
+L:	platform-driver-x86@vger.kernel.org
+L:	x86@kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
+S:	Maintained
+F:	arch/x86/platform
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.19.1

