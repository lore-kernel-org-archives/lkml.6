Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1633C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CEE21738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CEE21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeHMOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:18:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728427AbeHMOS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:18:28 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CF462EE511C0;
        Mon, 13 Aug 2018 19:36:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Mon, 13 Aug 2018 19:36:33 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <alcooperx@gmail.com>, <kishon@ti.com>, <robh@kernel.org>,
        <hauke@hauke-m.de>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] phy: Use PTR_ERR_OR_ZERO to replace the open code 
Date:   Mon, 13 Aug 2018 19:24:44 +0800
Message-ID: <1534159486-25008-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is detected with the help of Coccinelle.

zhong jiang (2):
  phy:phy-brcm-us: Use PTR_ERR_OR_ZERO to replace the open code
  phy:phy-lantiq-rcu-usb2: Use PTR_ERR_OR_ZERO to replace the open code

 drivers/phy/broadcom/phy-brcm-usb.c      | 4 +---
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
1.7.12.4

