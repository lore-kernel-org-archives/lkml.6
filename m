Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A149C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE9420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kv5Y114m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE9420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeJLScs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:32:48 -0400
Received: from mout02.posteo.de ([185.67.36.66]:37571 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbeJLScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:32:48 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C3B542400FB
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 13:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1539342053; bh=QPmKc018LrXnJvVRl/ik0SNoS+kSIcwEkgAzZrg4J5I=;
        h=From:To:Cc:Subject:Date:From;
        b=kv5Y114mOmLEsIWPCifRTjsddM+jq0He+7I1zgao31OKOPc8yTngAaY+aHMglz8O/
         7InBs67NwvMmhBWgqj8mNgyQwWX7CBwgrXb1gnl6Lct/BCTRJx1oSr6KlolKj0JDJ3
         1e+9yeLaTZtmmA5epnqh+9Ov+Ax/0L0Stcj6McUSzjqRMMP1q5WZrIURavLZ8S98+R
         laWz4t+dBk+YqcoK3mjNP23OvYvORsHyKF8snEtkLFGJjBuQYXJuuS9Vl4yIsb6Y25
         L1PMsupkFVwx5j8D/jklUz3jdITSh2y0zxun7bjfxacl5lAa1nYe/Bdd3xUl2fUmuB
         UxZ5hFHQWofWw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42WlHn0b3sz9rxV;
        Fri, 12 Oct 2018 13:00:52 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     martin.elshuber@theobroma-systems.com,
        jakob.unterwurzacher@theobroma-systems.com
Cc:     philipp.tomsich@theobroma-systems.com, mkl@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] can: ucan: fix some typos in comments
Date:   Fri, 12 Oct 2018 13:00:24 +0200
Message-Id: <20181012110024.17067-1-martink@posteo.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some double-word and trivial typos in the ucan driver comments.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
hi guys,

The Seal looks very nice. Since I'm doing CAN work right now, I could totally
use one of these instead of old gear from PEAK.

I hope you're doing fine. Best regards,

                                martin


 drivers/net/can/usb/ucan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38b1af4..8c680fb9fdc8 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -64,7 +64,7 @@
  *    the following way:
  *
  *	m[n].len <=> the length if message n(including the header in bytes)
- *	m[n] is is aligned to a 4 byte boundary, hence
+ *	m[n] is aligned to a 4 byte boundary, hence
  *	  offset(m[0])	 := 0;
  *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
  *
@@ -288,7 +288,7 @@ struct ucan_priv {
 	 */
 	spinlock_t echo_skb_lock;
 
-	/* usb device information information */
+	/* usb device information */
 	u8 intf_index;
 	u8 in_ep_addr;
 	u8 out_ep_addr;
@@ -1449,7 +1449,7 @@ static int ucan_probe(struct usb_interface *intf,
 
 	/* request the device information and store it in ctl_msg_buffer
 	 *
-	 * note: ucan_ctrl_command_* wrappers connot be used yet
+	 * note: ucan_ctrl_command_* wrappers cannot be used yet
 	 * because `up` is initialised in Stage 3
 	 */
 	ret = usb_control_msg(udev,
@@ -1498,7 +1498,7 @@ static int ucan_probe(struct usb_interface *intf,
 
 	up = netdev_priv(netdev);
 
-	/* initialze data */
+	/* initialize data */
 	up->udev = udev;
 	up->intf = intf;
 	up->netdev = netdev;
-- 
2.19.0

