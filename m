Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC247C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93452086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u5PLU9XN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBUECl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:02:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBUECk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vsPzHYPJ3SLvu6G+KNCT25YWSC8o4+43mJGgoS6NFW8=; b=u5PLU9XNyuHLYcOEmbUvmF3OuX
        LYCT1KRjxQpTo2+AVJi67XqU/DR1+R2Hh6h+in3pPXX18ypQDGb9kbnu9GgUih+3DKKc1ddMEuRUn
        iw8uJ+cqVOazIV+uh9HLoz/GzEqw7RXunY4ZtGNChKopOtZoX/fh0ppyPCRl99bWyRYzUq7zuRNdK
        /FZxtZlUajnFi6+g/UFd5UvQMnngDCIlC9BGFXwKcJgGQXXdn8iZ88DkJu+S6K5cRx/mwl2fpoypU
        YZ7ff0RrXZHRF7iMwWz+Cgux8QS+ZfgTD+xANeEiKkWVKueZjUBnw5k9gSKPHF92gfhUciS81elTL
        /WfskGhA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwfZD-0005Pk-H3; Thu, 21 Feb 2019 04:02:36 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix admin-guide/README.rst minimum gcc version
 requirement
Message-ID: <ecb653af-79e5-6233-a7f6-edbb61715d3b@infradead.org>
Date:   Wed, 20 Feb 2019 20:02:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix minimum gcc version as specified in Documentation/process/changes.rst.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/README.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-50-rc7.orig/Documentation/admin-guide/README.rst
+++ lnx-50-rc7/Documentation/admin-guide/README.rst
@@ -251,7 +251,7 @@ Configuring the kernel
 Compiling the kernel
 --------------------
 
- - Make sure you have at least gcc 3.2 available.
+ - Make sure you have at least gcc 4.6 available.
    For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
 
    Please note that you can still run a.out user programs with this kernel.


