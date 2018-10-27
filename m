Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60113C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6320856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeJ0VGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:06:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:32810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbeJ0VGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:06:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B81CAB4C;
        Sat, 27 Oct 2018 12:25:49 +0000 (UTC)
Date:   Sat, 27 Oct 2018 14:25:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] HID: moving to group maintainership model
In-Reply-To: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>
Date: Sat, 27 Oct 2018 14:16:13 +0200
Subject: [PATCH] HID: moving to group maintainership model

Benjamin and myself will from now on be sharing maintainership
responsibilities for hid.git.

Update maintainers to reflect that change, and also move a git
repository to shared space at kernel.org.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Stephen, could you please update the hid.git URL for linux-next as below? 
Thanks.

v1->v2: Update all occurences in MAINTAINERS

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0c4c5003998..4715cb8d9584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6588,9 +6588,9 @@ F:	arch/*/include/asm/suspend*.h
 
 HID CORE LAYER
 M:	Jiri Kosina <jikos@kernel.org>
-R:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
+M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-input@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 S:	Maintained
 F:	drivers/hid/
 F:	include/linux/hid*
@@ -15254,9 +15254,9 @@ F:	include/linux/usb/gadget*
 
 USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
 M:	Jiri Kosina <jikos@kernel.org>
-R:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
+M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-usb@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 S:	Maintained
 F:	Documentation/hid/hiddev.txt
 F:	drivers/hid/usbhid/


-- 
Jiri Kosina
SUSE Labs

