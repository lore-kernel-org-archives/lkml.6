Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB0AC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53272070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfAHDBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:01:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfAHDBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:01:10 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 306CB5FB3949D8DA4E28;
        Tue,  8 Jan 2019 11:01:08 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 8 Jan 2019
 11:01:00 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>, <hamish.martin@alliedtelesis.co.nz>
CC:     <liujian56@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] fix possible memory leak and use-after-free in __uio_register_device
Date:   Tue, 8 Jan 2019 21:01:46 +0800
Message-ID: <1546952508-186003-1-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix possible memory leak and use-after-free in __uio_register_device

liujian (2):
  driver: uio: fix possible memory leak in __uio_register_device
  driver: uio: fix possible use-after-free in __uio_register_device

 drivers/uio/uio.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.7.4

