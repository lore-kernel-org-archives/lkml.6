Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B112C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B662C208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B662C208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH0XSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:18:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeH0XSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:18:44 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0184D80;
        Mon, 27 Aug 2018 19:30:46 +0000 (UTC)
Date:   Mon, 27 Aug 2018 21:30:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <arigead@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH 01/17] staging:rtl8192u: Remove unused defines - Style
Message-ID: <20180827193042.GA32639@kroah.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
 <20180821171537.9330-2-johnfwhitmore@gmail.com>
 <20180827172719.GA27393@kroah.com>
 <20180827191648.GA19692@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827191648.GA19692@xux707-tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:21:36PM +0100, John Whitmore wrote:
> On Mon, Aug 27, 2018 at 07:27:19PM +0200, Greg KH wrote:
> > On Tue, Aug 21, 2018 at 06:15:21PM +0100, John Whitmore wrote:
> > > Remove a number of unused constant definitions.
> > > 
> > > This is a coding style change which should have no impact on runtime
> > > code execution.
> > > 
> > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h | 5 -----
> > >  1 file changed, 5 deletions(-)
> > 
> > Is this series a duplicate of a prebious series?
> > 
> > it doesn't apply at all to my tree now.
> > 
> > totally confused,
> > 
> > greg k-h
> 
> Sorry didn't mean to confuse you, but now you've got your own back ;)
> After this message I got an automated email to say that the patch
> had been applied. I'll give it a few days for the changes to make
> it into staging-next and if needs be I will resubmit the patch.

Ok, thanks, I went through all of the staging patches today, I might
have ended up looking at a few of them twice :)

greg k-h
