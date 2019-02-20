Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C4120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfBTNwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:52:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45869 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:52:43 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1gwSIc-0001hh-3E; Wed, 20 Feb 2019 14:52:34 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1gwSIa-00029H-T3; Wed, 20 Feb 2019 14:52:32 +0100
Date:   Wed, 20 Feb 2019 14:52:32 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] dt-bindings: imx: update scu resource id headfile
Message-ID: <20190220135232.4drv77tbkfwjeapl@pengutronix.de>
References: <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
 <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220081650.cu3yzausx55jefb6@pengutronix.de>
 <AM6PR04MB4215014B734F71D409D617A5807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220105249.u2hcvk6ut3cycvqs@pengutronix.de>
 <AM6PR04MB4215D9FE015E9251425B0FFC807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:09:17 up 32 days, 17:51, 40 users,  load average: 0.01, 0.04,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-20 13:11, Lucas Stach wrote:
> Am Mittwoch, den 20.02.2019, 11:21 +0000 schrieb Aisheng Dong:
> > Hi Marco,
> > 
> > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > Sent: Wednesday, February 20, 2019 6:53 PM
> > > 
> > > Hi Aisheng,
> > > 
> > > On 19-02-20 09:49, Aisheng Dong wrote:
> > > > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > > > Sent: Wednesday, February 20, 2019 4:17 PM On 19-02-20 03:38,
> > > > > Aisheng Dong wrote:
> > > > > > [...]
> > > > > > 
> > > > > > > > I don't like droping some ID's (e.g. IMX_SC_R_DC_0_CAPTURE0)
> > > > > > > > by mark them as unused or even worse give them a other
> > > > > > > > meaning. IMHO the scu-api should be stable since day 1 and the
> > > > > > > > ID's should only be
> > > > > extended.
> > > > > > > > Marking ID's as deprecated is much better than moving them around.
> > > > > > > 
> > > > > > > I agree the SCU APIs should be stable since day 1 and the ID
> > > > > > > should ONLY be extended, but that is the best cases, the reality
> > > > > > > is, there are different SoCs/Revision, some revisions may remove
> > > > > > > the resources ID defined in pre-coded SCU firmware, like the
> > > > > > > IMX_SC_R_DC_0_CAPTURE0 etc., so SCU APIs removes them after real
> > > > > > > silicon arrived, now latest SCU firmware marks them as UNUSED,
> > > > > > > they could be replaced by some other new resources in later new
> > > > > > > SoC, I am NOT sure, but if it happens, this resource ID table
> > > > > > > should be updated anyway, leaving the out-of-date resource ID
> > > > > > > table there will have
> > > > > issues, since it is NOT sync with SCU firmware.
> > > > > > > So how to resolve such issue? We hope the SCU firmware should be
> > > > > > > stable since day 1, but the truth is NOT, could be still some
> > > > > > > updates but NOT very often. And I believe the updates will NOT
> > > > > > > break old
> > > > > kernel version.
> > > > > 
> > > > > Hi Anson,
> > > > > 
> > > > > Please don't mix the dt-bindings and the kernel related stuff.
> > > > > Unfortunately the bindings are within the kernel repo which in fact
> > > > > is great for us kernel developer but the bindings are also used in
> > > > > other projects such as barebox or other kernels (don't know the BSD
> > > > > guys). So you can't ensure that your change will break something. Please
> > > keep that in mind.
> > > > > IMHO solving that issue should be done by the scu firmware. I tought
> > > > > the scu is a cortex-m4 with a bunch of embedded flash and ram (I
> > > > > don't know that much about the scu since it is closed/black-boxed).
> > > > > Why do you don't use a translation table within the scu? As I said
> > > > > earlier I don't like the redefinition of ID's since they are now part of the
> > > dt-bindings.
> > > > > The bindings can store up to 32bit values which is a large number ;)
> > > > > IMHO wasting some ID's in favour of stability is a better solution.
> > > > > 
> > > > 
> > > > As far as I know, those remove resource IDs are pre-defined and has
> > > > never been used and won't be used anymore by SC firmware. (Anson can
> > > > double check it) So I think it's safe to remove them or mark them as
> > > deprecated.
> > > 
> > > I think marking them as deprecated by a commentar is better than redefining
> > > bits to be unused. As I said the bindings not only linux related they are used in
> > > other projects too.
> > > 
> > 
> > For other projects, the result is same because SC firmware does not support those
> > Resource IDs.
> > 
> > > > Personally I may prefer to remove them as they never worked to avoid
> > > > confusing, especially at this early stage for mx8.
> > > 
> > > So why they are there if they never worked? Wouldn't it a better approach to
> > > start with a basic and working ID file and extend this rather than adding id's
> > > because maybe the will work.. 
> > 
> > Ideally yes, but may be hard in reality.
> > 
> > SC firmware code usually is developed quite early before silicon comes.
> > But the real chip may changes, e.g. removed or added something.
> > 
> > AFAIK those resource IDs removed have never worked in SC firmware,
> > and they're likely to come out of pre-silicon definition. But chip changes
> > later.
> > 
> > > Sorry but this seems wrong to me too.
> > > I know the approach from driver development, adding a driver specific *_reg.h
> > > file and later figuring out that those bits won't work as aspected. As I said this
> > > will be driver and only linux related so we can change them as many times as
> > > we want. But in your case we are talking about dt-bindings and this approach
> > > won't work.
> > 
> > I would agree with you if those resource IDs have worked before.
> > But they never worked.
> > Should we keep a thing never worked in device tree just because
> > It makes us look like keeping compatibility?
> > 
> > If that, I'd rather removing them to avoid confusing in the future. Life is long, right?
> > I don't want people to bother with those unmeaning things anymore when they
> > look at it.
> 
> Removing things is totally fine if they have never worked. Re-using the
> now "free" IDs is what is problematic. Only ever use previously unused
> IDs when introducing new stuff into the SCU firmware. This is something
> you need to communicate quite clearly with the SCU firmware developers.

I'm fine with removing too then there would be a gap. Don't know if it
is better to have a gap or a comment that those ID isn't supported since
fw-revision XYZ / silicon version ZYX.

Just some toughts:
The gap will then suggest that this ID is free and was never assigned to
some functionality. In real it was assigned previously and now gets
redefined. Also as far as I can see there are no gaps currently. Let's
wait for Rob's feedback.

As Lucas mentioned using IMX_SC_R_UNUSED* ID's for new functionality is
totaly fine but redefine ID's seems wrong to me. 

Regards,
Marco

> 
> Regards,
> Lucas
> 
> 

