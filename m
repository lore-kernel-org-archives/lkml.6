Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF08C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C0125704
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0125704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031210AbeGARko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:40:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031086AbeGAQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:35:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90FFCAA6;
        Sun,  1 Jul 2018 16:35:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandr Savca <alexandr.savca@saltedge.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 136/157] Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID
Date:   Sun,  1 Jul 2018 18:23:28 +0200
Message-Id: <20180701160859.816224407@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandr Savca <alexandr.savca@saltedge.com>

commit 8938fc7b8fe9ccfa11751ead502a8d385b607967 upstream.

Add ELAN0618 to the list of supported touchpads; this ID is used in
Lenovo v330 15IKB devices.

Signed-off-by: Alexandr Savca <alexandr.savca@saltedge.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1261,6 +1261,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0618", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };


