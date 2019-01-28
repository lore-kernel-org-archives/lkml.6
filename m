Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E71C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9443120880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Sa+wbDX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfA1IpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:45:05 -0500
Received: from mout01.posteo.de ([185.67.36.65]:35024 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfA1IpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:45:03 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E83A0160072
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548665100; bh=9/01gG+xUer1ERxxGCbKaaEG1f3J5yEjZ+cHbq3OEKM=;
        h=From:To:Cc:Subject:Date:From;
        b=Sa+wbDX6fKg8uEw9/GyV/dtND2chGzMoM3+/bUCdqkLjgadyX1DSDemomftwwZwIl
         9rgVf1+IWfgbgve1yV9Ou6goZeIaYaf6pDghiVY3WsPZmYcJpQDdkP20QXvLPDtSz9
         GRKS2O02dly/KG8S3u1hDTGaXKSMy99nj4HO6DY0arYQQRTZRfwCV+PaefGiuiUBma
         sD5qYz3VsckhLPYkNZfckIkyRXi+Qm+dErq3JvudJkdM1NXWV85u7RY0nPn0P69b9B
         TCaPqG+dRXLLdkDvZVPDHQ7bsehgC0ux1JgnVu0g3TiM8ZZJOt7N27KyaDvBC/bBvt
         sK9YSon2AZCAg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43p3970nV8z6tm8;
        Mon, 28 Jan 2019 09:44:59 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 3/3] Input: st1232 - add Martin as module author
Date:   Mon, 28 Jan 2019 09:44:49 +0100
Message-Id: <20190128084449.16070-3-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128084449.16070-1-martink@posteo.de>
References: <20190128084449.16070-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds myself as an author of the st1232 driver module as Tony's
email address doesn't seem to work anymore.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/input/touchscreen/st1232.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 19a665d48dad..906b233970aa 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -346,5 +346,6 @@ static struct i2c_driver st1232_ts_driver = {
 module_i2c_driver(st1232_ts_driver);
 
 MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
+MODULE_AUTHOR("Martin Kepplinger <martin.kepplinger@ginzinger.com>");
 MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

