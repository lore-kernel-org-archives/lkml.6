Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85851C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473C420882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473C420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeIMOwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:52:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeIMOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:52:47 -0400
Received: from localhost (unknown [37.168.145.102])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51D83AF3;
        Thu, 13 Sep 2018 09:44:04 +0000 (UTC)
Date:   Thu, 13 Sep 2018 11:43:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of
 thunderbolt
Message-ID: <20180913094359.GA634@kroah.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
 <20180910093333.GI14465@lahna.fi.intel.com>
 <20180913085826.GC14465@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913085826.GC14465@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:58:26AM +0300, Mika Westerberg wrote:
> On Mon, Sep 10, 2018 at 12:33:33PM +0300, Mika Westerberg wrote:
> > Hi Lukas,
> > 
> > I'm including Greg here in case I've done something wrong as a maintainer.
> > Since I've only maintained Thunderbolt quite short time, it may be that
> > I've done mistakes but certainly I did not deliberately try to make life of
> > people developing this for older Apple systems harder.
> 
> Greg did not yell at me (yet) so I guess I'm doing OK :)

I have not seen anything to complain about here, so why would I?  :)

> > On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> > > Andreas Noever has let it be known off-list already a while ago that he
> > > currently cannot spare as much time for Thunderbolt development as he'd
> > > like.  As a result the driver's development has become dominated by
> > > Intel.
> > 
> > I was not aware of this. Althought Andreas has not commented much
> > lately, I thought he is still looking after our changes. I hope he still
> > is :)
> > 
> > > I would like to step up as co-maintainer to provide additional checks
> > > and balances and prevent the driver from degenerating into an Intel-only
> > > show.  A number of things really irk me:
> > 
> > I don't have anything against this but at the same time I'm afraid it
> > might lead to a situation where the Thunderbolt driver evolution gets
> > stopped into its tracks because of unnecessary fighting over each patch
> > and change which does not benefit Linux kernel in general.
> 
> I think we have enough maintainers in this subsystem:
> 
>   Andreas - Apple hardware
>   Michael and me - Intel
>   Yehezkel - Microsoft
> 
> But I think we can make you a dedicated reviewer. This should make sure
> you get to review all the patches touching this subsystem.

That would be good.  But always remember, no one, not even a maintainer,
is there as a "gatekeeper".  Everyone can be routed around, or
accidentally forgotten to be cc:ed or patches can come in from other
subsystems as needed.

So adding more reviewers is always great, but it's never a "requirement"
that all people have to review everything before things are merged.

> This is especially important when a random Intel (well, or Apple)
> engineer submits a patch, say fixing a typo in a comment of some data
> structure. There is no point starting to demand that the specific
> register meaning needs to be disclosed. I've said this before but I or
> any other Intel engineer do not have any power over when the spec is
> released or any other related matter (like disclosing registers) and I
> really don't want that every single patch review starts with demanding
> people to disclose something extra. After all they are just trying to
> improve the driver which is good for Linux.

Well said, this is a tough area when dealing with both undocumented
hardware combined with a spec that is not public.  Everyone's trying to
do their best so we should always assume that first.

thanks,

greg k-h
