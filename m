Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376D921570
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cletLXnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376D921570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeGDT57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:57:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGDT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FlW0cTJoWQzj7KK6ndp+LhUi0sE7wcP1RxDkAEsfP7M=; b=cletLXnuIs7bKtTLCEJYEUr+k
        JW4uDfhathzo+c8g3JKbwT9/LpFRce5rE1Ywsu0vpfqVwy9EmMr6FUDeT0TJdUc/2WA1vZ/Fr8H+x
        2xhdzx3Na6tEnUqC4Pxy1d+S1xoIcczpAUieqhGuoWx5gYY6NMDW4+MLbOCMhXS+6DrdOdAtfBPH1
        qT3DAQdETwb1WF7jxNFDmNbC9i+qeDwYDEWDNE0s2tKXnijoDv56oars4mejAJeeDDswfrsAMM8+L
        B37k8rrF3qRzAzKb1NqVajh8QFj0cJpwP5yXedzPtOy/P4cDCwqKyKEqWFFTiqg0WSgPgUB+v8K1n
        spyrAMHpw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fanuW-0008RR-Sz; Wed, 04 Jul 2018 19:57:57 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: update kbuild.txt ARCH alias list
Message-ID: <9a4b8d07-b9cc-4843-a74c-7f40ebc4c9af@infradead.org>
Date:   Wed, 4 Jul 2018 12:57:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

In Kbuild documentation, add alias for 64-bit sh ARCH ("sh64")
to the list of ARCH aliases.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/kbuild/kbuild.txt |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180704.orig/Documentation/kbuild/kbuild.txt
+++ linux-next-20180704/Documentation/kbuild/kbuild.txt
@@ -88,6 +88,7 @@ In most cases the name of the architectu
 directory name found in the arch/ directory.
 But some architectures such as x86 and sparc have aliases.
 x86: i386 for 32 bit, x86_64 for 64 bit
+sh: sh for 32 bit, sh64 for 64 bit
 sparc: sparc for 32 bit, sparc64 for 64 bit
 
 CROSS_COMPILE


