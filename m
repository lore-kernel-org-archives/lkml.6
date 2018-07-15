Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40939C468C6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA86208BA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA86208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeGOJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:16:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeGOJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:16:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1D9C899;
        Sun, 15 Jul 2018 08:54:06 +0000 (UTC)
Date:   Sun, 15 Jul 2018 10:54:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Willy Tarreau <w@1wt.eu>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Message-ID: <20180715085403.GA21992@kroah.com>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu>
 <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu>
 <20180714173812.xhfwtcijlxebmn2k@devuan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714173812.xhfwtcijlxebmn2k@devuan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 07:38:12PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > The way I see it, if a commit can get one or two tested-by, it's a good
> > > alternative to a week in -next.
> > 

Pavel, I "love" how you fail to point out that you are responding to a 2
month old thread :(

And that thread was beaten to death, and still you want to revise it,
which is odd to me, perhaps you just don't like stable releases?  Given
that you never mark any of the patches for your subsystem for stable
releases, why do you care about how they are maintained?

> > Agreed. Even their own actually. And I'm not kidding. Those who run large
> > amounts of tests on certain patches could really mention is in tested-by,
> > as opposed to the most common cases where the code was just regularly
> > tested.
> 
> Actually, it would be cool to get "Tested: no" and "Tested: compile"
> tags in the commit mesages. Sometimes it is clear from the context
> that patch was not tested (treewide update of time to 64bit), but
> sometime it is not.
> 
> This is especially problem for -stable, as it seems that lately
> patches are backported from new version without any testing.

As everyone has pointed out numerous times in this thread, there are
more testing of stable patches and releases than _EVER_ before in the
history of stable kernels.  And if you feel there are ways to do more
testing that we somehow are missing, wonderful, please provide
constructive criticism.  If not, and you just want to complain, well, my
killfile can always use a new member...

And as always, you have a choice:
	- if you don't like stable kernels, don't run them.

greg k-h
