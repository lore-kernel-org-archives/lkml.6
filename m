Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 76793C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3653A208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3653A208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936140AbeFMPVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:21:11 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37384 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935348AbeFMPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:21:03 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 11:21:03 EDT
Received: from faui49man1 (faui49man1.informatik.uni-erlangen.de [131.188.42.189])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 9CB0F58C506;
        Wed, 13 Jun 2018 17:14:23 +0200 (CEST)
Received: by faui49man1 (sSMTP sendmail emulation); Wed, 13 Jun 2018 17:14:23 +0200
From:   Jakob Albert <jakob.j.albert@fau.de>
To:     devel@linuxdriverproject.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenz Kaestle <lorenz.kaestle@fau.de>,
        linux-kernel@i4.cs.fau.de, Jakob Albert <jakob.j.albert@fau.de>
Subject: [PATCH v2 2/3] hwmon: (nct7904) Fix CODE_INDENT error
Date:   Wed, 13 Jun 2018 17:13:24 +0200
Message-Id: <1528902805-21474-3-git-send-email-jakob.j.albert@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
References: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CODE_INDENT error reported by checkpatch.pl

Signed-off-by: Lorenz Kaestle <lorenz.kaestle@fau.de>
Signed-off-by: Jakob Albert <jakob.j.albert@fau.de>
---
v1->v2:	Changed patch subject and description

 drivers/hwmon/nct7904.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 7de2421..657ce88 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -431,15 +431,15 @@ static const struct hwmon_channel_info nct7904_in = {
 };
 
 static const u32 nct7904_fan_config[] = {
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-            HWMON_F_INPUT,
-	    0
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	HWMON_F_INPUT,
+	0
 };
 
 static const struct hwmon_channel_info nct7904_fan = {
@@ -448,11 +448,11 @@ static const struct hwmon_channel_info nct7904_fan = {
 };
 
 static const u32 nct7904_pwm_config[] = {
-            HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-            HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-            HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-            HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-	    0
+	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+	HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+	0
 };
 
 static const struct hwmon_channel_info nct7904_pwm = {
@@ -461,16 +461,16 @@ static const struct hwmon_channel_info nct7904_pwm = {
 };
 
 static const u32 nct7904_temp_config[] = {
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-            HWMON_T_INPUT,
-	    0
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	HWMON_T_INPUT,
+	0
 };
 
 static const struct hwmon_channel_info nct7904_temp = {
-- 
2.7.4

