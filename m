Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbeEHVmZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:42:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbeEHVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:42:23 -0400
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 1/2] ARM: SOC driver update v4.18
Date: Tue,  8 May 2018 14:41:36 -0700
Message-Id: <1525815697-6338-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.18

for you to fetch changes up to 1e0a601437a6111ecf384df010812c53cada6497:

  firmware: ti_sci: Switch to SPDX Licensing (2018-05-04 23:10:23 -0700)

----------------------------------------------------------------
ARM: SOC driver update for 4.18

 - AEMIF driver update to support board files and remove
   need of mach-davinci aemif code
 - Use percpu counters for qmss datapath stats
 - License update for TI SCI

----------------------------------------------------------------
Bartosz Golaszewski (2):
      memory: aemif: don't rely on kbuild for driver's name
      memory: aemif: add support for board files

Lokesh Vutla (1):
      firmware: ti_sci: Switch to SPDX Licensing

Vasyl Gomonovych (1):
      soc: ti: knav_qmss: Use percpu instead atomic for stats counter

 drivers/firmware/ti_sci.c              | 10 +-----
 drivers/firmware/ti_sci.h              | 30 +----------------
 drivers/memory/ti-aemif.c              | 60 ++++++++++++++++++++++------------
 drivers/soc/ti/knav_qmss.h             | 14 ++++----
 drivers/soc/ti/knav_qmss_queue.c       | 60 ++++++++++++++++++++++------------
 include/linux/platform_data/ti-aemif.h | 25 ++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 10 +-----
 7 files changed, 115 insertions(+), 94 deletions(-)
