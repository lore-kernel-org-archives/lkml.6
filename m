Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A6C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4024F2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBKt5igI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4024F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeKEH0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:26:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeKEH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1SihliAwdirFfRF/j/ix7QXeaCLnL+ysrKdP8lov+GI=; b=YBKt5igIKfmY1MgD/1WQPidUBV
        PK4+XMxdb4y7++VBH8qn99DXnNnBkZBIpGxlWTyhc/QzvQmUxS399gL25JArE9Qq6NH8irdE1hyzx
        dUdC+/nrk4hw4+cdyzXPM3S9YddyXz0NWI1X3D2xqnDyiXsW2n+M10SjER6FjaS9ALXDq/4P4qI+S
        5vYC/UmZ/lTqu8ejEByn+IpdZLsF6j3by2cuuebCRNqM7CRUHAosCqEG6YimV1tK68DmSSSReFZVE
        heBeV7qKY+4g+CQ2gOtidozKcPaWsKknCBCe1X6Pg9A2+e4rbT+NLmZZ31d9aIi0hDrcYobqmMLcG
        LIfY95TA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJQaq-0007kQ-6M; Sun, 04 Nov 2018 22:10:04 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2 resend] Documentation/admin-guide: fix typos in
 dynamic-debug-howto.rst
Message-ID: <ae933bbb-b812-9853-1d55-974b0aaa15c6@infradead.org>
Date:   Sun, 4 Nov 2018 14:10:02 -0800
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

Fix a few "typos" in dynamic-debug-howto.rst.

s/dyndbg_query/ddebug_query/
s/sysfs/debugfs/

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/dynamic-debug-howto.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20181101.orig/Documentation/admin-guide/dynamic-debug-howto.rst
+++ linux-next-20181101/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -258,7 +258,7 @@ this boot parameter for debugging purpos
 
 If ``foo`` module is not built-in, ``foo.dyndbg`` will still be processed at
 boot time, without effect, but will be reprocessed when module is
-loaded later. ``dyndbg_query=`` and bare ``dyndbg=`` are only processed at
+loaded later. ``ddebug_query=`` and bare ``dyndbg=`` are only processed at
 boot.
 
 
@@ -301,7 +301,7 @@ The ``dyndbg`` option is a "fake" module
 
 For ``CONFIG_DYNAMIC_DEBUG`` kernels, any settings given at boot-time (or
 enabled by ``-DDEBUG`` flag during compilation) can be disabled later via
-the sysfs interface if the debug messages are no longer needed::
+the debugfs interface if the debug messages are no longer needed::
 
    echo "module module_name -p" > <debugfs>/dynamic_debug/control
 


