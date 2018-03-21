Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCUKvA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:51:00 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:30263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751583AbeCUKu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:50:59 -0400
From: Shiju Jose <shiju.jose@huawei.com>
To: gengdongjiu <gengdongjiu@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>,
        Xiexiuqi <xiexiuqi@huawei.com>,
        "Zhengqiang (turing)" <zhengqiang10@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH]arm64:defconfig:enable ACPI_APEI_SEA
Thread-Topic: [PATCH]arm64:defconfig:enable ACPI_APEI_SEA
Thread-Index: AQHTwEZb41vjGrJsL068DhGERrHQKKPZ3CSAgACn05A=
Date: Wed, 21 Mar 2018 10:50:47 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A64EDFC250@FRAEML521-MBX.china.huawei.com>
References: <aa732187-e12a-68e5-d15e-84090855d2c5@huawei.com>
 <a56d6415-0755-6125-84c3-f5aef95434ca@huawei.com>
In-Reply-To: <a56d6415-0755-6125-84c3-f5aef95434ca@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.52]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LAp4K6000355

Hi Gengdongjiu,

Ok got it. Please ignore this patch.

Thanks,
Shiju 

> -----Original Message-----
> From: gengdongjiu
> Sent: 21 March 2018 01:49
> To: Shiju Jose; xuwei (O)
> Cc: arnd@arndb.de; james.morse@arm.com; tbaicar@codeaurora.org;
> Xiexiuqi; Zhengqiang (turing); Linuxarm; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH]arm64:defconfig:enable ACPI_APEI_SEA
> 
> Hi Shiju,
>    The configuration "CONFIG_ACPI_APEI_SEA" is needed to manually
> enable?
> In the "drivers/acpi/apei/Kconfig" file, the default value of
> ACPI_APEI_SEA is "y"
> 
> config ACPI_APEI_SEA
>         bool "APEI Synchronous External Abort logging/recovering
> support"
>         depends on ARM64 && ACPI_APEI_GHES
>         default y
>         help
>           This option should be enabled if the system supports
>           firmware first handling of SEA (Synchronous External Abort).
>           SEA happens with certain faults of data abort or instruction
>           abort synchronous exceptions on ARMv8 systems. If a system
>           supports firmware first handling of SEA, the platform
> analyzes
>           and handles hardware error notifications from SEA, and it may
> then
>           form a HW error record for the OS to parse and handle. This
>           option allows the OS to look for such hardware error record,
> and
>           take appropriate action.
> 
> 
> On 2018/3/20 20:23, Shiju Jose wrote:
> > Enable ACPI APEI SEA option for arm64, to handle
> > ARMv8 SEA(Synchronous External Abort).
> >
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Cc: Tyler Baicar <tbaicar@codeaurora.org>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Dongjiu Geng <gengdongjiu@huawei.com>
> > Cc: Xie XiuQi <xiexiuqi@huawei.com>
> > Cc: Qiang Zheng <zhengqiang10@huawei.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig
> > b/arch/arm64/configs/defconfig index 634b373..5ddf25c 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -574,6 +574,7 @@ CONFIG_ACPI_APEI_GHES=y
> > CONFIG_ACPI_APEI_PCIEAER=y  CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> > CONFIG_ACPI_APEI_EINJ=y
> > +CONFIG_ACPI_APEI_SEA=y
> >  CONFIG_EXT2_FS=y
> >  CONFIG_EXT3_FS=y
> >  CONFIG_EXT4_FS_POSIX_ACL=y
> >
