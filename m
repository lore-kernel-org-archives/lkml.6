Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeC2BAQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:00:16 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50782 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751043AbeC2BAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:00:14 -0400
From: "liwei (CM)" <liwei213@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
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
        Krzysztof Kozlowski <krzk@kernel.org>, Eric Anholt <eric@anholt.net>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        zangleigang <zangleigang@hisilicon.com>,
        Gengjianfeng <gengjianfeng@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Fengbaopeng (kevin, Kirin Solution Dept)"
        <fengbaopeng@hisilicon.com>,
        "Yaniv Gardi" <ygardi@codeaurora.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjggMi81?=
 =?utf-8?B?XSBkdC1iaW5kaW5nczogc2NzaTogdWZzOiBhZGQgZG9jdW1lbnQgZm9yIGhp?=
 =?utf-8?Q?si-ufs?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIHY4IDIvNV0gZHQtYmlu?=
 =?utf-8?Q?dings:_scsi:_ufs:_add_document_for_hisi-ufs?=
Thread-Index: AQHTpLNt7xq76dhVgkeSgBp0Vy2vQaOrAJgAgDJE6ZCABLCUgIAAkqZA//+FzQCAAJJzQIABEYQAgAGkfQCAAVCxoA==
Date: Thu, 29 Mar 2018 01:00:01 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140FA58BA1@DGGEMM506-MBS.china.huawei.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA584ED@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a3NdHLDf2vOMyZ1qcWNW1Jg5T47qR0qWhWEeDn+90S4ug@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA58798@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a29sDaEj=iTkru-3mc9NpjNvZos3Z+h5UsT1cAeULoGHw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA588AD@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a2BRXWbNzEcd9+Fi1zEkSA8aGB5ObxYrbVnaA7MKzU--w@mail.gmail.com>
In-Reply-To: <CAK8P3a2BRXWbNzEcd9+Fi1zEkSA8aGB5ObxYrbVnaA7MKzU--w@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2T10KZw024015

Hi, Arnd

Thanks for your patiences.

-----邮件原件-----
发件人: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] 代表 Arnd Bergmann
发送时间: 2018年3月28日 20:50
收件人: liwei (CM)
抄送: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; DTML; Linux Kernel Mailing List; Linux ARM; linux-scsi; zangleigang; Gengjianfeng; Guodong Xu; Zhangfei Gao; Fengbaopeng (kevin, Kirin Solution Dept); Yaniv Gardi
主题: Re: 答复: 答复: 答复: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs

On Tue, Mar 27, 2018 at 8:15 AM, liwei (CM) <liwei213@huawei.com> wrote:
> Hi, Arnd
>
> At present our ufs module mainly has four clocks from the outside:
> hclk_ufs:     main clock of ufs controller ,freq is 207.5MHz
> cfg_phy_clk:  configuration clock of MPHY, freq is 51.875MHz
> ref_phy_clk:  reference clock of MPHY from PMU, freq is 19.2MHz
> ref_io_clk:    reference clock for the external interface to the device, freq is 19.2MHz
>
> We control two clocks "ref_io_clk" and "cfg_phy_clk" in the driver 
> because the other two are controlled by main clock module and pmu.

I'm not completely sure what you mean with "control" here. Do you mean setting the rate and disabling them during runtime power management? What does it mean for the clock to be controlled by teh "main clock module and pmu"?

In the driver we only disable/enable "ref_io_clk" and "cfg_phy_clk" during runtime power management.

> for this patch, cfg_phy_clk corresponds to "phy_clk", ref_io_clk corresponds to "ref_clk".

I'm not sure I understand the difference between ref_phy_clk and ref_io_clk, but it sounds like we should give both of those names in the ufs-platform binding.

Your hclk_ufs would appear to correspond to what qualcomm calls core_clk, so maybe use that name as well.

cfg_phy_clk seems to be something that qcom would not have, but it's also generic enough to list it in the common binding.

Ok, let's add a describe for phy_clk in the common binding.

> So the clks in the patch you give appear to be unsuitable for describing this .And the following clks of qcom are internal clock?
> We didn't describe or pay attention to the clock inside the ufs module.
>
> PHY to controller symbol synchronization clocks:
>         "rx_lane0_sync_clk" - RX Lane 0
>         "rx_lane1_sync_clk" - RX Lane 1
>         "tx_lane0_sync_clk" - TX Lane 0
>         "tx_lane1_sync_clk" - TX Lane 1

Right, let's leave those for the qcom private binding.

      Arnd
