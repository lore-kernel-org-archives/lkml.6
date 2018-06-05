Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFELnF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:43:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbeFELnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:43:04 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/3] Bug fixes & optimization for HNS3 Driver
Date: Tue, 5 Jun 2018 12:41:58 +0100
Message-ID: <20180605114201.29900-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents 2 priority bug fixes and an optimization for
HNS3 driver.

Xi Wang (3):
  net: hns3: Fix for VF mailbox cannot receiving PF response
  net: hns3: Fix for VF mailbox receiving unknown message
  net: hns3: Optimize PF CMDQ interrupt switching process

 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 13 ++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  3 +++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   | 23 +++++++++++++++++++---
 3 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.7.4
