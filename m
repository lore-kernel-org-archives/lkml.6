Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 762A6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35736208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35736208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbeFNP0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:26:06 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60893 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755264AbeFNP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:26:04 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 10A5D58C5BD;
        Thu, 14 Jun 2018 17:20:54 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Thu, 14 Jun 2018 17:20:54 +0200
From:   Henriette Hofmeier <passt@h-hofmeier.de>
To:     devel@linuxdriverproject.org
Cc:     zbr@ioremap.net, arvind.yadav.cs@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Florian Harbecke <florian.harbecke@fau.de>
Subject: [PATCH 2/3] ds2490.c: Remove unnecessary whitespace
Date:   Thu, 14 Jun 2018 17:20:40 +0200
Message-Id: <1528989641-20284-3-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
References: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary whitespace criticized by
checkpatch.

Signed-off-by: Henriette Hofmeier <passt@h-hofmeier.de>
Signed-off-by: Florian Harbecke <florian.harbecke@fau.de>
---
 drivers/w1/masters/ds2490.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 917a5f1..1e4b243 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -613,7 +613,7 @@ static int ds_read_byte(struct ds_device *dev, u8 *byte)
 	int err;
 	struct ds_status st;
 
-	err = ds_send_control(dev, COMM_BYTE_IO | COMM_IM , 0xff);
+	err = ds_send_control(dev, COMM_BYTE_IO | COMM_IM, 0xff);
 	if (err)
 		return err;
 
-- 
2.7.4

