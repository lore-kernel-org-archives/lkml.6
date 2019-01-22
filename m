Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B904AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A5621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfAVMp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:45:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728215AbfAVMp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:45:27 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7ED44EA45A60584CDFF9;
        Tue, 22 Jan 2019 20:45:25 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 22 Jan 2019
 20:45:19 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <hamish.martin@alliedtelesis.co.nz>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] fix possible memory leak and use-after-free in __uio_register_device
Date:   Wed, 23 Jan 2019 06:45:36 +0800
Message-ID: <1548197138-352285-1-git-send-email-liujian56@huawei.com>
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

v1->v2:
fix email From:line

Liu Jian (2):
  driver: uio: fix possible memory leak in __uio_register_device
  driver: uio: fix possible use-after-free in __uio_register_device

 drivers/uio/uio.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.7.4

