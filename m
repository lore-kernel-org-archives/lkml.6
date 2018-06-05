Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeFEMb6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:31:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48204 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751685AbeFEMb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:31:57 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        <jdmason@kudzu.us>, <chessman@tux.org>, <jes@trained-monkey.org>,
        <rahul.verma@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 0/6] use pci_zalloc_consistent
Date: Tue, 5 Jun 2018 20:28:45 +0800
Message-ID: <20180605122851.23912-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing (6):
  net: hippi: use pci_zalloc_consistent
  net: atheros: use pci_zalloc_consistent
  net: neterion: use pci_zalloc_consistent
  netxen_nic: use pci_zalloc_consistent
  net: tlan: use pci_zalloc_consistent
  enic: use pci_zalloc_consistent

 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |  8 +++----
 drivers/net/ethernet/atheros/atlx/atl2.c           |  5 ++--
 drivers/net/ethernet/cisco/enic/vnic_dev.c         |  3 +--
 drivers/net/ethernet/neterion/s2io.c               | 10 ++++----
 .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    | 26 ++++++++------------
 drivers/net/ethernet/ti/tlan.c                     |  7 +++---
 drivers/net/hippi/rrunner.c                        | 28 +++++++++-------------
 8 files changed, 35 insertions(+), 54 deletions(-)

-- 
2.7.0
