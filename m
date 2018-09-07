Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29327C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146F2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E146F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeIGVRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:17:04 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:60476 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeIGVRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:17:04 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id BF84BC01F6;
        Fri,  7 Sep 2018 18:35:20 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 7B898C0F69; Fri,  7 Sep 2018 18:35:19 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 2EE8DC0F60;
        Fri,  7 Sep 2018 18:33:56 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/2] media: cedrus: Add TODO file with tasks to complete before unstaging
Date:   Fri,  7 Sep 2018 18:33:47 +0200
Message-Id: <20180907163347.32312-3-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907163347.32312-1-contact@paulk.fr>
References: <20180907163347.32312-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the elements listed are complete, the Cedrus driver will be ready
to move out of the staging area of the kernel.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/staging/media/sunxi/cedrus/TODO | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 drivers/staging/media/sunxi/cedrus/TODO

diff --git a/drivers/staging/media/sunxi/cedrus/TODO b/drivers/staging/media/sunxi/cedrus/TODO
new file mode 100644
index 000000000000..ec277ece47af
--- /dev/null
+++ b/drivers/staging/media/sunxi/cedrus/TODO
@@ -0,0 +1,7 @@
+Before this stateless decoder driver can leave the staging area:
+* The Request API needs to be stabilized;
+* The codec-specific controls need to be thoroughly reviewed to ensure they
+  cover all intended uses cases;
+* Userspace support for the Request API needs to be reviewed;
+* Another stateless decoder driver should be submitted;
+* At least one stateless encoder driver should be submitted.
-- 
2.18.0

