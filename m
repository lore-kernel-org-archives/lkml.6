Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeCWQGd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:06:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751811AbeCWQGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:06:15 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/8] hisi_sas: some misc changes
Date: Sat, 24 Mar 2018 00:05:07 +0800
Message-ID: <1521821115-120040-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some minor, more trivial patches,
some of which have been sitting on our internal dev branch
for a while.

The only bug fixes (hw workaround or sw) are the IPTT range
check fix and a timer fix for module removal. Others are
trivial.

John Garry (2):
  scsi: hisi_sas: print device id for errors
  scsi: hisi_sas: remove some unneeded structure members

Xiang Chen (3):
  scsi: hisi_sas: make SAS address of SATA disks unique
  scsi: hisi_sas: delete timer when removing hisi_sas driver
  scsi: hisi_sas: use dma_zalloc_coherent()

Xiaofei Tan (3):
  scsi: hisi_sas: update RAS feature for later revision of v3 HW
  scsi: hisi_sas: consolidate command check in
    hisi_sas_get_ata_protocol()
  scsi: hisi_sas: check IPTT is valid before using it for v3 hw

 drivers/scsi/hisi_sas/hisi_sas.h       |  3 --
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 53 +++++++++-------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  8 ++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 81 +++++++++++++++++++++++++++++-----
 4 files changed, 94 insertions(+), 51 deletions(-)

-- 
1.9.1
