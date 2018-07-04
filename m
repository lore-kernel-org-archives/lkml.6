Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC55C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422892172C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422892172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skyboo.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbeGDJnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:43:12 -0400
Received: from skyboo.net ([94.40.87.198]:39966 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbeGDJmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:42:09 -0400
X-Greylist: delayed 2406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 05:42:09 EDT
Received: from [::1] (helo=skyboo.net)
        by skyboo.net with esmtpa (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1fadfk-0006B9-Sx; Wed, 04 Jul 2018 11:02:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Jul 2018 11:02:00 +0200
From:   manio <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Message-ID: <fc05c438ba7a22719501467e62baed7c@skyboo.net>
X-Sender: manio@skyboo.net
User-Agent: Roundcube Webmail/1.3-git
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, zbr@ioremap.net, greg@kroah.com
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH] w1: fix w1_ds2438 documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
  Documentation/w1/slaves/w1_ds2438 | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/slaves/w1_ds2438 
b/Documentation/w1/slaves/w1_ds2438
index b99f3674c5b4..e64f65a09387 100644
--- a/Documentation/w1/slaves/w1_ds2438
+++ b/Documentation/w1/slaves/w1_ds2438
@@ -60,4 +60,4 @@ vad: general purpose A/D input (VAD)
  vdd: battery input (VDD)

  After the voltage conversion the value is returned as decimal ASCII.
-Note: The value is in mV, so to get a volts the value has to be divided 
by 10.
+Note: To get a volts the value has to be divided by 100.
--
2.16.2
