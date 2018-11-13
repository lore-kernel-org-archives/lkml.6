Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9934C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6F32250F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RdUbeg9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6F32250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbeKNAGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:06:05 -0500
Received: from m12-14.163.com ([220.181.12.14]:39694 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbeKNAGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=nin0/MKkwWYGvpSi/G
        /UzV0Y6Gp12G4L1F0kaUy1ovo=; b=RdUbeg9JywWmPsMBdMUFswF1m4A5r2hNjt
        o3WKr2/aB2L0enBunPzmjUuqzSmq054dK43XRydIqM48bZ+gJ3W2FlIcSo9imo3F
        yav//aWIC7P6SJ3lxG6x0RNCfv6L+pGoWLsSe84wiOvStLxA6WSq5d2vVvKd80KV
        hbpcPW+28=
Received: from dkj-ubuntu (unknown [60.177.201.44])
        by smtp10 (Coremail) with SMTP id DsCowADXx7OT2upb62E8Yg--.46077S3;
        Tue, 13 Nov 2018 22:07:17 +0800 (CST)
From:   Kevin Dou <dkj0101@163.com>
Cc:     dkj0101@163.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Bhaskar Singh <bhaskar.kernel@gmail.com>,
        =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: core: coding style check
Date:   Tue, 13 Nov 2018 22:06:13 +0800
Message-Id: <1542117978-22317-1-git-send-email-dkj0101@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DsCowADXx7OT2upb62E8Yg--.46077S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4Utw4DCFWDur13Jw43ZFb_yoW8Wr4fpr
        Wrt343GFWrKrsxurWUJr17CryfWF9YyFyDKw17A3yFkFy8JFyrWryjyF1jyFs5urs7CFWf
        CFZxK34UXa1UWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b0DGOUUUUU=
X-Originating-IP: [60.177.201.44]
X-CM-SenderInfo: xgnmiiiqr6il2tof0z/1tbiPhX9XVXltzbgjAAAsW
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow the linux coding style, rename the variable
shortGIrate to short_gi_rate.

Signed-off-by: Kevin Dou <dkj0101@163.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 1c319c2..c3ea65b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -334,7 +334,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 {
 	int i;
 	u32 init_rate = 0;
-	unsigned char sta_band = 0, raid, shortGIrate = false;
+	unsigned char sta_band = 0, raid, short_gi_rate = false;
 	unsigned int tx_ra_bitmap = 0;
 	struct ht_priv	*psta_ht = NULL;
 
@@ -358,7 +358,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 				tx_ra_bitmap |= BIT(i + 12);
 
 		/* max short GI rate */
-		shortGIrate = psta_ht->sgi;
+		short_gi_rate = psta_ht->sgi;
 	}
 
 	if (tx_ra_bitmap & 0xffff000)
@@ -381,7 +381,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		arg |= BIT(7);/* support entry 2~31 */
 
-		if (shortGIrate)
+		if (short_gi_rate)
 			arg |= BIT(5);
 
 		tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
@@ -395,7 +395,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		/* arg[5] = Short GI */
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
 
-		if (shortGIrate)
+		if (short_gi_rate)
 			init_rate |= BIT(6);
 
 		/* set ra_id, init_rate */
-- 
1.9.1


