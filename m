Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933242AbeCNCSG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 22:18:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5901 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932809AbeCNCSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 22:18:03 -0400
From: "liwei (CM)" <liwei213@huawei.com>
To: "liwei (CM)" <liwei213@huawei.com>, Arnd Bergmann <arnd@arndb.de>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        zangleigang <zangleigang@hisilicon.com>,
        Gengjianfeng <gengjianfeng@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Fengbaopeng (kevin, Kirin Solution Dept)"
        <fengbaopeng@hisilicon.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjggMi81XSBkdC1iaW5kaW5nczogc2NzaTogdWZz?=
 =?utf-8?Q?:_add_document_for_hisi-ufs?=
Thread-Topic: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for
 hisi-ufs
Thread-Index: AQHTpLNt7xq76dhVgkeSgBp0Vy2vQaOrAJgAgAauIaCAHXoQsA==
Date: Wed, 14 Mar 2018 02:17:51 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140FA57B80@DGGEMM506-MBS.china.huawei.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2E2ICRF016589

Hi，Arnd

Sorry to bother you again, please take the time to review the patch. Are there any other suggestions?
Looking forward to your reply.

Thanks!



-----邮件原件-----
发件人: liwei (CM) 
发送时间: 2018年2月23日 16:36
收件人: 'Arnd Bergmann'
抄送: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept)
主题: 答复: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

Hi, Arnd

Sorry late for you.
The following two suggestions we have really discussed
https://lkml.org/lkml/2017/11/30/1077

-----邮件原件-----
发件人: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] 代表 Arnd Bergmann
发送时间: 2018年2月19日 17:58
收件人: liwei (CM)
抄送: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept)
主题: Re: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Tue, Feb 13, 2018 at 11:14 AM, Li Wei <liwei213@huawei.com> wrote:
> add ufs node document for Hisilicon.
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 37 
> ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt


I'm pretty sure we've discussed it before, but can you make this so that the generic properties are part of the ufshcd binding, and you refer to it from here, only describing in what ways the hisi ufs binding differs from the standard?

> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt 
> b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> new file mode 100644
> index 000000000000..0d21b57496cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -0,0 +1,37 @@
> +* Hisilicon Universal Flash Storage (UFS) Host Controller
> +
> +UFS nodes are defined to describe on-chip UFS hardware macro.
> +Each UFS Host Controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains one of the following -
> +                                       "hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> +                                       host controller present on Hi36xx chipset.
> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
> +- interrupt-parent  : interrupt device
> +- interrupts        : interrupt number
> +- clocks               : List of phandle and clock specifier pairs
> +- clock-names       : List of clock input name strings sorted in the same
> +                                       order as the clocks property. 
> +"ref_clk", "phy_clk" is optional

The clock names sound generic enough, should we have both in the generic binding?

"ref_clk" is in the ufshcd-pltfrm binding, but "phy_clk" is not; what do you mean is that these two don't need to document here?

> +- resets            : reset node register, one reset the clk and the other reset the controller
> +- reset-names       : describe reset node register

This looks incomplete. What is the name of the reset line supposed to be?
I'd also suggest you document it in the ufshcd binding instead.

As discussed in https://lkml.org/lkml/2017/11/30/1077;
If document it in the ufshcd binding, I think it needs some codes to parse them in ufshcd.c/ufshcd-pltfrm.c, but I think these codes may not be applicable to other SOC manufacturers.

      Arnd
