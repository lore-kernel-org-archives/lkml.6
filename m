Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8640AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F13208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F13208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966395AbeF1N7e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:59:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966094AbeF1N7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:59:33 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9931B707;
        Thu, 28 Jun 2018 13:59:30 +0000 (UTC)
Date:   Thu, 28 Jun 2018 21:48:47 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <arigead@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH v3 5/8] staging: rtl8192u: Use %s and __func__ instead of
 hardcoded string - Style
Message-ID: <20180628124847.GA30710@kroah.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-6-johnfwhitmore@gmail.com>
 <20180626035624.GA26173@kroah.com>
 <20180627202248.mvohkxjhwsv5hcn6@xux707-tw>
 <20180628073828.hur7njmsstg2jwvx@mwanda>
 <20180628123239.xqv3lb3bqos467z6@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628123239.xqv3lb3bqos467z6@xux707-tw>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:32:41PM +0100, John Whitmore wrote:
> On Thu, Jun 28, 2018 at 10:38:28AM +0300, Dan Carpenter wrote:
> > On Wed, Jun 27, 2018 at 09:22:50PM +0100, John Whitmore wrote:
> > > On Tue, Jun 26, 2018 at 11:56:24AM +0800, Greg KH wrote:
> > > > On Sun, Jun 24, 2018 at 04:34:51PM +0100, John Whitmore wrote:
> > > > > Changed a number of hard coded function names to use %s and __func__
> > > > > 
> > > > > Mailing list response suggest that there is a better method for debugging
> > > > > using netdev_dbg(). I can't argue with that, but for the moment this change
> > > > > will clear the checkpatch.pl Warning.
> > > > > 
> > > > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > > > ---
> > > > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
> > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > 
> > > > Did not apply :(
> > > 
> > > No worries, can I just ask is that because it should be changed to use
> > > netdev_dbg as was suggested? And should that be across the whole file?
> > 
> > "Does not apply" means you save the raw email to email.txt then download
> > the latest code from
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-next
> > then `cat email.txt | git am` and it fails.
> > 
> > Probably someone else's patch was merged ahead of yours.  Fix it up and
> > then resend.
> > 
> > regards,
> > dan carpenter
> 
> Thank you for that. I read the sentence and filled in my own pronoun as there
> wasn't one :( So I read it as "I did not apply" rather then "it did not
> apply". That's great that 'it' did not apply, thought I'd done something
> wrong. I'll have another crack at it later if I get a chance.

Ick, sorry for being terse, my fault.

greg k-h
