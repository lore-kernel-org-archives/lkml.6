Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD5220877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD5220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeISKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:51:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISKvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:51:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 880FDBD4;
        Wed, 19 Sep 2018 05:15:26 +0000 (UTC)
Date:   Wed, 19 Sep 2018 07:15:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] tty_port: Fix kernel-docs warnings
Message-ID: <20180919051523.GC31598@kroah.com>
References: <20180912075044.8695-1-me@tobin.cc>
 <20180912075044.8695-4-me@tobin.cc>
 <20180918133849.GA25134@kroah.com>
 <20180918220246.GD22746@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918220246.GD22746@eros>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 08:02:46AM +1000, Tobin C. Harding wrote:
> On Tue, Sep 18, 2018 at 03:38:49PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 12, 2018 at 05:50:44PM +1000, Tobin C. Harding wrote:
> > > Currently extracting the kernel-docs causes a six warnings of type
> > > 
> > >   warning: Function parameter or member 'foo' not described in 'bar'
> > > 
> > > Add function parameter descriptions to the function kernel-docs.
> > > 
> > > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > > ---
> > >  drivers/tty/tty_port.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > 
> > As I didn't take patch 2/3, this one doesn't apply :(
> 
> Oh I thought this whole set would have been ignored because of comments
> on it.

Not at all, kerneldoc cleanups are great to have!

> I've been working on doing these changes for all of drivers/tty/

That's good, it needs it, thanks.

greg k-h
