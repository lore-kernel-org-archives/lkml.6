Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E11AC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16D420875
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 03:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wuNHmVND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16D420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJGKjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 06:39:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56446 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbeJGKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 06:39:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C1F778EE2BB;
        Sat,  6 Oct 2018 20:33:31 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0-wkG4bgtlUm; Sat,  6 Oct 2018 20:33:31 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 52A728EE2AF;
        Sat,  6 Oct 2018 20:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538883211;
        bh=sJ0Bsj9Mpkj8G4mvp3UOEiovhOoTp8X3y0JTutaZ+eQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wuNHmVNDKn4o6dVgf0rrGaX9EiXgaMsrqNo2NISudTSyRjA8mfKNviFl6DqL+tTV2
         cPZ/4GeI8zadsbZ2LgdB6rdkTI4QNw/WKVAaBLWCQ+vokn/R6bxYPS5dAntBLB5Jx6
         rqb5pf0zDpDcvAOaYdn62Gl5HEZNYwa7MUpkPPgA=
Message-ID: <1538883209.4088.14.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tim.Bird@sony.com, ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 06 Oct 2018 20:33:29 -0700
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <1538861851.4088.7.camel@HansenPartnership.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-06 at 21:43 +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: James Bottomley
> > 
> > Significant concern has been expressed about the responsibilities
> > outlined in the enforcement clause of the new code of
> > conduct.  Since there is concern that this becomes binding on the
> > release of the 4.19 kernel, strip the enforcement clauses to give
> > the community time to consider and debate how this should be
> > handled.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > ---
> >  Documentation/process/code-of-conduct.rst | 15 ---------------
> >  1 file changed, 15 deletions(-)
> > 
> > diff --git a/Documentation/process/code-of-conduct.rst
> > b/Documentation/process/code-of-conduct.rst
> > index aa40e34e7785..4dd90987305b 100644
> > --- a/Documentation/process/code-of-conduct.rst
> > +++ b/Documentation/process/code-of-conduct.rst
> > @@ -59,21 +59,6 @@ address, posting via an official social media
> > account, or
> > acting as an appointed
> >  representative at an online or offline event. Representation of a
> > project may
> > be
> >  further defined and clarified by project maintainers.
> > 
> > -Enforcement
> > -===========
> > -
> > -Instances of abusive, harassing, or otherwise unacceptable
> > behavior may be
> > -reported by contacting the Technical Advisory Board (TAB) at
> > -<tab@lists.linux-foundation.org>. All complaints will be reviewed
> > and
> > -investigated and will result in a response that is deemed
> > necessary and
> > -appropriate to the circumstances. The TAB is obligated to maintain
> > -confidentiality with regard to the reporter of an
> > incident.  Further details of
> > -specific enforcement policies may be posted separately.
> 
> I think it's OK to leave the above section, as it doesn't speak to
> enforcement, but rather is just a set of reporting instructions,
> with an assurance of confidentiality.  This seems to me not to be
> the objectionable part of this section.
> (IOW, I would omit this removal from the patch).

So I did think about that, but it struck me that with both paragraphs
removed, the current CoC is very similar to the status quo: namely
every subsystem handles their own issues and that's formalised by the
"Our Responsibilities" section.  That also makes me think that whether
we want a centralised channel of reporting or enforcement and what it
should be also ought to be part of the debate.  The TAB was created to
channel community technical input into the Linux Foundation.  That's
not to say it can't provide the reporting and arbitration structure,
but if we're going to do it right we should debate the expansion of its
duties (and powers).

I happen to think that the fact that the TAB cannot compel where it
cannot persuade is a huge strength of the system because it means
there's no power structure to subvert if someone were interested in
using it to try to impose their own viewpoint on the community.  But
that's just my opinion and I did write the TAB charter, so I'm probably
biased in this viewpoint.

James


> If the next part is indeed removed, then maybe the section
> needs to be renamed?
>  -- Tim
> 
> > -
> > -Maintainers who do not follow or enforce the Code of Conduct in
> > good faith
> > may
> > -face temporary or permanent repercussions as determined by other
> > members of the
> > -project’s leadership.
> > -
> >  Attribution
> >  ===========
> 
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

