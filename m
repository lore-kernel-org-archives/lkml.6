Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeFAKtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:49:39 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25597 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751625AbeFAKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:49:21 -0400
X-UUID: 068806cfd9c94912979c38b79f5886e3-20180601
Message-ID: <1527850145.28160.6.camel@mhfsdcap03>
Subject: Re: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Arnd Bergmann <arnd.bergmann@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>,
        <hongkun.cao@mediatek.com>, <youlin.pei@mediatek.com>,
        <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Date: Fri, 1 Jun 2018 18:49:05 +0800
In-Reply-To: <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
         <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 13:17 +0300, Andy Shevchenko wrote:
> On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mtk_pcie_suspend_noirq(struct device *dev)
> 
> __maybe_unused
> 

Hi, Andy, thanks for your review.
Bjorn had point this out that at:
https://www.spinics.net/lists/arm-kernel/msg656774.html

So __maybe_unused is not really needed.

thanks
