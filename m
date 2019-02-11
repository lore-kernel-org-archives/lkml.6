Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5443C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74937218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549891238;
	bh=iWE1Vy+0yXnSIpYP/ZsG46U3GrPVxFILE2p2FJEPm0k=;
	h=From:To:Subject:Date:List-ID:From;
	b=eGgIC0oa1BZw+KNgm9XK0UFXNllpRbGlX7nImVLz9ITv6JJ1X8H9aXUvGet8nEB6+
	 PXmFSDJIjtaNNO6t+Gfkky0CkcdXd5pFZJy3y0wadrTzJC6zcF71hzPefuc/kyQqga
	 g8C9ZRA1Tgfaua4dq8YMmvJTiJE99sUBgz7XUvaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfBKNUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbfBKNUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:20:33 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E21218D8;
        Mon, 11 Feb 2019 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549891232;
        bh=iWE1Vy+0yXnSIpYP/ZsG46U3GrPVxFILE2p2FJEPm0k=;
        h=From:To:Subject:Date:From;
        b=SID44oMJ9Y+vu813XsoApujNMIuEjKHzUXPe1088vAo1dDA8UpOdkLNtpkXqpiSjS
         KeSFLNKD9oZzsWLASPg5LxajM6kV4s60KvZTbxO9v80ZbapayOaA1DDODKhtjc/Hh6
         U2d2hO4QaaY2ybiBovsWWAFUfWXIJKNMIlhgbzL4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2] mfd: sec-core: Cleanup formatting to a consistent style
Date:   Mon, 11 Feb 2019 14:20:23 +0100
Message-Id: <1549891223-14269-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the formatting to have consistent style across the file (only
white-space issues).  No expected difference in code.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Leave one-liners as is.
---
 drivers/mfd/sec-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 00321011de0a..521319086c81 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -114,7 +114,8 @@ static const struct mfd_cell s2mpu02_devs[] = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id sec_dt_match[] = {
-	{	.compatible = "samsung,s5m8767-pmic",
+	{
+		.compatible = "samsung,s5m8767-pmic",
 		.data = (void *)S5M8767X,
 	}, {
 		.compatible = "samsung,s2mps11-pmic",
@@ -309,8 +310,8 @@ static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
  * the sub-modules need not instantiate another instance while parsing their
  * platform data.
  */
-static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
-					struct device *dev)
+static struct sec_platform_data *
+sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 {
 	struct sec_platform_data *pd;
 
@@ -331,8 +332,8 @@ static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
 	return pd;
 }
 #else
-static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
-					struct device *dev)
+static struct sec_platform_data *
+sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 {
 	return NULL;
 }
-- 
2.7.4

