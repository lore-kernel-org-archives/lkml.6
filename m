Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbeBMKOm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:14:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46940 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933845AbeBMKOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:14:23 -0500
From: Li Wei <liwei213@huawei.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <xuwei5@hisilicon.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>, <arnd@arndb.de>,
        <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>, <yamada.masahiro@socionext.com>,
        <riku.voipio@linaro.org>, <treding@nvidia.com>, <krzk@kernel.org>,
        <eric@anholt.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <zangleigang@hisilicon.com>, <gengjianfeng@hisilicon.com>,
        <guodong.xu@linaro.org>, <zhangfei.gao@linaro.org>,
        <fengbaopeng@hisilicon.com>, <liwei213@huawei.com>
Subject: [PATCH v8 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Date: Tue, 13 Feb 2018 18:14:07 +0800
Message-ID: <20180213101412.5717-1-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.

Li Wei (5):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs
  arm64: defconfig: enable f2fs and squashfs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  37 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  19 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 623 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 116 ++++
 7 files changed, 816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

-- 
Major changes in v7:
 - solve review comments from Philippe Ombredanne.
   *use the new SPDX license ids instead of the GNU General Public License.

Major changes in v8:
 - solve review comments from zhangfei.
   *Add Version history.
 - solve review comments from Rob Herring.
   *remove freq-table-hz.
 -  solve review comments from Riku Voipio.
   *Add MODULE_DEVICE_TABLE for ufs driver.
2.15.0
