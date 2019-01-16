Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BDC20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547681390;
	bh=zy3WaBdZq9oLZcxdTsuHT70HN9ugNDrlqzH7OapOrc4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PkcxFV41/JWJPlhBGOLtoMUR75kNtf0AsE/dOkBpVJIHh1Kn/UrxIZ4J2g3JgUTXZ
	 4WaFpbBQnVVgBBu1UyhCieOloRUAzW8rkzRgze1CPsagylZislMqRjdqlhLlt7wqjc
	 Y1bJ9Cn3mMPQwTEoBzbvXbC8Y5vj6nfnw63Sy7aM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfAPX2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfAPX2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:28:22 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53DE206C2;
        Wed, 16 Jan 2019 23:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547681302;
        bh=zy3WaBdZq9oLZcxdTsuHT70HN9ugNDrlqzH7OapOrc4=;
        h=From:To:Cc:Subject:Date:From;
        b=EUZIQhPdKr5aUy8NcziRGBEyUpq+R8QvCoaNWz5uPJ2Q0EcmpgYdBeOQaeoUGIXR3
         Nizlkd3ZNLAIHz2r7RcMzmT76cNickGx7eMkuJH2KHXpIVBWkUR6HMHWUbn3k2nftV
         ObH99BS0KP72k15puCMaaf0NlFjTwJmt8IvGbKnw=
From:   shuah@kernel.org
To:     mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: email address update in MAINTAINERS entries
Date:   Wed, 16 Jan 2019 16:28:20 -0700
Message-Id: <20190116232820.26180-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

Update email address in MAINTAINERS entries.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..6ca780f24808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3979,6 +3979,7 @@ F:	drivers/cpufreq/arm_big_little.c
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
 M:	Shuah Khan <shuah@kernel.org>
+M:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	tools/power/cpupower/
@@ -8259,6 +8260,7 @@ F:	include/uapi/linux/sunrpc/
 
 KERNEL SELFTEST FRAMEWORK
 M:	Shuah Khan <shuah@kernel.org>
+M:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-kselftest@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
@@ -15842,6 +15844,7 @@ F:	drivers/usb/common/usb-otg-fsm.c
 USB OVER IP DRIVER
 M:	Valentina Manea <valentina.manea.m@gmail.com>
 M:	Shuah Khan <shuah@kernel.org>
+M:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/usb/usbip_protocol.txt
-- 
2.17.1

