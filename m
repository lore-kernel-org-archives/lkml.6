Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC23C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2C72456B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2C72456B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeFVQB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:01:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeFVQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:01:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MG136f127119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 09:01:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MG128G127116;
        Fri, 22 Jun 2018 09:01:02 -0700
Date:   Fri, 22 Jun 2018 09:01:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-48e315618dc4dc8904182cd221e3d395d5d97005@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, geert@linux-m68k.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: geert@linux-m68k.org, robh+dt@kernel.org, mark.rutland@arm.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <20180622100820.29616-1-geert@linux-m68k.org>
References: <20180622100820.29616-1-geert@linux-m68k.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] MAINTAINERS: Add file patterns for x86 device tree
 bindings
Git-Commit-ID: 48e315618dc4dc8904182cd221e3d395d5d97005
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

Commit-ID:  48e315618dc4dc8904182cd221e3d395d5d97005
Gitweb:     https://git.kernel.org/tip/48e315618dc4dc8904182cd221e3d395d5d97005
Author:     Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate: Fri, 22 Jun 2018 12:08:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 17:58:32 +0200

MAINTAINERS: Add file patterns for x86 device tree bindings

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Link: https://lkml.kernel.org/r/20180622100820.29616-1-geert@linux-m68k.org

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c125f705f78..60929873b900 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15366,6 +15366,7 @@ M:	x86@kernel.org
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 S:	Maintained
+F:	Documentation/devicetree/bindings/x86/
 F:	Documentation/x86/
 F:	arch/x86/
 
