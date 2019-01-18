Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994D2C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB2B20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfARSMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:12:16 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52430 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728667AbfARSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:12:15 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 18 Jan 2019 20:12:12 +0200
Received: from bu-lab53.mtbu.labs.mlnx (bu-lab53.mtbu.labs.mlnx [10.15.8.107])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x0IICBN1030177;
        Fri, 18 Jan 2019 20:12:12 +0200
Received: from bu-lab53.mtbu.labs.mlnx (localhost [127.0.0.1])
        by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7) with ESMTP id x0IICB4w049610;
        Fri, 18 Jan 2019 13:12:11 -0500
Received: (from lsun@localhost)
        by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7/Submit) id x0IIC8KR049607;
        Fri, 18 Jan 2019 13:12:08 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Woods <dwoods@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v1 1/1] mmc: dw_mmc-bluefield: : Fix the license information
Date:   Fri, 18 Jan 2019 13:12:06 -0500
Message-Id: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX license identifier and the boiler plate text are
contradicting. Only the SPDX license identifier is needed. The
other one is removed.

Fixes: 86958dcc5ad7 ("mmc: dw_mmc-bluefield: Add driver extension")
Cc: stable@vger.kernel.org
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index ed8f225..aa38b1a 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2018 Mellanox Technologies.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/bitfield.h>
-- 
1.8.3.1

