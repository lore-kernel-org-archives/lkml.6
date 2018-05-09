Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965530AbeEIQ0M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:26:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42712 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S965513AbeEIQ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:26:10 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/4] Misc bug fixes for HNS3 Ethernet Driver
Date: Wed, 9 May 2018 17:24:37 +0100
Message-ID: <20180509162441.18068-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes to some of the bugs found during system test, internal review
and clean-up

Yunsheng Lin (4):
  net: hns3: Fix for setting mac address when resetting
  net: hns3: remove add/del_tunnel_udp in hns3_enet module
  net: hns3: fix for cleaning ring problem
  net: hns3: refactor the loopback related function

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   7 --
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 131 ++++++---------------
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  21 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  68 +++++------
 4 files changed, 76 insertions(+), 151 deletions(-)

-- 
2.7.4
