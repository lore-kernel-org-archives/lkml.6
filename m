Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08783C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD99204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD99204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeKAVcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:32:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39938 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbeKAVcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:32:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0D5322071E; Thu,  1 Nov 2018 13:29:55 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5C7C20379;
        Thu,  1 Nov 2018 13:29:54 +0100 (CET)
Date:   Thu, 1 Nov 2018 13:29:50 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Addition of the I3C subsystem in 4.20 (5.0)?
Message-ID: <20181101132950.7b5f8ec3@bbrezillon>
In-Reply-To: <20181101113330.GB11109@kroah.com>
References: <20181101063523.26bdbe28@bbrezillon>
        <20181101113330.GB11109@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On Thu, 1 Nov 2018 12:33:30 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 01, 2018 at 06:35:23AM +0100, Boris Brezillon wrote:
> > Hello Greg, Linus,
> > 
> > Greg, I didn't get your feedback on v10 of the i3c patchset [1] where I
> > was asking if you'd agree to have this framework merged in 4.20 (I know
> > you were busy with the 4.19 release and after that the Kernel Summit, so
> > that's not a surprise), so I'm sending this PR. It's really not an attempt
> > to bypass you, more like a ping that, if positively acknowledged, might
> > lead to inclusion of the I3C framework in 4.20 (5.0?) :-).
> > 
> > Please let me know if you're opposed to the idea.
> > 
> > Regards,
> > 
> > Boris
> > 
> > [1]https://lkml.org/lkml/2018/10/26/552   
> 
> The last set of patches was sent way too late for this -rc cycle so I
> was going to review them again once 4.20-rc1 was out.
> 
> Also you do not have an ack from the DT maintainers yet, which would be
> required as well, right?

I had a R-b from Rob on Tuesday.

> 
> So I don't think this can be merged just yet, sorry.

Okay, then I'm waiting for your review.

Thanks,

Boris
