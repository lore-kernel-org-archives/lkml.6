Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A4F2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A4F2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJCB2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:28:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJCB2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:28:48 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCC61FD0;
        Tue,  2 Oct 2018 18:44:01 +0000 (UTC)
Date:   Tue, 2 Oct 2018 11:44:00 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     vkoul@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [GIT PULL] SoundWire updates for 4.20-rc1
Message-ID: <20181002184400.GA28146@kroah.com>
References: <20181002142327.GA19792@vkoul-mobl>
 <20181002163850.GA11549@kroah.com>
 <CANiq72meqnbNYd0syo4DJftZedOD3GitAGeFT_66bpjCV93ehg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72meqnbNYd0syo4DJftZedOD3GitAGeFT_66bpjCV93ehg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 08:38:41PM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> On Tue, Oct 2, 2018 at 8:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Oct 02, 2018 at 07:53:27PM +0530, Vinod wrote:
> > > Hey Greg,
> > >
> > > Here are the SoundWire updates (again) for 4.20-rc1/5.0-rc1
> > > This brings in the multi-link streaming support and rst format
> > > corrections. The changes are in linux-next for quite some time.
> > >
> > > Please consider pull to receive:
> > >
> > > The following changes since commit 8d6ccf5cebbc7ed1dee9986e36853a78dfb64084:
> > >
> > >   soundwire: Fix acquiring bus lock twice during master release (2018-08-27 09:49:48 +0530)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-4.20-rc1
> >
> > Now pulled, thanks.
> >
> > greg k-h
> 
> Confused here -- pulled to where? 4.19 will still have rc7, no?

Pulled to my char-misc-branch to be submitted to "mainline" once
4.19-final is out.

This has nothing to do with the 4.19-rc development process right now,
sorry for any potential confusion.

thanks,

greg k-h
