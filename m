Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9202086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9202086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeJKFkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:40:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60311 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:40:37 -0400
Received: from localhost (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CFF3B240002;
        Wed, 10 Oct 2018 22:16:20 +0000 (UTC)
Date:   Wed, 10 Oct 2018 15:16:12 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181010221611.GA5711@localhost>
References: <20181007085102.17795-1-geert@linux-m68k.org>
 <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:55:04PM -0700, Frank Rowand wrote:
> On 10/07/18 01:51, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
> > 
> > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > experience for everyone", period.
[...]
> > diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> > index ab7c24b5478c6b30..e472c9f86ff00b34 100644
> > --- a/Documentation/process/code-of-conduct.rst
> > +++ b/Documentation/process/code-of-conduct.rst
> > @@ -6,10 +6,7 @@ Our Pledge
> >  
> >  In the interest of fostering an open and welcoming environment, we as
> >  contributors and maintainers pledge to making participation in our project and
> > -our community a harassment-free experience for everyone, regardless of age, body
> > -size, disability, ethnicity, sex characteristics, gender identity and
> > -expression, level of experience, education, socio-economic status, nationality,
> > -personal appearance, race, religion, or sexual identity and orientation.
> > +our community a harassment-free experience for everyone.
> >  
> >  Our Standards
> >  =============
> > 
> 
> 
> The words removed by this patch are a political statement.

Choosing not to say those words is a political statement.

See the original commit message for the code of conduct: "Explicit
guidelines have demonstrated success in other projects and other areas
of the kernel."

And see the FAQ entry at https://www.contributor-covenant.org/faq for
"The Contributor Covenant explicitly lists a set of protected classes;
does this make it acceptable to discriminate or make others feel
unwelcome based on other factors?" (I wrote that FAQ entry and submitted
it upstream, where it was enthusiastically merged.)
