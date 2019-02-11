Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B60C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033FD2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+jKjw7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBKG22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:28:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37334 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBKG22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cp80ysTc6Kp6FbpoBRr4kW7arPgGDamsCeRUf2OiUEs=; b=G+jKjw7ZimdJp/qDvPqZRPnOV8
        QebNQO1yXdZYDtdFWM5dYprX7mAwl/MhJLFd8vUXcO69N/w+nGocWAPs+Jy0z9GFF83RcVhmrabQi
        RVkI7tjLnrDR8B+fMjrnfbQcRQgqJHLoqwcOEy18tUc1Mlk3YN1OxomOXRlFSoepB8MYcycBWgkbv
        szXhvOYywtBBa4p/KnwtkTkzNb1MQ8ngdfRl+3uucSYnLWYZze7IYythuwWv7HPETx9U99OYNLBaj
        NjeEu+rZLiM3I9nfwWnSYb24s8yKUKfj6mSe/ZC8qBCcZYaaGDKtb5fmL231EXyWq0vMS+3YZxgek
        9KVYqwpQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt54s-00047n-03; Mon, 11 Feb 2019 06:28:26 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documenation: driver-api: fix gpio/board.rst warning
Message-ID: <13290065-5568-c0d0-9e7b-7a02ad71dbb0@infradead.org>
Date:   Sun, 10 Feb 2019 22:28:24 -0800
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

Fix markup warning: insert a blank line before the list.

Documentation/driver-api/gpio/board.rst:209: WARNING: Unexpected indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio@vger.kernel.org
---
 Documentation/driver-api/gpio/board.rst |    1 +
 1 file changed, 1 insertion(+)

--- lnx-50-rc6.orig/Documentation/driver-api/gpio/board.rst
+++ lnx-50-rc6/Documentation/driver-api/gpio/board.rst
@@ -204,6 +204,7 @@ between a caller and a respective .get/s
 
 In order to qualify for fast bitmap processing, the array must meet the
 following requirements:
+
 - pin hardware number of array member 0 must also be 0,
 - pin hardware numbers of consecutive array members which belong to the same
   chip as member 0 does must also match their array indexes.


