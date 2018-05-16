Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeEPNQj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeEPNQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:16:36 -0400
X-Google-Smtp-Source: AB8JxZrUC4H0d8YvK/Zldr/lvycfAfm5EIXxGUL6r4CidDnV95ZJmgZnrhMUs38mUxUYrnqXiAJemVEidZmCt52YuiU=
MIME-Version: 1.0
In-Reply-To: <1699CE87DE933F49876AD744B5DC140FA5AC86@DGGEMM506-MBS.china.huawei.com>
References: <20180417140814.38098-1-liwei213@huawei.com> <20180417140814.38098-3-liwei213@huawei.com>
 <20180424125827.k2dgeu6uon75wzni@rob-hp-laptop> <1699CE87DE933F49876AD744B5DC140FA5AC86@DGGEMM506-MBS.china.huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 16 May 2018 08:16:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLf_r=NHHP2ZNEJOoLORXztF1KnU+tq-+COt4CPMLAsiA@mail.gmail.com>
Message-ID: <CAL_JsqLf_r=NHHP2ZNEJOoLORXztF1KnU+tq-+COt4CPMLAsiA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHY5IDIvNV0gZHQtYmluZGluZ3M6IHNjc2k6IHVmczogYQ==?=
        =?UTF-8?B?ZGQgZG9jdW1lbnQgZm9yIGhpc2ktdWZz?=
To: "liwei (CM)" <liwei213@huawei.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        zangleigang <zangleigang@hisilicon.com>,
        Gengjianfeng <gengjianfeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GDGj48005282

On Tue, Apr 24, 2018 at 8:54 AM, liwei (CM) <liwei213@huawei.com> wrote:
> Hi, Rob
>
> Thanks for your patience.
>
> Hi, Arnd
>
> From Rob's suggestion, we have to list the properties node in ufs-hisi.txt bingings even if documented in the common binding.
>
> -----邮件原件-----
> 发件人: Rob Herring [mailto:robh@kernel.org]
> 发送时间: 2018年4月24日 20:58
> 收件人: liwei (CM)
> 抄送: mark.rutland@arm.com; catalin.marinas@arm.com; will.deacon@arm.com; vinholikatti@gmail.com; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; khilman@baylibre.com; arnd@arndb.de; gregory.clement@free-electrons.com; thomas.petazzoni@free-electrons.com; yamada.masahiro@socionext.com; riku.voipio@linaro.org; treding@nvidia.com; krzk@kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-scsi@vger.kernel.org; zangleigang; Gengjianfeng; guodong.xu@linaro.org
> 主题: Re: [PATCH v9 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
>
> On Tue, Apr 17, 2018 at 10:08:11PM +0800, Li Wei wrote:
>> add ufs node document for Hisilicon.
>>
>> Signed-off-by: Li Wei <liwei213@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 29 ++++++++++++++++++++++
>>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      | 10 +++++---
>>  2 files changed, 36 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> new file mode 100644
>> index 000000000000..d49ab7d8f31d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>> @@ -0,0 +1,29 @@
>> +* Hisilicon Universal Flash Storage (UFS) Host Controller
>> +
>> +UFS nodes are defined to describe on-chip UFS hardware macro.
>> +Each UFS Host Controller should have its own node.
>> +
>> +Required properties:
>> +- compatible        : compatible list, contains one of the following -
>> +                                     "hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
>> +                                     host controller present on Hi36xx chipset.
>> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
>> +- interrupt-parent  : interrupt device
>> +- interrupts        : interrupt number
>> +- resets            : reset node register, the "arst" corresponds to reset the APB/AXI bus.
>
> arst belongs in reset-names.
>
> OK, I will fix it in next patch;
>
>> +- reset-names       : describe reset node register
>
> What happened to clocks? You still have to list which ones apply even if
> documented in the common binding.
>
> OK, I will fix it in next patch;
>
>> +
>> +Example:
>> +
>> +     ufs: ufs@ff3b0000 {
>> +             compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
>> +             /* 0: HCI standard */
>> +             /* 1: UFS SYS CTRL */
>> +             reg = <0x0 0xff3b0000 0x0 0x1000>,
>> +                     <0x0 0xff3b1000 0x0 0x1000>;
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
>> +             /* offset: 0x84; bit: 7  */
>> +             resets = <&crg_rst 0x84 7>;
>> +             reset-names = "arst";
>> +     };
>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> index c39dfef76a18..adcfb79f63f5 100644
>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> @@ -41,6 +41,8 @@ Optional properties:
>>  -lanes-per-direction : number of lanes available per direction - either 1 or 2.
>>                         Note that it is assume same number of lanes is used both
>>                         directions at once. If not specified, default is 2 lanes per direction.
>> +- resets            : reset node register, the "rst" corresponds to reset the whole UFS IP.
>> +- reset-names       : describe reset node register
>
> Does your controller have 1 or 2 resets? There's no point in adding this
> here if it doesn't apply to your controller.
>
> There are 2 reset in our soc init, the "rst" corresponds to reset the whole UFS IP, and " arst " only reset the APB/AXI bus.
> Discussed with our soc colleagues that "arst" is assert by default and needs to deassert,but it done in bootloader,so will remove 'arst' in next patch.
>
> About the 'reset' property，it seems that Arnd Bergmann has different suggestion，he suggested that add 'rst' to ufshcd-pltfrm because it seems common.
> But it looks like only our soc init needs it. What's your opinion? Does it still needs add to common bindings?

For a single reset, then I'm fine with it being in the common
bindings. If there are multiple then it should be in the specific
bindings as the reset names are likely different.

Rob
