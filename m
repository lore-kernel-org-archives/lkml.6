Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D90C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfAHQKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:10:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58872 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbfAHQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:10:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 698A726125E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org
Subject: [PATCH 04/10] platform/chrome: cros_ec_vbc: remove unused includes
Date:   Tue,  8 Jan 2019 17:10:10 +0100
Message-Id: <20190108161016.12361-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108161016.12361-1-enric.balletbo@collabora.com>
References: <20190108161016.12361-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these are required at the moment.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_vbc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index af9bfe6f385c..86903bc31b27 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -18,10 +18,8 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/cros_ec.h>
-#include <linux/mfd/cros_ec_commands.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
-- 
2.20.1

