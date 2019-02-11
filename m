Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2501C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F988214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xeoJryqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBKG1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:27:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKG1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0G35kGmGdrAw2ythI7SC/L5uFccSfEkId1/WdLKFQNE=; b=xeoJryqbY9FlbIDIBG9fx9r15c
        veXXoN3Z3ED4TlzVmm+4/vMWk+ofs0lFJqIA3M7UNhKaFlYxw7YEXaHEeZFSm9yAdQJCS1xaOh8PB
        NeR7Ang3RueB+k0QPKq/coh+JWtS8KiVDQzh9MwU+FstYI6rNv3Pm/kBA+pRxRBoiU0lTYv3x/iqg
        kdgtlFRuFZGgRWIwkSRBosoi1NtVWkSccNxmqAsFuRochMf7ObPq6RV+HvArBrmB47i9KsN4adgUF
        PNv54PzckDh2Vfb+WUAj8Qp61fxGuCuxtGKrXSGelhTKx5OKE1A1hBRZAkX1V9Ud6gmseqfi2QgBm
        AlyFWM9A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt53R-00046F-Qw; Mon, 11 Feb 2019 06:26:58 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: driver-api: fix dmatest.rst warning
Message-ID: <da8b9103-5203-13da-65c5-232233ab0bfb@infradead.org>
Date:   Sun, 10 Feb 2019 22:26:53 -0800
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

Fix markup warning: insert a blank line before the hint.

Documentation/driver-api/dmaengine/dmatest.rst:63: WARNING: Unexpected indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 Documentation/driver-api/dmaengine/dmatest.rst |    1 +
 1 file changed, 1 insertion(+)

--- lnx-50-rc6.orig/Documentation/driver-api/dmaengine/dmatest.rst
+++ lnx-50-rc6/Documentation/driver-api/dmaengine/dmatest.rst
@@ -59,6 +59,7 @@ parameter, that specific channel is requ
 is created with the existing parameters. This thread is set as pending
 and will be executed once run is set to 1. Any parameters set after the thread
 is created are not applied.
+
 .. hint::
   available channel list could be extracted by running the following command::
 


