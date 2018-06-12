Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E12D0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11F3208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11F3208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbeFLFUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:20:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:51969 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeFLFUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:20:04 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C5JDa4008698;
        Tue, 12 Jun 2018 00:19:20 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 2/5] fsi/scom: Whitespace fixes
Date:   Tue, 12 Jun 2018 15:19:08 +1000
Message-Id: <20180612051911.20690-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612051911.20690-1-benh@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-scom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 3cba0eb645e1..8a608db0aa07 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -49,7 +49,7 @@ static struct list_head scom_devices;
 static DEFINE_IDA(scom_ida);
 
 static int put_scom(struct scom_device *scom_dev, uint64_t value,
-			uint32_t addr)
+		    uint32_t addr)
 {
 	int rc;
 	uint32_t data;
@@ -77,7 +77,7 @@ static int put_scom(struct scom_device *scom_dev, uint64_t value,
 }
 
 static int get_scom(struct scom_device *scom_dev, uint64_t *value,
-			uint32_t addr)
+		    uint32_t addr)
 {
 	uint32_t result, data;
 	int rc;
@@ -110,7 +110,7 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
 }
 
 static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
-			loff_t *offset)
+			 loff_t *offset)
 {
 	int rc;
 	struct miscdevice *mdev =
@@ -136,7 +136,7 @@ static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
 }
 
 static ssize_t scom_write(struct file *filep, const char __user *buf,
-			size_t len, loff_t *offset)
+			  size_t len, loff_t *offset)
 {
 	int rc;
 	struct miscdevice *mdev = filep->private_data;
-- 
2.17.0

