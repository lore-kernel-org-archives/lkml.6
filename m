Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx49iyLTx/0Jg1gfULMn0MaKmVEUHEwyizYGT0Jrl78NXPzrfpMftg8S2/zNfc5j8Y4Lr1tyH
ARC-Seal: i=1; a=rsa-sha256; t=1523817973; cv=none;
        d=google.com; s=arc-20160816;
        b=m140X8O8ZOuSpE/MHd35aqS3Rn5MW+wGpvuqrx+o5Tsg12PPweXKRNyMmw4CmyEZ9I
         8APPL1EBmbjBY1iuyQ00Q1H+4IS1KotDxB3NrS6vC97qxeEO0wkHTHZYxIlFUNNgjfaF
         AukL+PJ26GUxlcbh0OvWaIfNq9Yc2WzA3eFjQXEpIBs+gr8JtuB9gEvjxfjn89OVJPQk
         pYDPGPUCYyoX+xQl/spKpAUVb4iM9tIecZsuCvAu7Y2p6BCerzlZP7AAXv/pmJL5XY3N
         CmxVbClFAF7qo3cis2m0P0YBQZ8BjkwEC88UqEYkV2GJmBPrfgUTsYWv4BbZfS1WwRCL
         zvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=YiCMpNfulto5at13QTmbgxCtSA6c80E8qWVJw8+5Wxw=;
        b=LbM0uhbOljYNytCbrv45W2KrX+U5O3/uENN2bB3BHRA+cqQcPw3/a32AjgiNvvfaLj
         REei9BmlSf7iE9s5Qhi5KEJbtemT+WWbFy1nAMWZ8H8lqDhRwW4VzXU4CNrrLhUL7/md
         XUZmZEqpRBXCzg/O6u2gZbAw76it0Yx1zaZw7UAhkqgn66OKf1tmsY8Xt9IGOfKXBZHH
         6WxKCz1Er6NNq29ghOTVCsqvT0Y5tfiLP9+AWrZKIeVHDTJ2vx8D1eWDjYyGjgARcLa/
         mjY3P2Osyf8fr0IV5faRbh0sNTbensOJHIq6XD8380RNjBAKm3hh7EK6+8OtIRcZi5YS
         jlkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.112 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.112 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2538:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3872:3874:4250:4321:5007:6117:6119:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12438:12740:12895:13161:13229:13439:13894:14181:14659:14721:21080:21324:21451:21627:30003:30025:30054:30067:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: watch03_8d397e6ffeb28
X-Filterd-Recvd-Size: 3383
Message-ID: <d59b997761d752877a9942e6be664d2ae1d25637.camel@perches.com>
Subject: Re: [PATCH v2 13/14] Move ad7746 out of staging
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>, =?ISO-8859-1?Q?Hern=E1n?= Gonzalez
	 <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Apr 2018 11:46:09 -0700
In-Reply-To: <20180415180451.4d538830@archlinux>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	 <1523637411-8531-14-git-send-email-hernan@vanguardiasur.com.ar>
	 <20180415180451.4d538830@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649762786653919?=
X-GMAIL-MSGID: =?utf-8?q?1597838954688364150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-04-15 at 18:04 +0100, Jonathan Cameron wrote:
> On Fri, 13 Apr 2018 13:36:50 -0300
> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> 
> > Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> 
> A few comments inline.

And a trivial typo and other bits

> > diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
[]
> > @@ -0,0 +1,5 @@
> > +#
> > +#Makeefile for industrial I/O CDC drivers

Makefile

> > diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
[]
> > @@ -0,0 +1,855 @@

Perhaps use the SPDX tags

> > +/*
> > + * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> > + *
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + */

[]

> > +static const struct iio_chan_spec ad7746_channels[] = {
> > +	[VIN] = {
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.address = AD7746_REG_VT_DATA_HIGH << 8 |
> > +			AD7746_VTSETUP_VTMD_EXT_VIN,
> 
> Hmm. I never like to see a single location used to hold two different things.
> I would suggest perhaps having address be an enum then have have a lookup
> into an array of structures that have the two elements separately.
> (use the ad7746_chan enum again for this?)

And perhaps it's nicer to align the multiple
BIT(identifier) uses like

		.info_mask_shared_by_type = (BIT(IIO_CHAN_INFO_SCALE) |
 					     BIT(IIO_CHAN_INFO_SAMP_FREQ)),

The extra unnecessary parentheses allow at least emacs
to align the BIT uses properly.

[]

> > +	[CIN1] = {
> > +		.type = IIO_CAPACITANCE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.address = AD7746_REG_CAP_DATA_HIGH << 8,
> > +	},

So this one could be:

		.info_mask_shared_by_type = (BIT(IIO_CHAN_INFO_CALIBBIAS) |
					     BIT(IIO_CHAN_INFO_SCALE) |
					     BIT(IIO_CHAN_INFO_SAMP_FREQ)),

etc...
