Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D0FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20FB20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20FB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeKIXSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:18:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56208 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeKIXSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:18:45 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gL6z0-0002oH-5Z; Fri, 09 Nov 2018 13:37:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Gross <mark.gross@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ranganathan Desikan <ravi@jetztechnologies.com>,
        "Arvind R ." <arvino55@gmail.com>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: clean an indentation issues, replace spaces for tabs
Date:   Fri,  9 Nov 2018 13:37:57 +0000
Message-Id: <20181109133757.21471-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up an indentation issues, replacing 7 space chars
for a tab and also inserting a missing indentation

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/edac/e752x_edac.c   | 4 ++--
 drivers/edac/i3000_edac.c   | 4 ++--
 drivers/edac/i5000_edac.c   | 4 ++--
 drivers/edac/i7core_edac.c  | 2 +-
 drivers/edac/i82975x_edac.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index b5de9a13ea3f..de732dc2ef33 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1446,8 +1446,8 @@ static int __init e752x_init(void)
 
 	edac_dbg(3, "\n");
 
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
+	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
+	opstate_init();
 
 	pci_rc = pci_register_driver(&e752x_driver);
 	return (pci_rc < 0) ? pci_rc : 0;
diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index 8085a32ec3bd..f564a4a8a4ae 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -508,8 +508,8 @@ static int __init i3000_init(void)
 
 	edac_dbg(3, "MC:\n");
 
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
+	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
+	opstate_init();
 
 	pci_rc = pci_register_driver(&i3000_driver);
 	if (pci_rc < 0)
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 53f24b18cd61..98bef13e3134 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1559,8 +1559,8 @@ static int __init i5000_init(void)
 
 	edac_dbg(2, "MC:\n");
 
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
+	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
+	opstate_init();
 
 	pci_rc = pci_register_driver(&i5000_driver);
 
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 9ef448fef12f..40297550313a 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -724,7 +724,7 @@ static ssize_t i7core_inject_type_store(struct device *dev,
 					const char *data, size_t count)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-struct i7core_pvt *pvt = mci->pvt_info;
+	struct i7core_pvt *pvt = mci->pvt_info;
 	unsigned long value;
 	int rc;
 
diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index d514e7a8fa4d..ce1d6abfc6af 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -648,8 +648,8 @@ static int __init i82975x_init(void)
 
 	edac_dbg(3, "\n");
 
-       /* Ensure that the OPSTATE is set correctly for POLL or NMI */
-       opstate_init();
+	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
+	opstate_init();
 
 	pci_rc = pci_register_driver(&i82975x_driver);
 	if (pci_rc < 0)
-- 
2.19.1

