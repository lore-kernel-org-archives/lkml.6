Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF80C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC4321019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeL2F73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:59:29 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60371 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeL2F73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:59:29 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1257284|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03276;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.DectfAK_1546063165;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.DectfAK_1546063165)
          by smtp.aliyun-inc.com(10.194.98.226);
          Sat, 29 Dec 2018 13:59:26 +0800
Date:   Sat, 29 Dec 2018 13:59:25 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] power_suuupy: change brace's place
Message-ID: <20181229055925.GA12884@AExdroid03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5204f115970f..be1577e96c59 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -75,7 +75,8 @@ static const char * const power_supply_scope_text[] = {
 
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
-					  char *buf) {
+					  char *buf)
+{
 	ssize_t ret = 0;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	const ptrdiff_t off = attr - power_supply_attrs;
-- 
2.19.1

