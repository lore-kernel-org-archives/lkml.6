Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782BAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C4C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZlkXAqrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C4C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJKKhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:37:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D9CwMkOGmUw6ahuuNFqK0KoMkMwEnepaqYOT7W4LPDY=; b=ZlkXAqrKzZuDbJmhYUFu50Tf9
        ALBKMrY+ftclczPfjIzic132kzlPMNnM7HFYrP+cLEFRAEMzTRJ9jHXQZh6vgNat21UmIpJ+2a4ie
        VQCDTsWv7WPt/La7sOSasJXTOyzeixekpK+t+vf9QJAmEQK4iZd6khp5yEyfhR5BjlIL1zhx+abwp
        d1xeC9+aZyhBVNfNjrwBl8Ing8Ea3nqaR1b0GCCSTi47/pykbME+BBKvqnVVgX8aVrpYq6s8Cngra
        ADn3rTUVpI14Z+OdAh5Uln8tN7MG5XnEt9qzygfXNP0jBo8tHjqDBDhu7n266NsfsjxfukRLdSXLm
        gm+z9k0lw==;
Received: from 177.43.144.224.dynamic.adsl.gvt.net.br ([177.43.144.224] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAROI-0001p3-UK; Thu, 11 Oct 2018 03:11:59 +0000
Date:   Thu, 11 Oct 2018 00:11:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] code of conduct fixes
Message-ID: <20181011001155.4ed20a52@coco.lan>
In-Reply-To: <1539216001.3462.1.camel@HansenPartnership.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
        <87efcxtmhf.fsf@xmission.com>
        <1539216001.3462.1.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Oct 2018 17:00:01 -0700
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> On Wed, 2018-10-10 at 18:23 -0500, Eric W. Biederman wrote:
> > James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> >   
> > > Resend to show accumulated tags and also to add a third patch
> > > listing the TAB as the reporting point as a few people seem to
> > > want.  If it gets the same level of support, I'll send it in with
> > > the other two.  
> > 
> > 
> > There is also:
> >   
> > > Our Responsibilities
> > > ====================
> > > 
> > > Maintainers are responsible for clarifying the standards of
> > > acceptable behavior and are expected to take appropriate and fair
> > > corrective action in response to any instances of unacceptable
> > > behavior.
> > > 
> > > Maintainers have the right and responsibility to remove, edit, or
> > > reject comments, commits, code, wiki edits, issues, and other
> > > contributions that are not aligned to this Code of Conduct, or to
> > > ban temporarily or permanently any contributor for other behaviors
> > > that they deem inappropriate, threatening, offensive, or harmful.  
> > 
> > Which is very problematic.
> > a) In append only logs like git we can not edit history.
> >    Making it a mainters responsibility to edit the history, to do the
> >    impossible is a problem.  
> 
> Git isn't entirely append only.  We can do limited history changes by
> rebasing.  Some trees do that quite a lot.  Github has this same
> history problem, so certainly we could amend commits before they hit
> Linus' tree but after that it isn't "fair corrective action" because it
> can't be done technically.

We should discuss more about this during MS/KS. Even before pushing upstream, 
it is a problem on some subsytems, as sub-maintainers and driver developers
may have issues with rebases.

I'm sure maintainers will do rebases if they think it is worth enough,
provided that it won't break things, but rebases should be the exception,
not the rule.

So, I would add on a FAQ (or at the CoC itself) that maintainers won't
do git rebases due to CoC. So, people complaining about CoC violations
inside patches should reply ASAP, in order for the maintainer to be
able to see it *before* merging the patch on his tree.

> > Overall in the discussions I have heard people talking about
> > persuading, educating, and not feeding trolls.   Nowhere have I heard
> > people talking about policing the community which I understand that
> > responsiblity section to be talking about.  
> 
> Policing is the wrong word: no-one has policing power.  However, we
> still have persuasive power.  The point is there's a reasonable line
> you can tread as a persuader.  Some very few people simply won't
> listen, but we have, actually, excluded them before without a code of
> conduct.

Yes, but this particular CoC assumes that maintainer has policing power.

This needs to be reviewed. For now, I would get rid of

	"have the right and responsibility"

in favor of something lighter:

	"should"

Later we may need something else. 

> 
> > Increasingly I am getting the feeling that this document does not the
> > linux development community.  Perhaps a revert and trying to come up
> > with better language from scratch would be better.  
> 
> I'm open to pushing a revert instead. However, I think this one is
> workable too if interpreted reasonably.

Agreed.

> > I don't know how to rephrase that reponsibility section but if we
> > don't go with the revert something looks like it need sot be done
> > there.  
> 
> That is an argument for keeping what we have ... these things are
> difficult to write.

A simple change like the above (plus this /3 patch series) should work for
now, but, IMHO, this CoC model is too bound to a centralized web-based
site-hosted development model, lacking ways for it to work with
de-centralized e-mail based workflows.

For next Kernels, we may need to either replace it by something else
or do more changes on it, in order for it to make sense with our
workflow.

Thanks,
Mauro
