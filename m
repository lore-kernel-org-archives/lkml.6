Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212AECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C087E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUPndW+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbeGXDQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:16:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbeGXDQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aAhmhiQFXH1lIKkb6w22MbrmcqmfN4agiBwjZRBer4E=; b=MUPndW+JHpCuvzTFnIjYwt1Q32
        crToBhIBqp6wIU84vYT8lETonrfCAdUdLDGfcbK/vATm3PDSWSvY8ZCTtGljSv9L8oSlUSzAPsmxZ
        A40mx3T4HkFqtr7iS0zaj+AiJUCtMZuFrIFIm4yYGc7c7n4oZt9+VqGV9RQycwFh9Ina+z98S0Nc4
        9WkM4NtsjIdw4wIHMH/XGNFRIgfJ47Tvms3wGljfXJtvQMoV67ZFxRsKI5vVAThKoZSJkbsSPsCKS
        iNYVBNKQ7VtDyhJCJ07l5kJisLdNPLUtYNOU7+jJXxJvmZIg3PYKs0NGaacREJpIwHp4RemIolBOb
        3r/L8VWQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhmnu-0003sz-4k; Tue, 24 Jul 2018 02:11:58 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] init/Kconfig: fix its typos
Message-ID: <0ac627b6-5527-55f4-0489-1631aa34fc11@infradead.org>
Date:   Mon, 23 Jul 2018 19:11:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Correct typos of "it's" to "its.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 init/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20180723.orig/init/Kconfig
+++ linux-next-20180723/init/Kconfig
@@ -428,7 +428,7 @@ config BSD_PROCESS_ACCT_V3
 	help
 	  If you say Y here, the process accounting information is written
 	  in a new file format that also logs the process IDs of each
-	  process and it's parent. Note that this file format is incompatible
+	  process and its parent. Note that this file format is incompatible
 	  with previous v0/v1/v2 file formats, so you will need updated tools
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.gnu.org/software/acct/>.
@@ -1684,7 +1684,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	default n
 	help
 	  Normally, and according to the Linux spec, anonymous memory obtained
-	  from mmap() has it's contents cleared before it is passed to
+	  from mmap() has its contents cleared before it is passed to
 	  userspace.  Enabling this config option allows you to request that
 	  mmap() skip that if it is given an MAP_UNINITIALIZED flag, thus
 	  providing a huge performance boost.  If this option is not enabled,


