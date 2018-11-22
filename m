Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A859BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AF5206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="de5MoJw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AF5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbeKVLI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbeKVLI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:08:28 -0500
Received: from garbanzo.lan (c-73-71-40-85.hsd1.ca.comcast.net [73.71.40.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93AB7206BA;
        Thu, 22 Nov 2018 00:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542846702;
        bh=8o0zhMnp4gwTk41mQ+U0HSf0By+tddbYu0Uz2RHQZqM=;
        h=From:To:Cc:Subject:Date:From;
        b=de5MoJw7RYGuxfzb9JF0TIzhDNA+YleT2RsOFbs22+vMOlqZ508go42wjNWJPHK7Z
         ArBwsN1GAUJPk33PaEYHy/qto9seqT2CLSrSkof66D+EG3q1KoayIMDlKkXklTgRcX
         EUUt6bIY26x9cZ1PDRDOw0xMeLxMedG7VmMYqvG4=
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     akpm@linux-foundation.org
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: update name change for myself
Date:   Wed, 21 Nov 2018 16:31:38 -0800
Message-Id: <20181122003138.7752-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

My name has changed, works better than Global Entry I tell ya.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Andrew, figured this could go best through your tree. Please let me
know if you have a preference for it routed elsewhere.

PGP key updated as well, kept the same key. Happy Turkey Massacre Eve day.

 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84c3f51b6a71..8d52af40fa13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2490,7 +2490,7 @@ F:	drivers/net/wireless/ath/*
 ATHEROS ATH5K WIRELESS DRIVER
 M:	Jiri Slaby <jirislaby@gmail.com>
 M:	Nick Kossifidis <mickflemm@gmail.com>
-M:	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
+M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
 W:	http://wireless.kernel.org/en/users/Drivers/ath5k
 S:	Maintained
@@ -5784,7 +5784,7 @@ F:	include/uapi/linux/firewire*.h
 F:	tools/firewire/
 
 FIRMWARE LOADER (request_firmware)
-M:	Luis R. Rodriguez <mcgrof@kernel.org>
+M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/firmware_class/
@@ -8099,7 +8099,7 @@ F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
 KERNEL USERMODE HELPER
-M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
+M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	kernel/umh.c
@@ -8275,7 +8275,7 @@ F:	mm/kmemleak.c
 F:	mm/kmemleak-test.c
 
 KMOD KERNEL MODULE LOADER - USERMODE HELPER
-M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
+M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	kernel/kmod.c
@@ -12033,7 +12033,7 @@ F:	kernel/printk/
 F:	include/linux/printk.h
 
 PRISM54 WIRELESS DRIVER
-M:	"Luis R. Rodriguez" <mcgrof@gmail.com>
+M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
 W:	http://wireless.kernel.org/en/users/Drivers/p54
 S:	Obsolete
@@ -12049,7 +12049,7 @@ F:	include/linux/proc_fs.h
 F:	tools/testing/selftests/proc/
 
 PROC SYSCTL
-M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
+M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
-- 
2.18.0

