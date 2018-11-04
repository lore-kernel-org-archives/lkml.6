Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC446C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5C2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1ayBe5bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D5C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbeKEH0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:26:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeKEH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hZBCe82pYheJ07uv/7+lk4B5U/edwL7ptg6f06dTYJo=; b=1ayBe5bp11gNqTorhoBTymakzi
        moKbPIzVuGo/lRgO/j/OC568dY+SdG9387DSBp1dhfsuoSEtEnddFV8K8kUohyTTxAKJquZxeucMp
        /7uiTLG92XK7LXYhHwE0bDG/8KoUPUG3vVx1NbrJuTm1KBz75Eyxw6E/Hst5OW8KZQEBPPcDa6Kix
        1kRy9jPtM925f9eoxncvMIsN9ntu+chAiLquagOWXYeONW/1+oFer7Zid9/16LT0v/ogqH3ol5tn8
        d6n1I4jJ5T4h96d0zs46u3Q2mtKpu9EQMoNWeWAE0u2U2EqoujODItT+6MEpZ42oLdwYXIHZCMV6Q
        fhlXCCCA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJQb1-0007kn-EV; Sun, 04 Nov 2018 22:10:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Korteland <will@korte.land>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2 resend] Documentation/admin-guide: fix grammar in
 dynamic-debug-howto.rst
Message-ID: <24f41b66-a45e-92c9-e34f-2e24ee157bd2@infradead.org>
Date:   Sun, 4 Nov 2018 14:10:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix grammar about wildcards and insert a space between sentences.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Will Korteland <will@korte.land>
---
v2: s/A another/Another/ # from Will

 Documentation/admin-guide/dynamic-debug-howto.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20181101.orig/Documentation/admin-guide/dynamic-debug-howto.rst
+++ linux-next-20181101/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -110,8 +110,8 @@ If your query set is big, you can batch
 
   ~# cat query-batch-file > <debugfs>/dynamic_debug/control
 
-A another way is to use wildcard. The match rule support ``*`` (matches
-zero or more characters) and ``?`` (matches exactly one character).For
+Another way is to use wildcards. The match rule supports ``*`` (matches
+zero or more characters) and ``?`` (matches exactly one character). For
 example, you can match all usb drivers::
 
   ~# echo "file drivers/usb/* +p" > <debugfs>/dynamic_debug/control


