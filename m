Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA8C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E2F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIMSFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeIMSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EFB5CE3;
        Thu, 13 Sep 2018 12:56:00 +0000 (UTC)
Date:   Thu, 13 Sep 2018 14:55:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: vpd: fix spelling mistake "partion" ->
 "partition"
Message-ID: <20180913125557.GA25003@kroah.com>
References: <20180911165858.3015-1-colin.king@canonical.com>
 <50220bc9-326f-7a93-fecb-9b67fbac98b9@roeck-us.net>
 <20180912052448.GA8481@kroah.com>
 <20180912211011.GA20199@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912211011.GA20199@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:10:11PM -0700, Guenter Roeck wrote:
> On Wed, Sep 12, 2018 at 07:24:48AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Sep 11, 2018 at 09:58:48PM -0700, Guenter Roeck wrote:
> > > On 09/11/2018 09:58 AM, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > Trivial fix to spelling mistake in comment
> > > > 
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Interesting - drivers/firmware/google/ does not have a maintainer.
> > > Greg - is it correct to assume that you are the de-facto maintainer ?
> > 
> > Yeah, I am :(
> > 
> 
> Hmm .. the :( doesn't sound too happy. Do you think we should have one ?

It's no fun when a driver ends up in the tree and no maintainer is
assigned to it, as that means I need to manage it myself.  I've been
doing so since 2011, so it's not exactly a new experience, but as I have
no hardware for this, and honestly don't care at all about these
drivers, it's a very low priority for me to do anything with patches for
these files...

thanks,

greg k-h
