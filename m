Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9A6C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF325218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfAZInl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:43:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfAZInl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:43:41 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D4126899966E82C7C32;
        Sat, 26 Jan 2019 16:43:39 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sat, 26 Jan 2019 16:43:33 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net 0/3] net: hns: code optimizations & bugfixes for HNS driver
Date:   Sat, 26 Jan 2019 17:18:24 +0800
Message-ID: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for the HNS
ethernet controller driver

Yonglong Liu (3):
  net: hns: Fix for missing of_node_put() after of_parse_phandle()
  net: hns: Restart autoneg need return failed when autoneg off
  net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

 drivers/net/ethernet/hisilicon/hns/hns_enet.c    |  5 +++++
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 16 +++++++++-------
 drivers/net/ethernet/hisilicon/hns_mdio.c        |  2 +-
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
1.9.1

