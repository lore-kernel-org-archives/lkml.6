Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeFAKwr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:52:47 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35615 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeFAKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:52:45 -0400
X-Google-Smtp-Source: ADUXVKIy08YPwsPrrRNJNNSWJBOi6dvLX0Sqjt+sylq9QQKOILkoWHTmq7tZk2gf6SSZQvrbc7fWlwSZQrLFAiJjy1Y=
MIME-Version: 1.0
In-Reply-To: <1527850145.28160.6.camel@mhfsdcap03>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
 <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com> <1527850145.28160.6.camel@mhfsdcap03>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:52:44 +0300
Message-ID: <CAHp75VcEp2kFO4hncvMS4Dh1AzvoFbrps7+FLmdk0RLyNTHz7g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
To: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, yingjoe.chen@mediatek.com,
        Eddie Huang <eddie.huang@mediatek.com>, ryder.lee@mediatek.com,
        hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        yong.wu@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 1:49 PM, Honghui Zhang
<honghui.zhang@mediatek.com> wrote:
> On Fri, 2018-06-01 at 13:17 +0300, Andy Shevchenko wrote:
>> On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
>> > From: Honghui Zhang <honghui.zhang@mediatek.com>
>>
>> > +#ifdef CONFIG_PM_SLEEP
>> > +static int mtk_pcie_suspend_noirq(struct device *dev)
>>
>> __maybe_unused
>>
>
> Hi, Andy, thanks for your review.
> Bjorn had point this out that at:
> https://www.spinics.net/lists/arm-kernel/msg656774.html

Nice, one more maintainer with strong opinion here.

Arnd, that's what I mentioned as a split in opinions earlier.
Any new developer or even existing contributor would be now really
confusing since maintainers asked for two different approaches on the
same matter.

-- 
With Best Regards,
Andy Shevchenko
