Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEF52080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WD6+eFoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEF52080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeKRXYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 18:24:09 -0500
Received: from casper.infradead.org ([85.118.1.10]:60454 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKRXYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 18:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BE0OTLBHMNGZbynVK1HUaCVTmTsCUQDzO5jMFbOvL6Y=; b=WD6+eFoVY4jFKSLJaX/FK4f9qU
        vbXHJV0hjey2sF+7S9XhGeyzlxfnJHnNGvkbIuY6ElukhCJbtbyJ7SBNuyyVv7/hL8h/B5mbV+ut+
        BtDd8TyeRraqRP5VPoUd92UeltlV/89+nFO+kivDjIYv1PxDnpSrPH0Kew16/v49qIm9El7osyZMj
        aPZpt5iRA+4J9HLPNO/R4BeNgSnKpW720Qxs7ILAAAaYBVTmCQcL4kgr51JE8a69MiO/kezSWvRLu
        obXQc5tE1CQZ0n9SiItrxQcdHr7wnskFJiBYjZaWJUVmT8FA6dByh5+Oawb0Qb28g4j/5Kk98KbEJ
        /mxM5lpw==;
Received: from 177.17.134.91.dynamic.adsl.gvt.net.br ([177.17.134.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOMjZ-0001oF-9a; Sun, 18 Nov 2018 13:03:39 +0000
Date:   Sun, 18 Nov 2018 11:03:24 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     rodrigo.vivi@gmail.com,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181118110324.543edbd8@coco.lan>
In-Reply-To: <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
        <20181115061036.1575223d@silica.lan>
        <20181115162008.GO3759@mtr-leonro.mtl.com>
        <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
        <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 16 Nov 2018 15:44:45 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> On Fri, Nov 16, 2018 at 12:37 PM Rodrigo Vivi <rodrigo.vivi@gmail.com> wrote:
> >
> > On Thu, Nov 15, 2018 at 8:38 AM Leon Romanovsky <leon@kernel.org> wrote:  
> > >
> > > On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:  
> > > > Em Thu, 15 Nov 2018 09:03:11 +0100
> > > > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> > > >  
> > > > > Hi Dan,
> > > > >
> > > > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:  
> > > > > > Document the basic policies of the libnvdimm subsystem and provide a
> > > > > > first example of a Subsystem Profile for others to duplicate and edit.
> > > > > >
> > > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > > >
> > > > > Thanks for your patch!
> > > > >  
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/nvdimm/subsystem-profile.rst  
> > > > >  
> > > > > > +Trusted Reviewers
> > > > > > +-----------------
> > > > > > +Johannes Thumshirn
> > > > > > +Toshi Kani
> > > > > > +Jeff Moyer
> > > > > > +Robert Elliott  
> > > > >
> > > > > Don't you want to add email addresses?
> > > > > Only the first one is listed in MAINTAINERS.  
> > > >
> > > > IMO, it makes sense to have their e-mails here, in a way that it could
> > > > easily be parsed by get_maintainers.pl.  
> > >
> > > I personally think that list of "trusted reviewers" makes more harm than
> > > good. It creates unneeded negative feelings to those who wanted to be in
> > > this list, but for any reason they don't. Those reviewers will feel
> > > "untrusted".  
> >
> > I'd like to +1 on this concern here. Besides leaving all the other
> > people demotivated.  
> 
> Yes, that's a valid concern, I overlooked that unfortunate interpretation.
> 
> >
> > A small group of trusted reviewers doesn't scale. People will get overloaded.
> > Or you won't be able to enforce that all patches need to get Reviews.
> >
> > Reviews should be coming from everywhere and commiters and maintainers
> > deciding on what to trust or re-review.
> >
> > Also the list is hard to maintain and keep the lists updated.  
> 
> I understand the concern, and as I saw feedback come in I realized
> there were more people that I would add to that reviewer list for
> libnvdimm.
> 
> Stepping back the end goal is to have an initial list of recommended
> people to follow up with directly to seek a second opinion, or help in
> cases where a contributor otherwise needs some direction / engagement
> that they are not readily receiving from the maintainer. Typically
> someone just lurks on the mailing list for a few weeks to get a feel
> for who the usual suspects are in the subsystem, but for a new
> contributor identifying those individuals may be difficult.
> 
> One of the contributing factors of lack of response to a patchset is
> that they are sent with the implicit expectation that the maintainer
> will get to eventually, and typically other people feel content to sit
> back and watch. If instead a contributor sent a direct mail to a
> "trusted reviewer" saying, "Hey, Alice, Bob seems busy can you help me
> out?" that seems more likely to rope in additional review help.

Hmm.. Perhaps the subsystem profile should point to IRC channels if any?
Several subsystems use them in order to provide newbies some directions
and to discuss other development issues.

Thanks,
Mauro
