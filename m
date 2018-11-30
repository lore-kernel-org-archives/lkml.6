Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1856AC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE88F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE88F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeLAGiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:38:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:60860 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbeLAGiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:38:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 11:27:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="279426298"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 11:27:51 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH RFC 14/15] lib: replace **** with a hug
Date:   Fri, 30 Nov 2018 11:27:23 -0800
Message-Id: <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to comply with the CoC, replace **** with a hug.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 37a54a6dd594..b7a92f5d47bb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -6,7 +6,7 @@
 
 /* vsprintf.c -- Lars Wirzenius & Linus Torvalds. */
 /*
- * Wirzenius wrote this portably, Torvalds fucked it up :-)
+ * Wirzenius wrote this portably, Torvalds hugged it up :-)
  */
 
 /*
-- 
2.19.1

