Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeEQHaA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:30:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55095 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeEQH37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:29:59 -0400
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To: <dledford@redhat.com>, <jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xavier.huwei@tom.com>, <lijun_nudt@163.com>
Subject: [PATCH rdma-next 0/5] Misc update for hns driver
Date: Thu, 17 May 2018 16:02:48 +0800
Message-ID: <1526544173-106587-1-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset included fixing bug, some optimization, reset
process and implementation of the disassociate_ucontext API
for hns driver.

Wei Hu (Xavier) (5):
  RDMA/hns: Implement the disassociate_ucontext API
  RDMA/hns: Modify uar allocation algorithm to avoid bitmap exhaust
  RDMA/hns: Increase checking CMQ status timeout value
  RDMA/hns: Add reset process for RoCE in hip08
  RDMA/hns: Fix the illegal memory operation when cross page

 drivers/infiniband/hw/hns/hns_roce_cmd.c    |   3 +
 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 130 +++++++++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  43 +++++++++
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  10 ++-
 6 files changed, 167 insertions(+), 25 deletions(-)

-- 
1.9.1
