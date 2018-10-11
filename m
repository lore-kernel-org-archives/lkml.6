Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1262085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bncug0Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1262085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJKPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:37:32 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18116 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKPhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:37:32 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2549D40604;
        Thu, 11 Oct 2018 10:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received; s=mail20150812; t=1539245476; bh=Hw1xztMJC8
        F8SLn8ytUkQAJjnYad6cX+Qu8HNl35SWQ=; b=bncug0AdjuB/VNsWX+bStO6Wbi
        VY4Lskp0zOKSj0aU84VTc7dDZ8lbrDbIu5VzdkXuHtqeKIBlNmVGBaBSHGz9dyDn
        jx65zHhOj1ouhtwMAm5zv2+euyXPcSQIJy/TXfK8kodVctQzMPXlwoFNMAVxFHE6
        1l+Ek59eMSCFEg+XthGUjPPivCc08rNZ3xw8v3PKiMV5CigM997MfRrljbDd2r7S
        3bsVaBv1NhyyydGLZplvM+DNgTT6C45tb0kW4yxnsH1edoJm6ZJm0sWvuQkC0Q1b
        DbdW7mZmPwBMYcNfDr90ynMoEGwkyZk3ByVtUbEVg0TLViM1UCfs62ritB1w==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 3QQdLi_b8CkO; Thu, 11 Oct 2018 10:11:16 +0200 (CEST)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list of discrimination factors
Date:   Thu, 11 Oct 2018 10:12:37 +0200
Message-ID: <2692613.2cTL0iPTo0@siriux>
In-Reply-To: <20181010221611.GA5711@localhost>
References: <20181007085102.17795-1-geert@linux-m68k.org> <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com> <20181010221611.GA5711@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2018, 15:16:12 schrieb Josh Triplett:
> On Wed, Oct 10, 2018 at 01:55:04PM -0700, Frank Rowand wrote:
> > On 10/07/18 01:51, Geert Uytterhoeven wrote:
> > > Providing an explicit list of discrimination factors may give the false
> > > impression that discrimination based on other unlisted factors would be
> > > allowed.
> > > 
> > > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > > experience for everyone", period.
> [...]
> > > diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> > > index ab7c24b5478c6b30..e472c9f86ff00b34 100644
> > > --- a/Documentation/process/code-of-conduct.rst
> > > +++ b/Documentation/process/code-of-conduct.rst
> > > @@ -6,10 +6,7 @@ Our Pledge
> > >  
> > >  In the interest of fostering an open and welcoming environment, we as
> > >  contributors and maintainers pledge to making participation in our project and
> > > -our community a harassment-free experience for everyone, regardless of age, body
> > > -size, disability, ethnicity, sex characteristics, gender identity and
> > > -expression, level of experience, education, socio-economic status, nationality,
> > > -personal appearance, race, religion, or sexual identity and orientation.
> > > +our community a harassment-free experience for everyone.
> > >  
> > >  Our Standards
> > >  =============
> > > 
> > 
> > 
> > The words removed by this patch are a political statement.
> 
> Choosing not to say those words is a political statement.

No. If there's an implicit statement it's "No politics here." 

The patch makes the sentence and its message completely neutral. And what can be more inclusive and encompassing than "everyone"?

> 
> See the original commit message for the code of conduct: "Explicit
> guidelines have demonstrated success in other projects and other areas
> of the kernel."
> 

Which does not mean that this is generally true. I guess you know the difference between deduction and induction.

> And see the FAQ entry at https://www.contributor-covenant.org/faq for
> "The Contributor Covenant explicitly lists a set of protected classes;

"protected classes" is imo very unfortunate wording and very close to "privileged classes". I bet this won't go down well with lots of people, especially in the eastern hemisphere.

Reminds me of "All animals are equal. But some animals are more equal than others."[1]

History has shown were this leads to.

> does this make it acceptable to discriminate or make others feel
> unwelcome based on other factors?" (I wrote that FAQ entry and submitted
> it upstream, where it was enthusiastically merged.)
> 

Not really surprising.


So long!


Rainer Fiebig


[1] https://en.wikipedia.org/wiki/Animal_Farm

-- 
The truth always turns out to be simpler than you thought.
Richard Feynman
