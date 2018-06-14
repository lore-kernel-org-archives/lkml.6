Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC068C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF42208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF42208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964950AbeFNPbF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:31:05 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60927 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964923AbeFNPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:31:03 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id E972958C5BE;
        Thu, 14 Jun 2018 17:20:58 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Thu, 14 Jun 2018 17:20:58 +0200
From:   Henriette Hofmeier <passt@h-hofmeier.de>
To:     devel@linuxdriverproject.org
Cc:     zbr@ioremap.net, arvind.yadav.cs@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Florian Harbecke <florian.harbecke@fau.de>
Subject: [PATCH 3/3] ds2490.c: Move struct open braces to previous line
Date:   Thu, 14 Jun 2018 17:20:41 +0200
Message-Id: <1528989641-20284-4-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
References: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move open braces of two structs to the declaration line,
as criticized by checkpatch.

Signed-off-by: Henriette Hofmeier <passt@h-hofmeier.de>
Signed-off-by: Florian Harbecke <florian.harbecke@fau.de>
---
 drivers/w1/masters/ds2490.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 1e4b243..0f4ecfc 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -134,8 +134,7 @@
 #define EP_DATA_OUT			2
 #define EP_DATA_IN			3
 
-struct ds_device
-{
+struct ds_device {
 	struct list_head	ds_entry;
 
 	struct usb_device	*udev;
@@ -158,8 +157,7 @@ struct ds_device
 	struct w1_bus_master	master;
 };
 
-struct ds_status
-{
+struct ds_status {
 	u8			enable;
 	u8			speed;
 	u8			pullup_dur;
-- 
2.7.4

