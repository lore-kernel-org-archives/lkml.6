Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC7BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C572B20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C572B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeIHPYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:24:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbeIHPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:24:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63BAC35294F1E;
        Sat,  8 Sep 2018 18:38:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 18:38:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        <jwi@linux.ibm.com>, <ubraun@linux.ibm.com>, <jdelvare@suse.de>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] s390: Use ARRAY_SIZE instead of reimplementing its function
Date:   Sat, 8 Sep 2018 18:26:26 +0800
Message-ID: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find the issue with the help of Coccinelle.

zhong jiang (2):
  s390: vmlogrdr: Use ARRAY_SIZE instead of reimplementing its function
  s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its
    function

 drivers/s390/char/vmlogrdr.c     | 2 +-
 drivers/s390/net/qeth_core_mpc.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
1.7.12.4

