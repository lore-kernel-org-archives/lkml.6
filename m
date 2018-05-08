Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756021AbeEHVmY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:42:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755489AbeEHVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:42:23 -0400
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 2/2] ARM: Keystone DTS update for v4.18
Date: Tue,  8 May 2018 14:41:37 -0700
Message-Id: <1525815697-6338-2-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525815697-6338-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1525815697-6338-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=407
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.18

for you to fetch changes up to 84cfd2c4f3b159b308976ccd0501985524fd6ee1:

  ARM: dts: k2g-evm: Add DCAN dt nodes (2018-05-04 23:11:49 -0700)

----------------------------------------------------------------
ARM: DTS: Add DCAN support for Keystone K2G

----------------------------------------------------------------
Faiz Abbas (1):
      ARM: dts: k2g-evm: Add DCAN dt nodes

 arch/arm/boot/dts/keystone-k2g-evm.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
