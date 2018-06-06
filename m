Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2B1460764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeFFNIp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:08:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58507 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751870AbeFFNIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:08:42 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 net-next 0/3] Bug fixes & optimization for HNS3 Driver
Date: Wed, 6 Jun 2018 14:07:50 +0100
Message-ID: <20180606130753.54428-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set presents miscellaneous bug fixes and an optimization
for HNS3 driver

V1->V2:
	* Fixes the compilation break reported by David Miller & Kbuild

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
