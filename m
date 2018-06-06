Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfpMDkYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13DE1601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeFFKtx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932428AbeFFKtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:49:52 -0400
Date: Wed, 6 Jun 2018 12:49:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Whitmore <arigead@gmail.com>
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, pombredanne@nexb.com,
        colin.king@canonical.com
Subject: Re: [PATCH v5 8/8] staging: rtl8192e: remove unnecessary parentheses
 - Coding Style
Message-ID: <20180606104928.GA4992@kroah.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
 <20180603120413.13042-9-johnfwhitmore@gmail.com>
 <20180603122835.GB18700@kroah.com>
 <20180606102512.lvepwliyqd6pkbgj@xux707>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606102512.lvepwliyqd6pkbgj@xux707>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:25:14AM +0100, John Whitmore wrote:
> On Sun, Jun 03, 2018 at 02:28:35PM +0200, Greg KH wrote:
> > On Sun, Jun 03, 2018 at 01:04:13PM +0100, John Whitmore wrote:
> > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > I can not take patches without any changelog text at all :(
> 
> Sorry I created a one line commit message, which became the subject of the
> patch email. I couldn't think of anything more to add for a second line. My
> mistake. I did an ammend of that, as it was the last commit, to add a second
> line.
> 
> Now I'm probably going to get this next bit wrong. Can I simply bump the
> version of patch 8/8 to v6 and resend that single patch file, or bump all 8
> patches to v6 and resend all of them? I'll bump the last patch file and attach
> it to this email, hope for the best.

I can't take attachments, sorry.

Try resending the whole series, as a new version (v6), and all should be
fine.

Note that I can't do anything with patches until the merge window
closes, in 2 weeks, so don't expect a response until then.

thanks,

greg k-h
