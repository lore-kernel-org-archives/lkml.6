Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47874C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA1D20840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA1D20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeJaPDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:03:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:25222
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbeJaPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:03:09 -0400
X-IronPort-AV: E=Sophos;i="5.54,447,1534802400"; 
   d="scan'208";a="283890510"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 07:06:26 +0100
Date:   Wed, 31 Oct 2018 07:06:25 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2] staging: vboxvideo: Remove
 unnecessary parentheses
In-Reply-To: <20181030231757.24ooubt25oykmgkt@smtp.gmail.com>
Message-ID: <alpine.DEB.2.21.1810310705530.4711@hadrien>
References: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com> <20181030092539.GA10009@kroah.com> <20181030231757.24ooubt25oykmgkt@smtp.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Oct 2018, Shayenne Moura wrote:

> On 10/30, Greg Kroah-Hartman wrote:
> > On Tue, Oct 23, 2018 at 02:43:04PM -0300, Shayenne da Luz Moura wrote:
> > > Remove unneeded parentheses around the arguments of ||. This reduces
> > > clutter and code behave in the same way.
> > > Change suggested by checkpatch.pl.
> > >
> > > vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> > > crtc->x'
> > >
> > > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > Changes in v2:
> > >   - Make the commit message more clearer.
> >
> > This patch does not apply to the latest kernel tree at all :(
> >
> > Please fix up and resend.
> >
> > thanks,
> >
> > greg k-h
>
> Hi Greg!
>
> Sorry, I do not know what branch are expected to be used.
> I used the drm-misc-next to create this patch and I could not
> find any merge problem.
>
> Could you please tell me the details?

For staging drivers you should use the staging tree as indicated in the
outreachy tutorial.

julia


>
> Thanks,
>
> Shayenne
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20181030231757.24ooubt25oykmgkt%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
