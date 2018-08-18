Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD49C04AB9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873C92191D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873C92191D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeHRJsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 05:48:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeHRJsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 05:48:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C3F4658AC26B;
        Sat, 18 Aug 2018 14:41:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 14:41:24 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <vz@mleia.com>, <slemieux.tyco@gmail.com>, <keescook@chromium.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ethernet: Use NULL to compare with pointer-typed value rather than 0
Date:   Sat, 18 Aug 2018 14:29:31 +0800
Message-ID: <1534573773-17358-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
 - According to Vladimir's suggestion. change a common 0 and NULL comparsion form.

zhong jiang (2):
  ethernet: declance:  Use NULL to compare with pointer-typed value
    rather than 0
  ethernet: lpc_eth: Use NULL to compare with pointer-typed value
    rather than 0

 drivers/net/ethernet/amd/declance.c | 3 +--
 drivers/net/ethernet/nxp/lpc_eth.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
1.7.12.4

