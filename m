Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B384AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3A42173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfBZPkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:40:47 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60236 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726507AbfBZPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:40:45 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 26 Feb 2019 17:40:38 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x1QFeaF0031871;
        Tue, 26 Feb 2019 10:40:36 -0500
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x1QFeZR0026457;
        Tue, 26 Feb 2019 10:40:35 -0500
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] hwmon: (emc1403) Add support for EMC1444
Date:   Tue, 26 Feb 2019 10:40:05 -0500
Message-Id: <d15100263e8c5f697fde75dc54cae61f17ac15f3.1551195079.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMC1444 is compatible with EMC1404. Add it to device ID table.

Reviewed-by: David Thompson <dthompson@mellanox.com>
Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
---
 drivers/hwmon/emc1403.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index bdab47a..88f6a40 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -453,6 +453,7 @@ static const struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1422", emc1402 },
 	{ "emc1423", emc1403 },
 	{ "emc1424", emc1404 },
+	{ "emc1444", emc1404 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
-- 
2.1.2

