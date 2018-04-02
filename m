Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDBQOn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:14:43 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:49845 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeDBQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:14:40 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <w-kwok2@ti.com>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>, <nsekhar@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [net-next 0/2] Add promiscous mode support in k2g network driver
Date: Mon, 2 Apr 2018 12:17:17 -0400
Message-ID: <1522685839-9497-1-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for promiscuous mode in network driver for K2G
SoC. This depends on v3 of my series at
https://www.spinics.net/lists/kernel/msg2765942.html

I plan to fold this to the above series and submit again when the net-next
merge windows opens. At this time, please review and let me know if it
looks good or need any re-work. I would like to get this ready so that it
can be merged along with the above series.

The boot and promiscuous mode test logs are at
https://pastebin.ubuntu.com/p/XQCvFS3QZb/

WingMan Kwok (2):
  net: netcp: add api to support set rx mode in netcp modules
  net: netcp: ethss: k2g: add promiscuous mode support

 drivers/net/ethernet/ti/netcp.h       |  1 +
 drivers/net/ethernet/ti/netcp_core.c  | 19 ++++++++++++
 drivers/net/ethernet/ti/netcp_ethss.c | 56 +++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

-- 
1.9.1
