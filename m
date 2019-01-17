Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41963C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBCD20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="ivNp4y8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfAQWON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:14:13 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:5284 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfAQWOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:14:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id B4F7240707;
        Thu, 17 Jan 2019 23:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1547763250; x=1549577651;
         bh=S4NDN9i2L/wSBoJ9OEolUiSI0HsBV5TUrBfMmhLAAjs=; b=ivNp4y8RxOvC
        Gd8tmERkNcaqq1AKRX/1+nkP6KUS2HaDWGtXg0FqAmKH493Yn8txFqhpWVsVBlNH
        jpbeGCieNhy6QBabvT0Gzc2DOo5gZRrDqqP0XOQupMJe391uf1+wU2adl2sBmm+V
        7ilKdv7XXzS/yTfnFkt9LYG08bCny3w/la+Vlv7mymHYGuukMVpD8zi0rEz/qxcd
        Oja0meSlL1Jr9Qm/oLD68G0m9btxFrPqJ9p0puAEWpqr5AQbvpw2f5QouSgB12tz
        7BIdUWVvVECKX2uosVqNhEa1qt80wJJV3QKtzsBhB2uqkUvgn0qwtpxVT2rT/hVL
        iEGvAKr0NIDGe+EmgF9ZHJbgcmPnK4uLbxqEkGJLCes4fEYf/2DrKVFyagYCPTza
        a/5fd9/GWvbbh/k1lH+joxwaKu1vEB0rBessCvmv7CZTLQjZNdgsXgwYWi80pvIz
        1bBjBgxXHHS6SnfBaXQA83U50k6eA+uSUQ5veHM0lvs+E7B9ot4kIGAQBSw1GwXl
        kl3mrra8Upes6CZeT8nWfekXjlTCTGHV7G2e5yoSx5rRT2XlwBG6p+8PzR5M+aRa
        mLRkcSPpeWnr3N1/O0oAZs4oXgZui9QZV89iX1FhGWKU+2yZFJv6Blz8pwQU7mGq
        P0EOFn5A/YXCZHAFgVQ13SkC/AHNn/U=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l8zhjLf-pD8i; Thu, 17 Jan 2019 23:14:10 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 23C24406C0;
        Thu, 17 Jan 2019 23:14:10 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id DC0CD32F;
        Thu, 17 Jan 2019 23:14:09 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: doc: stable-api-nonsense missing link
Date:   Thu, 17 Jan 2019 23:14:08 +0100
Message-ID: <3122599.2K0FN2NGh9@harkonnen>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in this document

Documentation/process/stable-api-nonsense.rst

there is this note:

<insert link to leech comment from Andrew and Linus here>

Is it possible to get it fixed with the proper link? I searched for it without 
success. If that comment is impossible to find I will send a patch to remove 
that note, but first I wanted to ask you if you know where to get it.



