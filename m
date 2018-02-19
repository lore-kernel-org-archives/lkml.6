Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeBSDDP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:03:15 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37509 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeBSDDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:03:11 -0500
X-Google-Smtp-Source: AH8x22494t9+IBP+UFygO9HC6fi/PClDvYVoR+LyjjwS8iowJzhjZ/EqJPhH2PHdCedcPp/Aabfs9Q==
Date: Sun, 18 Feb 2018 21:03:09 -0600
From: Rob Herring <robh@kernel.org>
To: Li Wei <liwei213@huawei.com>
Cc: mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com,
        will.deacon@arm.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, khilman@baylibre.com, arnd@arndb.de,
        gregory.clement@free-electrons.com,
        thomas.petazzoni@free-electrons.com, yamada.masahiro@socionext.com,
        riku.voipio@linaro.org, treding@nvidia.com, krzk@kernel.org,
        eric@anholt.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-scsi@vger.kernel.org, zangleigang@hisilicon.com,
        gengjianfeng@hisilicon.com, guodong.xu@linaro.org,
        zhangfei.gao@linaro.org, fengbaopeng@hisilicon.com
Subject: Re: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
Message-ID: <20180219030309.vcunedttrszwmidk@rob-hp-laptop>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213101412.5717-3-liwei213@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 06:14:09PM +0800, Li Wei wrote:
> add ufs node document for Hisilicon.
> 
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt

Reviewed-by: Rob Herring <robh@kernel.org>
