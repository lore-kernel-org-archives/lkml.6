Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933701AbeCFAlx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:41:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932692AbeCFAlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:41:50 -0500
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 2/2] SOC: Couple of drivers changes for v4.17
Date: Mon,  5 Mar 2018 16:41:13 -0800
Message-Id: <1520296873-12982-2-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=454
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.17

for you to fetch changes up to a817e5d82a2dc5daaa0a8a66cfab268fdf2f6bb6:

  memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe() (2018-03-05 16:21:31 -0800)

----------------------------------------------------------------
SOC driver changes for v4.17

 - Remove deundant dev_err from probe in ti-emif-srma driver
 - Make use of seq_putc in emif reg show

----------------------------------------------------------------
SF Markus Elfring (1):
      memory-EMIF: Use seq_putc() in emif_regdump_show()

Wei Yongjun (1):
      memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe()

 drivers/memory/emif.c       | 2 +-
 drivers/memory/ti-emif-pm.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
