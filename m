Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B329C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EFB23E3F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="XlEB50qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EFB23E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeFVHcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:32:24 -0400
Received: from mout01.posteo.de ([185.67.36.65]:41076 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeFVHcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:32:23 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8AC5121189
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529652741; bh=OGvwPwG3CpRIoeJ1iio9VYFWBUiiwHnGN4xbqxNof1U=;
        h=From:To:Cc:Subject:Date:From;
        b=XlEB50qHgtIGBPkrGAv7YfkAIxzwz5XgfqM2lI9731xn60YXcqDho6Skr4iqjSWwF
         AnYmwH++UGPy881h14qgx8OZ8anwkuWPi62154w91r7FNGsh8kptVN4EAAxSft3yOr
         SuZiDzEgKzazVlbuZ7wBIovs6c/5oKJm/sasAf/05nG2errjPoGuadd1HRm2PFneHt
         ihCUu0PousK5TFQAo7ioUPOb2scaFhdI2/rbbFQV2LkSXkHmhyFLjC+jGM+oBdLCwS
         TO0FlZLmbDvBH4bLgGzI9bWrsIQajOnaAuocWTG5afPLv6+/XztHwJknAekI7l7Lwf
         k576tuifM1zkQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41Bqyr5MpMz9rxN;
        Fri, 22 Jun 2018 09:32:20 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Documentation: nommu-map: Fix duplicate word typo
Date:   Fri, 22 Jun 2018 09:32:11 +0200
Message-Id: <20180622073211.8220-1-martink@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 Documentation/nommu-mmap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nommu-mmap.txt b/Documentation/nommu-mmap.txt
index 69556f0d494b..530fed08de2c 100644
--- a/Documentation/nommu-mmap.txt
+++ b/Documentation/nommu-mmap.txt
@@ -47,7 +47,7 @@ and it's also much more restricted in the latter case:
            appropriate mapping protection capabilities. Ramfs, romfs, cramfs
            and mtd might all permit this.
 
-	 - If the backing device device can't or won't permit direct sharing,
+	 - If the backing device can't or won't permit direct sharing,
            but does have the NOMMU_MAP_COPY capability, then a copy of the
            appropriate bit of the file will be read into a contiguous bit of
            memory and any extraneous space beyond the EOF will be cleared
-- 
2.17.1

