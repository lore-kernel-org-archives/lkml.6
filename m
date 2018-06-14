Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 32EFAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9D208B2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A9D208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755480AbeFNQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:09:24 -0400
Received: from osg.samsung.com ([64.30.133.232]:57216 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755238AbeFNQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:09:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 1519120EE0;
        Thu, 14 Jun 2018 09:09:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eh7bdJdZOnPF; Thu, 14 Jun 2018 09:09:17 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id 6EDBA20E9C;
        Thu, 14 Jun 2018 09:09:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTUoE-0005Sf-2v; Thu, 14 Jun 2018 13:09:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v3 09/27] media: max2175: fix location of driver's companion documentation
Date:   Thu, 14 Jun 2018 13:08:54 -0300
Message-Id: <033ba35d6f1dd7fdc184b9bce62b74a6acf807ed.1528990947.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing ".rst" at the doc's file name.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/i2c/max2175.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/max2175.c b/drivers/media/i2c/max2175.c
index 87cba15b2977..008a082cb8ad 100644
--- a/drivers/media/i2c/max2175.c
+++ b/drivers/media/i2c/max2175.c
@@ -1202,7 +1202,7 @@ static const struct v4l2_ctrl_ops max2175_ctrl_ops = {
 
 /*
  * I2S output enable/disable configuration. This is a private control.
- * Refer to Documentation/media/v4l-drivers/max2175 for more details.
+ * Refer to Documentation/media/v4l-drivers/max2175.rst for more details.
  */
 static const struct v4l2_ctrl_config max2175_i2s_en = {
 	.ops = &max2175_ctrl_ops,
@@ -1218,7 +1218,7 @@ static const struct v4l2_ctrl_config max2175_i2s_en = {
 
 /*
  * HSLS value control LO freq adjacent location configuration.
- * Refer to Documentation/media/v4l-drivers/max2175 for more details.
+ * Refer to Documentation/media/v4l-drivers/max2175.rst for more details.
  */
 static const struct v4l2_ctrl_config max2175_hsls = {
 	.ops = &max2175_ctrl_ops,
@@ -1234,7 +1234,7 @@ static const struct v4l2_ctrl_config max2175_hsls = {
 /*
  * Rx modes below are a set of preset configurations that decides the tuner's
  * sck and sample rate of transmission. They are separate for EU & NA regions.
- * Refer to Documentation/media/v4l-drivers/max2175 for more details.
+ * Refer to Documentation/media/v4l-drivers/max2175.rst for more details.
  */
 static const char * const max2175_ctrl_eu_rx_modes[] = {
 	[MAX2175_EU_FM_1_2]	= "EU FM 1.2",
-- 
2.17.1

