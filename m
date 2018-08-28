Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54512087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54512087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeH1Mcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:32:36 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44232 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbeH1Mcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:32:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S8YQnu004055;
        Tue, 28 Aug 2018 03:41:59 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2m34h1ug75-1;
        Tue, 28 Aug 2018 03:41:59 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 20522611C8B3;
        Tue, 28 Aug 2018 03:44:00 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 28 Aug 2018
 09:41:58 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7S8fwnD022336;        Tue, 28 Aug 2018 09:41:58 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] mfd: madera: Remove unused forward reference
Date:   Tue, 28 Aug 2018 09:41:58 +0100
Message-ID: <20180828084158.20554-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=508 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808280089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The madera_irqchip_pdata struct was replaced by the irq_flags
member of struct madera_pdata so the forward reference is
obsolete.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/mfd/madera/pdata.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 0b311f39c8f4..8dc852402dbb 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -24,7 +24,6 @@
 
 struct gpio_desc;
 struct pinctrl_map;
-struct madera_irqchip_pdata;
 struct madera_codec_pdata;
 
 /**
-- 
2.11.0

