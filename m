Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F772C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89821A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BL6EdVRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A89821A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbeHGBgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:36:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbeHGBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ixLSEUUtgzNI2qa50DSPg7M0zmkJltFp/B7667wu8q4=; b=BL6EdVRKRc9lO4xkAUHGwpsSA
        rz9wMnVzjZfSgUWMPkof+5Sl8Qp13LBqWGXtin0XoUStJI4e63xU1RxnjpvVQDAY0YungGj2k55bF
        Kxjk4gcpPxM7TLRdF+CnhZVsaCs5Rwe3koH76EYode5RSA9lp9JbQo22dYPDQj6XGvIuu9j1jrnGe
        ZKY+s9RL5paflMvbRIVfDn5xMFFIqOcXU9t7nBb+wqhhc8Abyd9K2ZV/oU8rVjK9KtvEKTVnAoJP1
        /OvdlE5LsAkDRNaUPnfttZLEx5Kt9Qh4FxOYcXKzGERBGDJd0ngdTp6UaVKHd4gIZPKDS3fkm3xFL
        flCOzNiwg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmorw-0006ux-I3; Mon, 06 Aug 2018 23:24:56 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Antonino A. Daplas" <adaplas@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: corrections to console/console.txt
Message-ID: <933b90be-5fff-d0c7-a7a1-4e4362713846@infradead.org>
Date:   Mon, 6 Aug 2018 16:24:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos, line length, grammar, punctuation, and capitalization
in console.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Antonino A. Daplas <adaplas@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/console/console.txt |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- lnx-418-rc8.orig/Documentation/console/console.txt
+++ lnx-418-rc8/Documentation/console/console.txt
@@ -1,7 +1,7 @@
 Console Drivers
 ===============
 
-The linux kernel has 2 general types of console drivers.  The first type is
+The Linux kernel has 2 general types of console drivers.  The first type is
 assigned by the kernel to all the virtual consoles during the boot process.
 This type will be called 'system driver', and only one system driver is allowed
 to exist. The system driver is persistent and it can never be unloaded, though
@@ -17,10 +17,11 @@ of driver occupying the consoles.) They
 occupied by the system driver. In the same token, if the modular driver is
 released by the console, the system driver will take over.
 
-Modular drivers, from the programmer's point of view, has to call:
+Modular drivers, from the programmer's point of view, have to call:
 
 	 do_take_over_console() - load and bind driver to console layer
-	 give_up_console() - unload driver, it will only work if driver is fully unbond
+	 give_up_console() - unload driver; it will only work if driver
+			     is fully unbound
 
 In newer kernels, the following are also available:
 
@@ -56,7 +57,7 @@ What do these files signify?
 	cat /sys/class/vtconsole/vtcon0/name
 	(S) VGA+
 
-	    '(S)' stands for a (S)ystem driver, ie, it cannot be directly
+	    '(S)' stands for a (S)ystem driver, i.e., it cannot be directly
 	    commanded to bind or unbind
 
 	    'VGA+' is the name of the driver
@@ -89,7 +90,7 @@ driver, make changes, recompile, reload
 for rebooting the kernel. For regular users who may want to switch from
 framebuffer console to VGA console and vice versa, this feature also makes
 this possible. (NOTE NOTE NOTE: Please read fbcon.txt under Documentation/fb
-for more details).
+for more details.)
 
 Notes for developers:
 =====================
@@ -110,8 +111,8 @@ In order for binding to and unbinding fr
 console drivers must follow these guidelines:
 
 1. All drivers, except system drivers, must call either do_register_con_driver()
-   or do_take_over_console(). do_register_con_driver() will just add the driver to
-   the console's internal list. It won't take over the
+   or do_take_over_console(). do_register_con_driver() will just add the driver
+   to the console's internal list. It won't take over the
    console. do_take_over_console(), as it name implies, will also take over (or
    bind to) the console.
 


