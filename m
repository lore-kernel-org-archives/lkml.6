Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B23ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B52098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605B52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeISPyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:54:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:49727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeISPyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:54:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 03:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="258525353"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 19 Sep 2018 03:16:43 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Sep 2018 13:16:43 +0300
Date:   Wed, 19 Sep 2018 13:16:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andreas Noever <andreas.noever@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Jamet <michael.jamet@intel.com>, YehezkelShB@gmail.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of
 thunderbolt
Message-ID: <20180919101642.GU14465@lahna.fi.intel.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
 <20180910093333.GI14465@lahna.fi.intel.com>
 <20180913085826.GC14465@lahna.fi.intel.com>
 <CAMxnaaXbkWysZ2JbPTL7gmhq_MS5Ba1PJrzsXndjodH4X9WJOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMxnaaXbkWysZ2JbPTL7gmhq_MS5Ba1PJrzsXndjodH4X9WJOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:16AM +0200, Andreas Noever wrote:
> On Thu, Sep 13, 2018 at 11:00 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Sep 10, 2018 at 12:33:33PM +0300, Mika Westerberg wrote:
> > > Hi Lukas,
> > >
> > > I'm including Greg here in case I've done something wrong as a maintainer.
> > > Since I've only maintained Thunderbolt quite short time, it may be that
> > > I've done mistakes but certainly I did not deliberately try to make life of
> > > people developing this for older Apple systems harder.
> >
> > Greg did not yell at me (yet) so I guess I'm doing OK :)
> >
> > > On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> > > > Andreas Noever has let it be known off-list already a while ago that he
> > > > currently cannot spare as much time for Thunderbolt development as he'd
> > > > like.  As a result the driver's development has become dominated by
> > > > Intel.
> > >
> > > I was not aware of this. Althought Andreas has not commented much
> > > lately, I thought he is still looking after our changes. I hope he still
> > > is :)
> > >
> > > > I would like to step up as co-maintainer to provide additional checks
> > > > and balances and prevent the driver from degenerating into an Intel-only
> > > > show.  A number of things really irk me:
> > >
> > > I don't have anything against this but at the same time I'm afraid it
> > > might lead to a situation where the Thunderbolt driver evolution gets
> > > stopped into its tracks because of unnecessary fighting over each patch
> > > and change which does not benefit Linux kernel in general.
> >
> > I think we have enough maintainers in this subsystem:
> As mentioned by Lukas I'm currently quite preoccupied with other commitments
> and have not done much more than skimming the incoming patches (especially
> those touching the Intel part - as I trust you know what you are doing there :))
> If there is concern over too many maintainers then please give my spot to Lukas.
> Since I no longer use my MacBook regularly my ability to effectively
> test stuff is
> quite limited anyways.
> 
> Thanks,
> Andreas
> 
> 
> >   Andreas - Apple hardware
> >   Michael and me - Intel
> >   Yehezkel - Microsoft
> >
> > But I think we can make you a dedicated reviewer. This should make sure
> > you get to review all the patches touching this subsystem.
> >
> > However, first I would like to get confirmation from Andreas that he
> > approves this.
> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>

Thanks for the comments Andreas! Then either way is fine by me :)
