Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62729C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfAPV3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:29:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46533 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbfAPV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:29:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 05F3B207AC; Wed, 16 Jan 2019 22:29:26 +0100 (CET)
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        by mail.bootlin.com (Postfix) with ESMTPSA id CFEB0206A6;
        Wed, 16 Jan 2019 22:29:25 +0100 (CET)
Date:   Wed, 16 Jan 2019 22:29:26 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     ben.dooks@codethink.co.uk, linux-amlogic@lists.infradead.org,
        linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ccaione@baylibre.com
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
Message-ID: <20190116212926.GG2627@piout.net>
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
 <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
 <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
 <CAFBinCCKeb+wGJ4h_PfsT-Ms8AtLmNSwStTpeMqA3shkySjGkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCCKeb+wGJ4h_PfsT-Ms8AtLmNSwStTpeMqA3shkySjGkg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2019 13:52:00+0100, Martin Blumenstingl wrote:
> Hi Ben,
> 
> On Tue, Dec 18, 2018 at 12:48 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Ben,
> >
> > On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > [...]
> > > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > > > [resurrected Ben's patches after 2 years]
> > > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > >
> > > > Just checking if the change of author is deliberate?
> > > > not sure how to do >1 author on patches like this.
> > > I changed the author on purpose after seeing how much I changed
> > > (compared to your v4). this is also why I added you to the CC list
> > > however, I left in your copyright (just like you kept Carlo's
> > > copyright note) and MODULE_AUTHOR
> > please let me know:
> > 1. whether you want to be the author of the patch or if you're fine
> > with my name in there
> > 2. if you are fine with both of us being listed as Signed-off-by or if
> > you want me to switch to Co-authored-by
> > 3. about any other concerns you have
> >
> > I would like to update this patch next weekend so it can be reviewed
> > (and merged once all is fine) for v4.22
> gentle ping on this one now that the holiday season is over.
> 

I would think you can resend as they are. Or, you could resend v4 from
Ben and then a patch with your modifications.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
