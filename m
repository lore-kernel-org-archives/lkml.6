Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD47CECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5836C20838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCEGXGdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5836C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJUPbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 11:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeJUPbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 11:31:45 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4350F20838;
        Sun, 21 Oct 2018 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540106303;
        bh=mSAHYn/zHAAWWTdLaXYO7JWGwlsVyHZyiRQnIUb7hmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCEGXGdk3vvBzl1V6mHSsWack0hARUFI7M9QG4g4B1qXy9vdu8c1XQk42LCNABfhA
         pMfZ9acXd8HdIT2YSQN+pRb2my7R8OSHCzSD3JYf1NryhHWQO5ctwxx6KKwS8MFNUJ
         lOAwl9BzsbayySJITD4HYzsJrV1cIcjCaSoRhRBw=
Date:   Sun, 21 Oct 2018 09:18:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org, mishi@linux.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 5/7] Code of Conduct Interpretation:
 Put in the proper URL for the committee
Message-ID: <20181021071821.GD11176@kroah.com>
References: <20181020134908.GA32218@kroah.com>
 <20181020135058.GF32218@kroah.com>
 <CAMuHMdUR_7GgFL0wqh9AdEq=HWmxPB=HzarEgY5TeLo67+S1LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUR_7GgFL0wqh9AdEq=HWmxPB=HzarEgY5TeLo67+S1LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 09:01:57PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sat, Oct 20, 2018 at 3:53 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > There was a blank <URL> reference for how to find the Code of Conduct
> > Committee.  Fix that up by pointing it to the correct kernel.org website
> > page location.
> >
> > Acked-by: Chris Mason <clm@fb.com>
> > Acked-by: Olof Johansson <olof@lixom.net>
> > Acked-by: Theodore Ts'o <tytso@mit.edu>
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/process/code-of-conduct-interpretation.rst
> > +++ b/Documentation/process/code-of-conduct-interpretation.rst
> > @@ -123,8 +123,9 @@ Enforcement
> >
> >  The address listed in the Code of Conduct goes to the Code of Conduct
> >  Committee.  The exact members receiving these emails at any given time
> > -are listed at <URL>.  Members can not access reports made before they
> > -joined or after they have left the committee.
> > +are listed at https://kernel.org/code-of-conduct.html.  Members can not
> > +access reports made before they joined or after they have left the
> > +committee.
> 
> This seems to be the wrong URL? It just points to the CoC, not to the TAB
> members.

The information at that web page will be updatd "soon" with the
information about the committee.  Please give us a few more days for
this, as we are all traveling at the moment...

thanks,

greg k-h
