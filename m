Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD3A20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD3A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeIQUaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:30:52 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:58631 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729021AbeIQUav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:30:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EEF28181D330D;
        Mon, 17 Sep 2018 15:03:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch05_54f3e992bea2c
X-Filterd-Recvd-Size: 1603
Received: from joe-laptop.perches.com (mb42736d0.tmodns.net [208.54.39.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 15:03:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mpt3sas: Remove unused macro MPT3SAS_FMT
Date:   Mon, 17 Sep 2018 08:01:14 -0700
Message-Id: <b2223bcc61daab4132ece3867cb93ee0426707dd.1537183088.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1537183087.git.joe@perches.com>
References: <cover.1537183087.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the uses have been removed, delete the macro.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 941a4faf20be..8f1d6b071b39 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -158,8 +158,6 @@ struct mpt3sas_nvme_cmd {
 /*
  * logging format
  */
-#define MPT3SAS_FMT			"%s: "
-
 #define ioc_err(ioc, fmt, ...)						\
 	pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
 #define ioc_notice(ioc, fmt, ...)					\
-- 
2.15.0

