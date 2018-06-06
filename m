Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeFFAsZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:48:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5935 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932237AbeFFAsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:48:22 -0400
From: "liwei (CM)" <liwei213@huawei.com>
To: Valentin Schneider <valentin.schneider@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregory.clement@free-electrons.com"
        <gregory.clement@free-electrons.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "riku.voipio@linaro.org" <riku.voipio@linaro.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC: zangleigang <zangleigang@hisilicon.com>,
        Gengjianfeng <gengjianfeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "Fengbaopeng (kevin, Kirin Solution Dept)"
        <fengbaopeng@hisilicon.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjEwIDAvNV0gc2NzaTogdWZzOiBhZGQgdWZzIGRy?=
 =?utf-8?Q?iver_code_for_Hisilicon_Hi3660_SoC?=
Thread-Topic: [PATCH v10 0/5] scsi: ufs: add ufs driver code for Hisilicon
 Hi3660 SoC
Thread-Index: AQHT9AkxQWK+G+bXi02L+/Dtef+lMKRRTWsAgAEqTaA=
Date: Wed, 6 Jun 2018 00:48:13 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140FA70129@DGGEMM506-MBX.china.huawei.com>
References: <20180525091712.37227-1-liwei213@huawei.com>
 <f9cde7df-2d4d-3d7e-5269-ef879211b2ee@arm.com>
In-Reply-To: <f9cde7df-2d4d-3d7e-5269-ef879211b2ee@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.189.155.72]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w560mVw6027401

Hi, Valentin

Thank you for your attention and work.

Thanks!

-----邮件原件-----
发件人: Valentin Schneider [mailto:valentin.schneider@arm.com] 
发送时间: 2018年6月5日 22:59
收件人: liwei (CM); robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com; will.deacon@arm.com; vinholikatti@gmail.com; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; khilman@baylibre.com; arnd@arndb.de; gregory.clement@free-electrons.com; thomas.petazzoni@free-electrons.com; yamada.masahiro@socionext.com; riku.voipio@linaro.org; treding@nvidia.com; krzk@kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-scsi@vger.kernel.org
抄送: zangleigang; Gengjianfeng; guodong.xu@linaro.org; Chenfeng (puck); john.stultz@linaro.org; Fengbaopeng (kevin, Kirin Solution Dept)
主题: Re: [PATCH v10 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC

Hi,

On 25/05/18 10:17, Li Wei wrote:
> This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.
> 
> Li Wei (5):
>   scsi: ufs: add Hisilicon ufs driver code
>   dt-bindings: scsi: ufs: add document for hisi-ufs
>   arm64: dts: add ufs dts node
>   arm64: defconfig: enable configs for Hisilicon ufs
>   arm64: defconfig: enable f2fs and squashfs
> 
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  41 ++
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  10 +-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  18 +
>  arch/arm64/configs/defconfig                       |  11 +
>  drivers/scsi/ufs/Kconfig                           |   9 +
>  drivers/scsi/ufs/Makefile                          |   1 +
>  drivers/scsi/ufs/ufs-hisi.c                        | 619 +++++++++++++++++++++
>  drivers/scsi/ufs/ufs-hisi.h                        | 115 ++++
>  8 files changed, 821 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.c
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.h
> 
> Major changes in v10:
>  - solve review comments from Rob Herring.
>    *Modify the "reset-names" describe in ufs-hisi.txt binding file.
>    *List clocks in ufs-hisi.txt binding file.
>    *remove the "arst" and keep only "rst" in the binging files.
>    *remove the "arst" member from both dts and c code. 
> Major changes in v9:
>  - solve review comments from Rob Herring.
>    *remove freq-table-hz in ufs-hisi.txt binding file.
>    *Move the rst to the ufshcd_pltfm.txt common binding file.
>    *Modify the member "assert" of UFS host structure to "arst".
> Major changes in v8:
>  - solve review comments from zhangfei.
>    *Add Version history.
>  - solve review comments from Rob Herring.
>    *remove freq-table-hz.
>  -  solve review comments from Riku Voipio.
>    *Add MODULE_DEVICE_TABLE for ufs driver.
> 

Tested on top of linux-next (4.17.0-next-20180605), I can reliably load
my debian userspace flashed on the 'system' fastboot partition.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
