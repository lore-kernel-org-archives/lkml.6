Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5598FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE22172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DE22172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeHCI7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:59:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728140AbeHCI7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:59:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 799804EB4EA3B;
        Fri,  3 Aug 2018 15:04:57 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 15:04:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <woojung.huh@microchip.com>, <davem@davemloft.net>,
        <UNGLinuxDriver@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Use ARRAY_SIZE to replace computing the size
Date:   Fri, 3 Aug 2018 14:53:13 +0800
Message-ID: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
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
  net:usb: Use ARRAY_SIZE instead of calculating the array size
  include/net/bond_3ad: Simplify the code by using the ARRAY_SIZE

 drivers/net/usb/lan78xx.c | 2 +-
 include/net/bond_3ad.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.12.4

