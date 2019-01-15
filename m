Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F00C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAODQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:16:28 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35432 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfAODQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:16:28 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0F3GFtF006436;
        Tue, 15 Jan 2019 04:16:15 +0100
Date:   Tue, 15 Jan 2019 04:16:15 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/8] ASoC: dapm: change snprintf to scnprintf for
 possible overflow
Message-ID: <20190115031615.GB6416@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-7-w@1wt.eu>
 <20190114145650.GD11073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114145650.GD11073@sirena.org.uk>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jan 14, 2019 at 02:56:50PM +0000, Mark Brown wrote:
> On Sat, Jan 12, 2019 at 04:28:43PM +0100, Willy Tarreau wrote:
> > From: Silvio Cesare <silvio.cesare@gmail.com>
> > 
> > Change snprintf to scnprintf. There are generally two cases where using
> > snprintf causes problems.
> 
> I don't have a cover letter or anything before this in the series.
> What's going on with dependencies here?

Sorry for the lack of more context, I was just involved in putting a
subject line on each patch and passing them through get_maintainers.pl.
These ones were sent to the security list after this article was published:

  http://blog.infosectcbr.com.au/2018/11/memory-bugs-in-multiple-linux-kernel.html

Thanks,
Willy
