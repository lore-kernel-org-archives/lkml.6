Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9101820BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9101820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeGQAhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:37:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729849AbeGQAhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08EEF40201A3;
        Tue, 17 Jul 2018 00:08:08 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9AE17C47;
        Tue, 17 Jul 2018 00:08:04 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix bogus indenting in nouveau_hwmon.c
Date:   Mon, 16 Jul 2018 20:07:58 -0400
Message-Id: <20180717000758.8770-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 17 Jul 2018 00:08:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 17 Jul 2018 00:08:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index 44178b4c3599..d556f24c6c48 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -655,7 +655,7 @@ nouveau_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 
 static int
 nouveau_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
-							int channel, long *val)
+	     int channel, long *val)
 {
 	switch (type) {
 	case hwmon_chip:
@@ -677,7 +677,7 @@ nouveau_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 
 static int
 nouveau_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
-							int channel, long val)
+	      int channel, long val)
 {
 	switch (type) {
 	case hwmon_temp:
-- 
2.17.1

