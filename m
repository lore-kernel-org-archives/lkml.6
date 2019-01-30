Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971BFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B5420857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfA3KwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:52:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3KwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:52:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0UApsi72373001
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 30 Jan 2019 02:51:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0UApsnq2372998;
        Wed, 30 Jan 2019 02:51:54 -0800
Date:   Wed, 30 Jan 2019 02:51:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-0b053bbf07867c9942d706e70040398df59de54b@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, andy.shevchenko@gmail.com,
        dvhart@infradead.org, hpa@zytor.com, bp@suse.de,
        linux-kernel@vger.kernel.org, andy@infradead.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, andy@infradead.org,
          andy.shevchenko@gmail.com, dvhart@infradead.org, bp@suse.de,
          hpa@zytor.com
In-Reply-To: <20190128113619.19025-1-bp@alien8.de>
References: <20190128113619.19025-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] MAINTAINERS: Add Andy and Darren as
 arch/x86/platform/ reviewers
Git-Commit-ID: 0b053bbf07867c9942d706e70040398df59de54b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0b053bbf07867c9942d706e70040398df59de54b
Gitweb:     https://git.kernel.org/tip/0b053bbf07867c9942d706e70040398df59de54b
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 24 Jan 2019 11:18:48 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 30 Jan 2019 11:46:49 +0100

MAINTAINERS: Add Andy and Darren as arch/x86/platform/ reviewers

... so that they can get CCed on platform patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190128113619.19025-1-bp@alien8.de
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..a98a7325df8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16631,6 +16631,15 @@ S:	Maintained
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
