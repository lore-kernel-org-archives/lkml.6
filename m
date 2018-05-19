Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeESPyp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:54:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752370AbeESPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:39 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/9] Misc. bug fixes and cleanup for HNS3 driver
Date: Sat, 19 May 2018 16:53:14 +0100
Message-ID: <20180519155323.68960-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents miscellaneous bug fixes and cleanups found during
internal review, system testing and cleanup.

Fuyun Liang (1):
  net: hns3: Fix for netdev not running problem after calling net_stop
    and net_open

Huazhong Tan (1):
  net: hns3: Use enums instead of magic number in
    hclge_is_special_opcode

Jian Shen (1):
  net: hns3: cleanup of return values in hclge_init_client_instance()

Peng Li (1):
  net: hns3: Fixes API to fetch ethernet header length with kernel
    default

Salil Mehta (1):
  net: hns3: Fixes error reported by Kbuild and internal review

Xi Wang (3):
  net: hns3: Fix the missing client list node initialization
  net: hns3: Fix for hns3 module is loaded multiple times problem
  net: hns3: Fixes kernel panic issue during rmmod hns3 driver

Yunsheng Lin (1):
  net: hns3: Fix for CMDQ and Misc. interrupt init order problem

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 111 ++-------------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  10 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  17 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  16 +--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   2 +-
 9 files changed, 39 insertions(+), 124 deletions(-)

-- 
2.7.4
