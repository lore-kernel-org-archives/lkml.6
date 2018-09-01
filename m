Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA8BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671D02083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671D02083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIAIFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 04:05:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeIAIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 04:05:03 -0400
Received: from localhost (unknown [208.181.116.45])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D63909F0;
        Sat,  1 Sep 2018 03:54:34 +0000 (UTC)
Date:   Fri, 31 Aug 2018 20:54:34 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver patches for 4.19-rc1
Message-ID: <20180901035434.GF27141@kroah.com>
References: <20180818155844.GA22720@kroah.com>
 <20180831111936.GA18291@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831111936.GA18291@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:19:36PM +0200, Pavel Machek wrote:
> Hi!
> 
> > 	- gnss, finally an in-kernel GPS subsystem to try to tame all of
> > 	  the crazy out-of-tree drivers that have been floating around
> > 	  for years, combined with some really hacky userspace
> > 	  implementations.  This is only for GNSS receivers, but you
> > 	  have to start somewhere, and this is great to see.
> 
> Yes, it  is labeled as a GPS subsystem, but there's nothing GPS
> specific in there; it does not understand the data, it just passes
> around bytes.
> 
> Which would not be a problem, except that it takes /dev/gnssX
> namespace, so when we need to introduce hardware abstraction for
> GPS, we will not have suitable names available.

Given that no such code seems to be showing up any year soon, that's a
request that we will just have to deal with if it ever shows up.

What we have now in the tree is good enough for now.

greg k-h
