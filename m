Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2541206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JCe4Tn9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfAND3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:29:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43474 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfAND3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jgmD70YCWYdTwUkF/DJ8i5CEN1q2++mFEoyRjUrzX1w=; b=JCe4Tn9GgEjMdG9tELbBAr7EQn
        tpqxaR8Eq6xIkn93X2kkTjPoo1jqwg9jfwZWbHMU8dsACkN6Hejn9FS3qvNuAAI4ahYE98yeclhFe
        oEaEX4y7y4HanZJc9F/rohc/a79KxIFXrFcEYvtqbp+oxs5pfBy6119S8eBnriUTnLGyUwBpKC2pr
        RS5v7mrwxOTuvHPEZOiQTyhPF23IwLK7z1g9nwFn38rm7rrgeg0tE5Qyf4U7nGKgzMRGTcNqJrRmw
        bOk0RBNkXuDKH9YCwninjV7knhN9ErJHdKpJRzMRlbutmw76B9tCivIPw/mLWjKByU4VdVIhe/NU9
        GpE9cnEg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gisvs-0000jq-8w; Mon, 14 Jan 2019 03:29:00 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix coding-style.rst Sphinx warning
Message-ID: <bfeeb533-3909-30aa-a117-0b4179e8cfc3@infradead.org>
Date:   Sun, 13 Jan 2019 19:28:58 -0800
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

Fix Sphinx warning in coding-style.rst:

Documentation/process/coding-style.rst:446: WARNING: Inline interpreted text or phrase reference start-string without end-string.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/process/coding-style.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-50-rc2.orig/Documentation/process/coding-style.rst
+++ lnx-50-rc2/Documentation/process/coding-style.rst
@@ -443,7 +443,7 @@ In function prototypes, include paramete
 Although this is not required by the C language, it is preferred in Linux
 because it is a simple way to add valuable information for the reader.
 
-Do not use the `extern' keyword with function prototypes as this makes
+Do not use the ``extern`` keyword with function prototypes as this makes
 lines longer and isn't strictly necessary.
 
 


