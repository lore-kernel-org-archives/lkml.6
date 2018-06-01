Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFAKRN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:17:13 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43808 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeFAKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:17:07 -0400
X-Google-Smtp-Source: ADUXVKIqbLmTwr1UtOQHQaeHwq/9piZGYzQFrxgW3CgTYcoSmk3pDibJGcgIgqC/5jP4z1QksQmdVOv4bk5TeILzs/k=
MIME-Version: 1.0
In-Reply-To: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:17:06 +0300
Message-ID: <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
To: honghui.zhang@mediatek.com, Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>

> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_pcie_suspend_noirq(struct device *dev)

__maybe_unused

-- 
With Best Regards,
Andy Shevchenko
