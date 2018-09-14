Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D0FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C9120861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C9120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINQjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:39:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57033 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeINQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:39:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g0mDT-000051-KR; Fri, 14 Sep 2018 11:24:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: fix spelling mistake "entires" -> "entries"
Date:   Fri, 14 Sep 2018 12:24:51 +0100
Message-Id: <20180914112451.4127-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/greybus/tools/README.loopback | 2 +-
 drivers/staging/greybus/tools/loopback_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/tools/README.loopback b/drivers/staging/greybus/tools/README.loopback
index 845b08dc4696..070a510cbe7c 100644
--- a/drivers/staging/greybus/tools/README.loopback
+++ b/drivers/staging/greybus/tools/README.loopback
@@ -79,7 +79,7 @@ Here is the summary of the available options:
    -t     must be one of the test names - sink, transfer or ping
    -i     iteration count - the number of iterations to run the test over
  Optional arguments
-   -S     sysfs location - location for greybus 'endo' entires default /sys/bus/greybus/devices/
+   -S     sysfs location - location for greybus 'endo' entries default /sys/bus/greybus/devices/
    -D     debugfs location - location for loopback debugfs entries default /sys/kernel/debug/gb_loopback/
    -s     size of data packet to send during test - defaults to zero
    -m     mask - a bit mask of connections to include example: -m 8 = 4th connection -m 9 = 1st and 4th connection etc
diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index b82e2befe935..2fa88092514d 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -192,7 +192,7 @@ void usage(void)
 	"   -t     must be one of the test names - sink, transfer or ping\n"
 	"   -i     iteration count - the number of iterations to run the test over\n"
 	" Optional arguments\n"
-	"   -S     sysfs location - location for greybus 'endo' entires default /sys/bus/greybus/devices/\n"
+	"   -S     sysfs location - location for greybus 'endo' entries default /sys/bus/greybus/devices/\n"
 	"   -D     debugfs location - location for loopback debugfs entries default /sys/kernel/debug/gb_loopback/\n"
 	"   -s     size of data packet to send during test - defaults to zero\n"
 	"   -m     mask - a bit mask of connections to include example: -m 8 = 4th connection -m 9 = 1st and 4th connection etc\n"
-- 
2.17.1

