Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F4DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C897420835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C897420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sautereau.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeH3XtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:49:00 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54413 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3Xs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:48:59 -0400
X-Originating-IP: 78.194.159.98
Received: from localhost.localdomain (unknown [78.194.159.98])
        (Authenticated sender: thibaut@sautereau.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 53ABDE0005;
        Thu, 30 Aug 2018 19:45:10 +0000 (UTC)
From:   Thibaut Sautereau <thibaut@sautereau.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib: fix three typos in Kconfig help text
Date:   Thu, 30 Aug 2018 21:45:05 +0200
Message-Id: <20180830194505.4778-1-thibaut@sautereau.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix three typos in CONFIG_WARN_ALL_UNSEEDED_RANDOM help text.

Signed-off-by: Thibaut Sautereau <thibaut@sautereau.fr>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c7fef0c56d6b..3e50cc93572c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1277,13 +1277,13 @@ config WARN_ALL_UNSEEDED_RANDOM
 	  time.  This is really bad from a security perspective, and
 	  so architecture maintainers really need to do what they can
 	  to get the CRNG seeded sooner after the system is booted.
-	  However, since users can not do anything actionble to
+	  However, since users cannot do anything actionable to
 	  address this, by default the kernel will issue only a single
 	  warning for the first use of unseeded randomness.
 
 	  Say Y here if you want to receive warnings for all uses of
 	  unseeded randomness.  This will be of use primarily for
-	  those developers interersted in improving the security of
+	  those developers interested in improving the security of
 	  Linux kernels running on their architecture (or
 	  subarchitecture).
 
-- 
2.18.0

