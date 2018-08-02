Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E4620894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E4620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeHBEpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:45:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbeHBEpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:45:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8352254F7F797;
        Thu,  2 Aug 2018 10:56:41 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 10:56:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <andy.shevchenko@gmail.com>, <john.garry@huawei.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] remove double test condition  
Date:   Thu, 2 Aug 2018 10:44:59 +0800
Message-ID: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


zhong jiang (2):
  scsi:qla1280: remove unnessary same condition check
  scsi:qlogicfas408: remove the same check in qlogicfas408_detect

 drivers/scsi/qla1280.c      | 1 -
 drivers/scsi/qlogicfas408.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
1.7.12.4

