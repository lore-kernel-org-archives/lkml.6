Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB98C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A492173C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfAUJKt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:10:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42359 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfAUJKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:10:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B65A420898; Mon, 21 Jan 2019 10:10:44 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 251FF2078C;
        Mon, 21 Jan 2019 10:10:30 +0100 (CET)
Date:   Mon, 21 Jan 2019 10:10:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Amlogic NAND controller
 driver
Message-ID: <20190121101030.2efbee17@xps13>
In-Reply-To: <54e8156f-2362-21db-3e6c-e5b68147c49c@amlogic.com>
References: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
        <20190120160605.33689354@xps13>
        <3f098e44-9d9b-3d0a-3e19-5913077aeb07@amlogic.com>
        <20190121092106.2c97ebe2@xps13>
        <54e8156f-2362-21db-3e6c-e5b68147c49c@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

Liang Yang <liang.yang@amlogic.com> wrote on Mon, 21 Jan 2019 16:59:42
+0800:

> Hi Miquel，
> 
> On 2019/1/21 16:21, Miquel Raynal wrote:
> > Hi Jianxin,
> > 
> > Jianxin Pan <jianxin.pan@amlogic.com> wrote on Mon, 21 Jan 2019
> > 12:18:18 +0800:
> >   
> >> Hi Miquel,
> >>
> >> On 2019/1/20 23:06, Miquel Raynal wrote:  
> >>> Hi Jianxin,
> >>>
> >>> Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sun, 20 Jan 2019
> >>> 01:02:35 +0800:  
> >>>    >>>> Add entry for Amlogic NAND controller driver and its bindings[0].  
> >>>>
> >>>> [0] https://lore.kernel.org/lkml/1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com/
> >>>>
> >>>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> >>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>  
> >>>
> >>> If you are the author of the patch your Signed-off-by should come first.  
> >> OK.  
> >>>
> >>> Also, why is Liang the Maintainer? Why not you?  
> >>>    >> Yangliang is Amlogic maintainer for NAND controller. And all patches about amlogic NAND controller are from him.  
> > 
> > Maybe but he never wrote to the ML, the maintainer may be someone else
> > than the original author, I just want someone to review patches and
> > help to maintain the driver.
> > 
> > Yangliang are you willing to do that?
> > Of course.it is my pleasure and responsibility.

Ok then, it's fine for me!


Thanks,
Miquèl
