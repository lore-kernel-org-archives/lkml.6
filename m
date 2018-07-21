Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68957ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0F92086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0F92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeGUOda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:33:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeGUOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:33:30 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 303AEACD;
        Sat, 21 Jul 2018 13:40:41 +0000 (UTC)
Date:   Sat, 21 Jul 2018 15:40:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@google.com>
Cc:     devel@driverdev.osuosl.org,
        "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        frankhu@chromium.org, John Joseph <jnjoseph@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Springer <rspringer@google.com>, groeck@chromium.org,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 00/14] staging: gasket: assorted cleanups
Message-ID: <20180721134037.GA6994@kroah.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
 <20180721131720.GA4290@kroah.com>
 <CAAW3YpbJADPRYcwZFcHMPcbOWqQmdqiXbvPrJwBxC0=uCo0aFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAW3YpbJADPRYcwZFcHMPcbOWqQmdqiXbvPrJwBxC0=uCo0aFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 06:30:33AM -0700, Todd Poynor wrote:
> On Sat, Jul 21, 2018 at 6:17 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jul 21, 2018 at 05:56:39AM -0700, Todd Poynor wrote:
> > > From: Todd Poynor <toddpoynor@google.com>
> > >
> > > Various fixups arising from the chromium review of the gasket and apex
> > > drivers.
> >
> > Didn't I just apply this whole series?  Why resend it?
> 
> This is another round of cleanups from the chromium review, I can
> update the subject to make that more clear.

Given that the first patch just didn't apply to my tree at all, you need
to just start over with a new series as I think you are not in sync.
Please rebase and resend.

thanks,

greg k-h
