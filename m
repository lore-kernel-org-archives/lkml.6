Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B2C2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K683UwnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B2C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeJKEkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeJKEkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:40:00 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0482082B;
        Wed, 10 Oct 2018 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539206162;
        bh=aEqmtlqF6qF0j6CMs1nTA+fpxlGMj5K0eBeQs++i/Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K683UwnOV2V7k1hpDsJHaBDrOWuyb0VGQ8HNW0IEB/W1eCXQb7QbHyp7W7r6LtwP0
         19qaOzgDrvS+VqbmPa7zD6RDrIIoAAmZcANiFnyXHDtLOXXHtI3M55o8qqtL4xYT1J
         nbN7MZEz41Nwl29kWz4hhxKSCWOybnM7rLx6gCp4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B9F3D142D18; Wed, 10 Oct 2018 18:15:47 -0300 (-03)
Date:   Wed, 10 Oct 2018 18:15:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181010211547.GB9853@kernel.org>
References: <20181007085102.17795-1-geert@linux-m68k.org>
 <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 10, 2018 at 01:55:04PM -0700, Frank Rowand escreveu:
> On 10/07/18 01:51, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
> > 
> > Avoid any ambiguity by removing the list, to ensure "a harassment-free
> > experience for everyone", period.
> > 
> > Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > The use of "race" may also conflict with the United Nation's views on
> > this matter, cfr. e.g. the UNESCO's "Four statements on the race
> > question"[1][2] and "Declaration on Race and Racial Prejudice"[3].
> > 
> > [1] https://en.wikipedia.org/wiki/The_Race_Question
> > [2] http://unesdoc.unesco.org/images/0012/001229/122962eo.pdf
> > [3] http://portal.unesco.org/en/ev.php-URL_ID=13161&URL_DO=DO_TOPIC&URL_SECTION=201.html
> > ---
> >  Documentation/process/code-of-conduct.rst | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
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
> The words removed by this patch are a political statement.  They do not belong
> in the document.
> 
> Acked-by: Frank Rowand <frowand.list@gmail.com>

Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>

- Arnaldo
