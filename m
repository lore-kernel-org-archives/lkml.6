Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDD52070C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NAbLcshw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfBKGa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:30:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBKGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YSty9LSkdCwUjCD0Q0UDaGYhiSyiUos1dC/o9gA7iwY=; b=NAbLcshw8Lxqo4D2q54MOQ5oaa
        g4x4D6N8PbO75mYgFCd6q+hho4tqnJpj1Ex4Orj+r17Oma3RU2IxDJ9V5lR7GvWITvp8yoVBk8VWw
        wY+S2cOo6LcpgMkZh3WMslQb1ik5oUa1P2xh3i6DQOUrupDJLXtZpF2gJjF04nl2skxi3zBuGjjDd
        Ham/MV/xtOk+nWTzqiY55cT/pGxN4aCnpP1I3vGfifcbO9Rf9cHFh94E4cGoWCpWuxBUuAcJuVwjA
        DdgooMwT12LdmfGU217heQ8/eaa0yARVZn+S08Yzev6eAQwEQ1dga8fISSQQSGfXtPM8xNnG7KFXh
        +BBAq56Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt57D-00049h-19; Mon, 11 Feb 2019 06:30:51 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matan Ziv-Av <matan@svgalib.org>,
        platform-driver-x86@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix lg-laptop.rst warnings
Message-ID: <16ce109c-69a3-1f27-7fd4-9b99c9780565@infradead.org>
Date:   Sun, 10 Feb 2019 22:30:49 -0800
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

Fix markup warnings by inserting blank lines.
Also correct one typo.

Documentation/laptops/lg-laptop.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
Documentation/laptops/lg-laptop.rst:16: WARNING: Unexpected indentation.
Documentation/laptops/lg-laptop.rst:17: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matan Ziv-Av <matan@svgalib.org>
Cc: platform-driver-x86@vger.kernel.org
---
 Documentation/laptops/lg-laptop.rst |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- lnx-50-rc6.orig/Documentation/laptops/lg-laptop.rst
+++ lnx-50-rc6/Documentation/laptops/lg-laptop.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0+
+
 LG Gram laptop extra features
 =============================
 
@@ -9,6 +10,7 @@ Hotkeys
 -------
 
 The following FN keys are ignored by the kernel without this driver:
+
 - FN-F1 (LG control panel)   - Generates F15
 - FN-F5 (Touchpad toggle)    - Generates F13
 - FN-F6 (Airplane mode)      - Generates RFKILL
@@ -16,7 +18,7 @@ The following FN keys are ignored by the
   This key also changes keyboard backlight mode.
 - FN-F9 (Reader mode)        - Generates F14
 
-The rest of the FN key work without a need for a special driver.
+The rest of the FN keys work without a need for a special driver.
 
 
 Reader mode


