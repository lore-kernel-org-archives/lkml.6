Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167648AbeBOXv7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:51:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35792 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164829AbeBOXvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:51:54 -0500
To: Li Wei <liwei213@huawei.com>
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <xuwei5@hisilicon.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>, <arnd@arndb.de>,
        <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>, <yamada.masahiro@socionext.com>,
        <riku.voipio@linaro.org>, <treding@nvidia.com>, <krzk@kernel.org>,
        <eric@anholt.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <zangleigang@hisilicon.com>,
        <gengjianfeng@hisilicon.com>, <guodong.xu@linaro.org>,
        <zhangfei.gao@linaro.org>, <fengbaopeng@hisilicon.com>
Subject: Re: [PATCH v8 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180213101412.5717-1-liwei213@huawei.com>
Date: Thu, 15 Feb 2018 18:51:01 -0500
In-Reply-To: <20180213101412.5717-1-liwei213@huawei.com> (Li Wei's message of
        "Tue, 13 Feb 2018 18:14:07 +0800")
Message-ID: <yq13721lsm2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=361
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Li,

> This patchset adds driver support for UFS for Hi3660 SoC. It is
> verified on HiKey960 board.
>
> Li Wei (5):
>   scsi: ufs: add Hisilicon ufs driver code
>   dt-bindings: scsi: ufs: add document for hisi-ufs
>   arm64: dts: add ufs dts node
>   arm64: defconfig: enable configs for Hisilicon ufs
>   arm64: defconfig: enable f2fs and squashfs

Is the intent for this series to go through the SCSI tree? If so, I'll
need some acks from the ARM maintainers for the dt/platform changes.

-- 
Martin K. Petersen	Oracle Linux Engineering
