Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83DF2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83DF2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeHXWAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:00:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeHXWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:00:34 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A271DBE;
        Fri, 24 Aug 2018 18:24:48 +0000 (UTC)
Date:   Fri, 24 Aug 2018 20:24:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Current LTS and their EOL
Message-ID: <20180824182445.GA8702@kroah.com>
References: <20180817154006.GA3725@intel.com>
 <20180817161727.GA24945@kroah.com>
 <7b13f62636d1f0547287cfe0a6135651eba194c1.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b13f62636d1f0547287cfe0a6135651eba194c1.camel@decadent.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 07:52:58PM +0100, Ben Hutchings wrote:
> On Fri, 2018-08-17 at 23:48 +0100, Greg KH wrote:
> > On Fri, Aug 17, 2018 at 08:40:06AM -0700, Rodrigo Vivi wrote:
> > > Hi Greg, Ben, and all
> > > 
> > > Is https://www.kernel.org/category/releases.html updated in terms of EOL?
> > 
> > As of right now, for the kernels I maintain, yes, it is correct.
> > 
> > > Some news out of Linaro conference [2] generated a lot of doubts and questions
> > > around.
> > > 
> > > Specially because on the way it was stated by the news 3.16 wouldn't be active
> > > anymore. So I'm not sure about the news, but I'd like confirmation from you about
> > > expected EOL.
> > 
> > Linaro has nothing to do with the 3.16 kernel, so why are you confusing
> > that with what was announced at that conference, which was about the 4.4
> > kernel tree?
> 
> The article says that other longterm branches are only supported for 2
> years - which has been your usual practice, but obviously doesn't
> reflect what all stable maintainers have done.
> 
> I try to ensure that every stable branch used in a Debian release is
> maintained for the lifetime of that Debian release.  That means 5-6
> years after the initial release of the kernel version.  So far that has
> included 2.6.32 (maintained by Willy Tarreau), 3.2 and 3.16 (maintained
> by me).
> 
> In the latest release we used Linux 4.9 which currently has a stated
> EOL of 2019.  But I'm prepared to take on maintenance from that point
> until June 2022.  Greg, is that OK with you and should the EOL be
> updated on that basis?

Thanks a lot for the offer, but I can handle 4.9 until 2023 now, and
I've updated kernel.org with the new dates to reflect this.  I can
always use help though, if you want to make sure I don't miss any
patches that Debian specifically needs.

thanks,

greg k-h
