Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D364C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D62186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549470333;
	bh=gBJo2qq6TmdmoK4ipaybcysTmY+mqn8LNmDGe47UC10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=soHajjMudJa/bd5Ad4neaWI480kzA5ZjIdxQiDoouHo1zELBuwsAHFuk3oUDhPEhk
	 /CTZehGzULG5jbDdd0HnYKX03tv29+zjQCSk8YXBck3blfFEOczthMxdI3cqw3Op7u
	 cHdqAqVUoYV+BAhNhlvPvXve3dlbL89x2xM57ONQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfBFQZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbfBFQZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:25:31 -0500
Received: from localhost (mobile-166-177-186-135.mycingular.net [166.177.186.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3082175B;
        Wed,  6 Feb 2019 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549470330;
        bh=gBJo2qq6TmdmoK4ipaybcysTmY+mqn8LNmDGe47UC10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOM4+8gti2WqiMWUZi7L90YvEtNZu0vlF7/6PNR+zpqAJPiizCL06uhlIU8SnoZ0C
         5+nx/2DcMDhQEoF/tsa0ioSCCgnz+6RfzwTySrPnaJg++b7jfQUcJf/G5BCZY6/4tr
         bZi1/oADGSbMitbP/+0MIpUqEzQv4gDfWbUgf8cY=
Date:   Wed, 6 Feb 2019 17:25:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        Forest Bond <forest@alittletooquiet.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
Message-ID: <20190206162524.GA22989@kroah.com>
References: <20190205150620.GA17522@nishad>
 <20190205184431.GD22198@kroah.com>
 <7771453cf380ce43d906f6648edecd8b58fec38a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7771453cf380ce43d906f6648edecd8b58fec38a.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:59:40AM -0800, Joe Perches wrote:
> On Tue, 2019-02-05 at 19:44 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 05, 2019 at 08:36:24PM +0530, Nishad Kamdar wrote:
> > > This patch corrects the style for SPDX license Identifier in mac.h
> > > by using "/* */" in place of "//" as per Linux kernel licensing rules.
> > > Issue found by checkpatch.
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > >  drivers/staging/vt6656/mac.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> > > index 94e700fcd0b6..75166020f7c6 100644
> > > --- a/drivers/staging/vt6656/mac.h
> > > +++ b/drivers/staging/vt6656/mac.h
> > > @@ -1,5 +1,5 @@
> > > -// SPDX-License-Identifier: GPL-2.0+
> > > -/*
> > > +/* SPDX-License-Identifier: GPL-2.0+
> > 
> > Should really be:
> > 
> > /* SPDX-License-Identifier: GPL-2.0+ */
> 
> There's a fair number of style inconsistencies in the kernel
> sources for that already.
> 
> ~8% of the .h files that have an 'SPDX-License-Identifier:'
> don't use the recommended style.
> 
> $ git grep -h "SPDX-License" -- '*.h' | \
>   perl -p -e 's@Identifier:.*\*/*@Identifier: ... */@; s@Identifier: [^\.].*@Identifier:@' | \
>   sort | uniq -c | sort -rn
>    8506 /* SPDX-License-Identifier: ... */
>     593 // SPDX-License-Identifier:
>     154 /* SPDX-License-Identifier:
>      53  * SPDX-License-Identifier:
>       1  * SPDX-License-Identifier:	GPL-2.0
>       1 //SPDX-License-Identifier:
>       1 /*  SPDX-License-Identifier: ... */

Then let's fix them, the documentation says what the correct format is,
there's no reason we can't actually follow what is written...
