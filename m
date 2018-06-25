Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87825856
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C87825856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932786AbeFYLwd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:52:33 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:43071 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932276AbeFYLwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:52:32 -0400
Received: from [2001:b68:ff:12::131] (port=57776 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fXQ2j-00020z-TI; Mon, 25 Jun 2018 13:52:26 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id A11C420E53; Mon, 25 Jun 2018 13:52:25 +0200 (CEST)
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Marcus Wolf <linux@Wolf-Entwicklungen.de>,
        =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Michael Panzlaff <michael.panzlaff@fau.de>,
        Derek Robson <robsonde@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hugo Lefeuvre <hle@owl.eu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>,
        Valentin Vidic <Valentin.Vidic@CARNet.hr>
Date:   Mon, 25 Jun 2018 13:52:23 +0200
Message-Id: <20180625115223.9652-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.18.0.rc2
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH] staging: pi433: add SPDX-License-Identifier tag
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GPL-2.0+ based on the license text in each of the files.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c       | 1 +
 drivers/staging/pi433/pi433_if.h       | 3 ++-
 drivers/staging/pi433/rf69.c           | 1 +
 drivers/staging/pi433/rf69.h           | 3 ++-
 drivers/staging/pi433/rf69_enum.h      | 3 ++-
 drivers/staging/pi433/rf69_registers.h | 3 ++-
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b061f77dda41..e2b8a518dafe 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * userspace interface for pi433 radio module
  *
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index b6e214c29ddf..0e0c1b0ab1a6 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -1,4 +1,5 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * include/linux/TODO
  *
  * userspace interface for pi433 radio module
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 90280e9b006d..e4a1e64c868a 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * abstraction of the spi interface of HopeRf rf69 radio module
  *
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index c131ffbdc2db..2cec9a9c34d2 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -1,4 +1,5 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * hardware abstraction/register access for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 493bd0025453..de3b7e32dad7 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -1,4 +1,5 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * enumerations for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
index 33fd91518bb0..ea19c1ca7509 100644
--- a/drivers/staging/pi433/rf69_registers.h
+++ b/drivers/staging/pi433/rf69_registers.h
@@ -1,4 +1,5 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * register description for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
-- 
2.18.0.rc2

