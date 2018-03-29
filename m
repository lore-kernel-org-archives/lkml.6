Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeC2NEJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:04:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45556 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeC2NEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:04:06 -0400
X-Google-Smtp-Source: AIpwx4/qNVF0lykf5/LDBgHIcaw0WxW5qSqP9UFY+PvIXcXx3tYes/03Ts7LYtOwlfE4OsUPGG5lQg==
Date: Thu, 29 Mar 2018 14:04:02 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        jcsing.lee@samsung.com, linux-kernel@vger.kernel.org, krzk@kernel.org,
        javier@osg.samsung.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        eddie.huang@mediatek.com, beomho.seo@samsung.com,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Add MediaTek PMIC keys support
Message-ID: <20180329130402.6fp7nofyp6iesmbv@dell>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <808b2029da224ab687fb0553cbc1c68e@mtkmbs08n1.mediatek.inc>
 <1521685073.28226.10.camel@mtkswgap22>
 <20180323185418.GD255819@dtor-ws>
 <20180327080507.pgil6pw2mn4y2f4d@dell>
 <3ece050c-7573-ef4e-2c89-61645a243a33@gmail.com>
 <20180328102640.yx6nv5abfexmouuf@dell>
 <1522290675.17084.8.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522290675.17084.8.camel@mhfsdcap03>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Chen Zhong wrote:

> On Wed, 2018-03-28 at 11:26 +0100, Lee Jones wrote:
> > On Tue, 27 Mar 2018, Matthias Brugger wrote:
> > 
> > > 
> > > 
> > > On 03/27/2018 10:05 AM, Lee Jones wrote:
> > > > On Fri, 23 Mar 2018, Dmitry Torokhov wrote:
> > > >> On Thu, Mar 22, 2018 at 10:17:53AM +0800, Sean Wang wrote:
> > > >>> Hi, Dmitry and Lee
> > > >>>
> > > >>> The series seems not being got merged. Are they good enough to be ready
> > > >>> into the your tree?
> > > >>>
> > > >>> Recently I've tested the series with focusing on pwrkey event generated
> > > >>> through interrupt when push and release the key on bpi-r2 board and then
> > > >>> finally it's working fine. but for homekey it cannot be found on the
> > > >>> board and thus I cannot have more tests more about it.
> > > >>>
> > > >>> Tested-by: Sean Wang <sean.wang@mediatek.com>
> > > >>
> > > >> You have my Ack on the input patch; I expect it go through Lee's tree as
> > > >> there are some dependencies on mfd core piece.
> > > > 
> > > > Are you happy for me to merge the Input dt-bindings without your Ack?
> > > > 
> > > 
> > > They got both Acked in v5, but the commit message was not updated:
> > > https://patchwork.kernel.org/patch/9973721/
> > > https://patchwork.kernel.org/patch/9973723/
> > 
> > Thanks Matthias.
> > 
> > Chen, can you collect all the Acks and repost as a RESEND please?
> > 
> 
> Thanks Matthias, Lee, Dmitry and Sean for your comments.
> 
> Hi Lee,
> 
> I have collected the Acks by Rob and sent the v6:
> https://patchwork.kernel.org/patch/10026705
> https://patchwork.kernel.org/patch/10026707
> 
> Are they enough to be merged?

Oh, I see.

I was asking about Dmitry's Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
