Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9AECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B720838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657B720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mok.nu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJURkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:40:03 -0400
Received: from proxy05.fsdata.se ([89.221.252.250]:10553 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727308AbeJURkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:40:03 -0400
Received: from localhost (213.112.98.19) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Sun, 21 Oct 2018 11:26:17
 +0200
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <2pi@mok.nu>
Subject: [PATCH] USB: misc: appledisplay: add 20" Apple Cinema Display
Date:   Sun, 21 Oct 2018 11:25:37 +0200
Message-ID: <20181021092537.8592-1-2pi@mok.nu>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [213.112.98.19]
X-ClientProxiedBy: PROXY02.HMC.local (192.168.46.52) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another Apple Cinema Display to the list of supported displays

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/usb/misc/appledisplay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index bd539f3058bc..85b48c6ddc7e 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -50,6 +50,7 @@ static const struct usb_device_id appledisplay_table[] = {
 	{ APPLEDISPLAY_DEVICE(0x9219) },
 	{ APPLEDISPLAY_DEVICE(0x921c) },
 	{ APPLEDISPLAY_DEVICE(0x921d) },
+	{ APPLEDISPLAY_DEVICE(0x9222) },
 	{ APPLEDISPLAY_DEVICE(0x9236) },
 
 	/* Terminating entry */
-- 
2.19.1

