Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85929C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244BB2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ktZLyS7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJHVjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:39:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41300 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:39:31 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 892741AEC;
        Mon,  8 Oct 2018 16:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539008849;
        bh=CDl/fZk67snmXNmXYG5dr50kS7IlWeEkpIX/r9S5er8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktZLyS7eFEBts573Z5XnYTViUu3M3VJi6cYZ1eX4DQ7ahh1/kClXjECm3JYPiE9uw
         2StCcOmLKj7+e/DMnLHmfFrcK0xb/qxJHPK8m10JzOIlyxz0AKhjw0XbmwRYltzMt0
         R0tndp0I3vArbXyQLr9SDvsND5qC9M6cH5Qs+las=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tim.Bird@sony.com
Cc:     josh@joshtriplett.org, James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list of discrimination factors
Date:   Mon, 08 Oct 2018 17:27:50 +0300
Message-ID: <2170645.tuLgNU61gi@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com>
References: <20181007085102.17795-1-geert@linux-m68k.org> <20181008022931.GB30346@localhost> <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Monday, 8 October 2018 17:12:05 EEST Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: Josh Triplett
> > On Sun, Oct 07, 2018 at 08:18:26PM +0300, Laurent Pinchart wrote:
> >> On Sunday, 7 October 2018 14:35:14 EEST Josh Triplett wrote:
> >>> On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> >>>> Providing an explicit list of discrimination factors may give the
> >>>> false impression that discrimination based on other unlisted factors
> >>>> would be allowed.
> >>>> 
> >>>> Avoid any ambiguity by removing the list, to ensure "a harassment-
> >>>> free experience for everyone", period.
> >>> 
> >>> I would suggest reading the commit message that added this in the
> >>> first place. "Explicit guidelines have demonstrated success in other
> >>> projects and other areas of the kernel." See also various comparisons
> >>> of codes of conduct, which make the same point. The point of this list
> >>> is precisely to serve as one such explicit guideline; removing it
> >>> would rather defeat the purpose.
> >>> 
> >>> In any case, this is not the appropriate place for such patches, any
> >>> more than it's the place for patches to the GPL.
> >> 
> >> So what's an appropriate place to discuss the changes that we would
> >> like, *together*, to make to the current document and propose upstream ?
> > 
> > I didn't say "not the appropriate place to discuss" (ksummit-discuss is
> > not ideal but we don't currently have somewhere better), I said "not the
> > appropriate place for such patches".
> > 
> > The Linux kernel is by no means the only project using the Contributor
> > Covenant. In general, we don't encourage people working on significant
> > changes to the Linux kernel to work in private for an extended period
> > and only pop up when "done"; rather, we encourage people to start
> > conversations early and include others in the design. Along the same
> > lines, I'd suggest that patches or ideas for patches belong upstream.
> > For instance, the idea of clarifying that email addresses already used
> > on a public mailing list don't count as "private information" seems like
> > a perfectly reasonable suggestion, and one that other projects would
> > benefit from as well.
> 
> So I raised this issue with upstream about 2 weeks ago, and here is my
> experience:
> 1) I suggested that the email clarification could be put into the covenant
> itself, or in a supporting FAQ.
> 2) The project maintainer (Coraline Ada Ehmke) was pleasant and supportive
> of changes to enhance the document, and said either approach would be fine.
> 3) I noticed that there was a FAQ in progress of being created.
> 4) After thinking about it, I decided that I didn't want to alter the
> language of the covenant, because I didn't want to dilute the expression of
> a need to get permission when revealing private information.
> 
> My own opinion is that putting clarifying language in a FAQ is sufficient.
> So I made the following recommendation for the (not yet included upstream)
> FAQ:
> 
> Q: Does the prohibition on publishing private information include email
> addresses sent to a public list? A: No. Information that has voluntarily
> been published to a public location does not fall under the category of
> private information. Such public information may be used within the context
> of the project according to project norms (such as in commit meta-data in
> code repositories), without that constituting a breach of the CoC.
> 
> You can see the history of discussion in these two issues, online:
> https://github.com/ContributorCovenant/contributor_covenant/issues/590
> https://github.com/ContributorCovenant/contributor_covenant/issues/575
> 
> I hesitated to post these, because a formatting error in one of the posts
> makes me look a bit dumb. :-)
> 
> I don't know what progress is being made adopting the FAQ, but Coraline
> seems very supportive, and I've told here that I will come back and help
> with it if it stalls.
> 
> Honestly, I believe Linux will adopt its own FAQ or some similar document,
> so with the Contributor Covenant adopting the clarification as a separate
> document, I don't know if Linux would inherit it (ie include the Covenant
> FAQ in our source tree).  However, I think that the existence of this email
> clarification in the upstream FAQ would still have a beneficial effect for
> all downstream users of the covenant, so I view this as a useful exercise.

The main argument I have heard against amending the code of conduct document 
itself is that a fork would make it more complicated for project members to 
understand the expectations, in a similar fashion than the fragmentation 
created by license forks. If we end up having our own FAQ, which would need to 
be considered in combination with the main document to understand its impact, 
doesn't that create the same problem ?

-- 
Regards,

Laurent Pinchart



