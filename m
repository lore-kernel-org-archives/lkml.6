Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeD3PUB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:20:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54114 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752939AbeD3PTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:19:23 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] HiSilicon LPC defconfig and DT patches
Date: Mon, 30 Apr 2018 23:15:39 +0800
Message-ID: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces 3 patches, to enable the
HISILICON_LPC config in the arm64 defconfig
and also add the relevant LPC DT entries.

For hip06 UART support, we depend on this patch:
https://lkml.org/lkml/2018/4/27/258

John Garry (3):
  arm64: defconfig: Enable HISILICON_LPC
  arm64: dts: hisi: Enable Hisi LPC node for hip06
  arm64: dts: hisi: Enable Hisi LPC node for hip07

 arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 ++++++++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi    | 14 ++++++++++++++
 arch/arm64/configs/defconfig                |  1 +
 5 files changed, 48 insertions(+)

-- 
1.9.1
