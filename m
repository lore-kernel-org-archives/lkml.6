Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639720883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjZ/Tmx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4639720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeKJKDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeKJKDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:03:18 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF7120840;
        Sat, 10 Nov 2018 00:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541809219;
        bh=AIfFE52ousi4DsC+cAxgSuTytf1JRupiYZZJn0xRfNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjZ/Tmx3jn/B1X9F+Ob0Z1LKyLUm7HrIKEJ+s7QBaDQ5QYgbhMpa/8F3ORzdKN2+N
         KQa1NbvwbRjmTZdZBpT1MVRX4bkOms58NrgPiCWWmimGEjCESRdi6p9PGMhLbHBHf5
         FVsUjUnPDZvQ8EuNQ30BDnul9sKWUl31yDhKPb7U=
Date:   Fri, 9 Nov 2018 16:20:18 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     festevam@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Victor Colombo <victorcolombo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
Message-ID: <20181110002018.GA3938@kroah.com>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br>
 <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
 <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:19:52PM -0200, Matheus Tavares Bernardino wrote:
> On Fri, Nov 9, 2018 at 8:13 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Matheus,
> >
> 
> Hi, Fabio
> 
> > On Fri, Nov 9, 2018 at 8:01 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > >
> > > This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
> > > which solves the checkpatch.pl warning:
> > > "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> > >
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > ---
> > >  drivers/staging/iio/resolver/ad2s90.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > > index 949ff55ac6b0..f439da721df8 100644
> > > --- a/drivers/staging/iio/resolver/ad2s90.c
> > > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> >
> > This should be:
> > // SPDX-License-Identifier: GPL-2.0
> 
> Hm, but it seems that the identifier "GPL-2.0" is deprecated, look:
> https://spdx.org/licenses/GPL-2.0.html. It has been updated to
> "GPL-2.0-only" in license list v3
> (https://spdx.org/licenses/GPL-2.0-only.html). Is there some other
> reason to use the deprecated "GPL-2.0" that I'm not aware of?

Yes, please read the in-kernel documentation for all of this at:
	Documentation/process/license-rules.rst

Long story short, we started the adding of these tags to the kernel
before the crazyness of the "-only" markings for GPL in spdx.  Let's
keep it this way for now, if we ever get the whole kernel finished, then
we can revisit the markings and maybe do a wholesale conversion, if it's
really needed.

thanks,

greg k-h
