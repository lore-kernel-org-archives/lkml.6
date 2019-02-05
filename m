Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9CCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81532175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfBEN4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:56:19 -0500
Received: from colin.muc.de ([193.149.48.1]:62620 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1726276AbfBEN4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:56:19 -0500
Received: (qmail 35714 invoked by uid 3782); 5 Feb 2019 13:56:16 -0000
Received: from acm.muc.de (p4FE15DB4.dip0.t-ipconnect.de [79.225.93.180]) by
        colin.muc.de (tmda-ofmipd) with ESMTP;
        Tue, 05 Feb 2019 14:56:14 +0100
Received: (qmail 6915 invoked by uid 1000); 5 Feb 2019 13:54:23 -0000
Date:   Tue, 5 Feb 2019 13:54:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, 34235@debbugs.gnu.org,
        Eli Zaretskii <eliz@gnu.org>,
        Alex Branham <alex.branham@gmail.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 (posix-timers: Fix
        division by zero bug). Problems with glibc.
Message-ID: <20190205135423.GA3919@ACM>
References: <20190201214700.GA4950@ACM>
        <alpine.DEB.2.21.1902012301310.8200@nanos.tec.linutronix.de>
        <20190202104404.GA1067@ACM>
        <alpine.DEB.2.21.1902041724200.3006@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902041724200.3006@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas.

On Mon, Feb 04, 2019 at 17:25:11 +0000, Thomas Gleixner wrote:
> On Sat, 2 Feb 2019, Alan Mackenzie wrote:

[ .... ]

> > I've just built and installed Linux 4.19.19, and it does indeed solve
> > the Emacs profiler bug, #34235.  :-)

> > I see that the patch has been installed in 4.20.6, 4.19.19, and 4.14.97.
> > Are there any plans to install it into 4.9.x, the other live long term
> > support branch?  The reason I ask is to make an entry into Emacs's
> > PROBLEMS file, telling users and distributions which kernel versions to
> > upgrade to.

> 4.9 doesn't have the offending commit AFAICT.

OK, thanks very much!  I've put these three version numbers into the
message in Emacs's PROBLEMS file.

I think we're finished, now.

> Thanks,

> 	tglx

-- 
Alan Mackenzie (Nuremberg, Germany).
