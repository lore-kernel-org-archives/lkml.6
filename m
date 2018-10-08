Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F80C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7A20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="AiL9lVlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D7A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJHVVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:21:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42794 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbeJHVVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:21:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0F10A8EE2EC;
        Mon,  8 Oct 2018 07:09:42 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LbVJgeciOwxf; Mon,  8 Oct 2018 07:09:41 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A8B528EE0FD;
        Mon,  8 Oct 2018 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539007781;
        bh=GMZAXrqnVXsIYCht1/Widbnw1WYYA976hmddRjwM2mc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AiL9lVlZK/uiO6yF5ai6iqC00J0fGNlVvJzJkUeV8+CpnUfL4JR8tWKJ9YDH5vjH2
         6j+Ct7WJyC7or2W/XuraXoKt6Gdin/jRs3k8hTXA1BzPIzC1od1yZ7YMaaNQ2+sWOz
         Qr5t8tR/2CRMCZN7bQvB79575OJQCDFFDKIns/wY=
Message-ID: <1539007780.4344.3.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tim.Bird@sony.com, ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 07:09:40 -0700
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80517411@USCULXMSG01.am.sony.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <1538861851.4088.7.camel@HansenPartnership.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
         <1538883209.4088.14.camel@HansenPartnership.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF80517411@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 13:51 +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: James Bottomley 
> > On Sat, 2018-10-06 at 21:43 +0000, Tim.Bird@sony.com wrote:
> > > > -----Original Message-----
> > > > From: James Bottomley
> > > > 
> > > > Significant concern has been expressed about the
> > > > responsibilities outlined in the enforcement clause of the new
> > > > code of conduct.  Since there is concern that this becomes
> > > > binding on the release of the 4.19 kernel, strip the
> > > > enforcement clauses to give the community time to consider and
> > > > debate how this should be handled.
> > > > 
> > > > Signed-off-by: James Bottomley
> > > > <James.Bottomley@HansenPartnership.com>
> > > > ---
> > > >  Documentation/process/code-of-conduct.rst | 15 ---------------
> > > >  1 file changed, 15 deletions(-)
> > > > 
> > > > diff --git a/Documentation/process/code-of-conduct.rst
> > > > b/Documentation/process/code-of-conduct.rst
> > > > index aa40e34e7785..4dd90987305b 100644
> > > > --- a/Documentation/process/code-of-conduct.rst
> > > > +++ b/Documentation/process/code-of-conduct.rst
> > > > @@ -59,21 +59,6 @@ address, posting via an official social
> > > > media account, or acting as an appointed representative at an
> > > > online or offline event. Representation of a project may be
> > > >  further defined and clarified by project maintainers.
> > > > 
> > > > -Enforcement
> > > > -===========
> > > > -
> > > > -Instances of abusive, harassing, or otherwise unacceptable
> > > > behavior may be
> > > > -reported by contacting the Technical Advisory Board (TAB) at
> > > > -<tab@lists.linux-foundation.org>. All complaints will be
> > > > reviewed and
> > > > -investigated and will result in a response that is deemed
> > > > necessary and
> > > > -appropriate to the circumstances. The TAB is obligated to
> > > > maintain
> > > > -confidentiality with regard to the reporter of an
> > > > incident.  Further details of
> > > > -specific enforcement policies may be posted separately.
> > > 
> > > I think it's OK to leave the above section, as it doesn't speak
> > > to enforcement, but rather is just a set of reporting
> > > instructions, with an assurance of confidentiality.  This seems
> > > to me not to be the objectionable part of this section.
> > > (IOW, I would omit this removal from the patch).
> > 
> > So I did think about that, but it struck me that with both
> > paragraphs removed, the current CoC is very similar to the status
> > quo: namely every subsystem handles their own issues and that's
> > formalised by the "Our Responsibilities" section.  That also makes
> > me think that whether we want a centralised channel of reporting or
> > enforcement and what it should be also ought to be part of the
> > debate.  The TAB was created to channel community technical input
> > into the Linux Foundation.  That's not to say it can't provide the
> > reporting and arbitration structure, but if we're going to do it
> > right we should debate the expansion of its duties (and powers).
> 
> When the Code of Conflict was adopted 3 years ago, we already created
> the central reporting mechanism, so I actually think leaving (ie
> including) the above paragraph is closer to the status quo.  I think
> it's the expanded powers and duties (or perception thereof) that are
> causing concern and I think debating those to clarify intent, and
> adopting changes as needed  to ameliorate concerns is worthwhile.

If we want to go back to the status quo, then a plain revert is the
patch series I should submit.

> I believe that in the vast majority of cases, the TAB will end up
> performing a mediator role to smooth hurt feelings and remind and
> encourage improved communication - very similar to what we've done in
> the past.  I really believe that bans will continue to be very few
> and far between, as they have been historically (I can only think of
> 3 in the past decade.)

That might very well be the position the discussion arrives at;
however, I really think making the process fully transparent this time
requires not prejudging the outcome.

James

