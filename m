Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935765AbeCHLMb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:12:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751971AbeCHLKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:14 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 0/6] fix some bugs for hns3 driver
Date: Thu, 8 Mar 2018 19:41:49 +0800
Message-ID: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix some bugs for hns3 driver.
[Patch 1/6 - Patch 3/6] fix bugs related about VF driver.
[Patch 3/6 - Patch 6/6] fix the bugs about ethtool_ops.set_channels.

Peng Li (6):
  net: hns3: VF should get the real rss_size instead of rss_size_max
  net: hns3: set the cmdq out_vld bit to 0 after used
  net: hns3: fix endian issue when PF get mbx message flag
  net: hns3: fix the queue id for tqp enable&&reset
  net: hns3: set the max ring num when alloc netdev
  net: hns3: add support for VF driver inner interface
    hclgevf_ops.get_tqps_and_rss_info

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 27 ++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 50 +++++++++++-----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 10 +++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 10 +++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  1 +
 5 files changed, 54 insertions(+), 44 deletions(-)

-- 
2.9.3
