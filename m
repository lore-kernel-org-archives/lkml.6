Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F76520831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F76520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeKBGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:16:41 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43607 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeKBGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:16:41 -0400
X-Originating-IP: 134.134.139.76
Received: from localhost (unknown [134.134.139.76])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7AE7AC0005;
        Thu,  1 Nov 2018 21:11:57 +0000 (UTC)
Date:   Thu, 1 Nov 2018 14:11:53 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     NeilBrown <neil@brown.name>, Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181101211152.GA6007@localhost>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181024121622.GA10942@localhost>
 <87ftwt6850.fsf@notabene.neil.brown.name>
 <20181027011010.GA29769@localhost>
 <20181101164544.GA31540@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101164544.GA31540@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 09:45:44AM -0700, Paul E. McKenney wrote:
> On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
> > Not when that document started out effectively saying, in an elaborate
> > way, "code > people".
> 
> Interesting.
> 
> I am curious what leads you to your "code > people" statement.  Of course,
> one could argue that this does not really matter given that the code of
> conflict is no longer.  However, I would like to understand for future
> reference, if for no other reason.
> 
> One possibility is that you are restricting the "people" to only those
> people directly contributing in one way or another.  But those using the
> kernel (both directly and indirectly) are important as well, and it is
> exactly this group that is served by "the most robust operating system
> kernel ever", the chest-beating sentiment notwithstanding.  Which is in
> fact why I must reject (or rework or whatever) any patch that might result
> in too-short RCU grace periods:  The needs of the patch's submitter are
> quite emphatically outweighed by the needs of the kernel's many users,
> and many of the various technical requirements and restrictions are in
> fact proxies for the needs of these users.

As discussed in many other places as well, nobody is suggesting at all
that the standards for accepting code should change. Reject the patches
you would have rejected, accept the patches you would have accepted. All
of this affects *communication*.

- Josh Triplett
