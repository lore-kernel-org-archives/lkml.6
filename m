Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E0B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E0B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeGXHsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:48:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbeGXHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:48:21 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 311E774;
        Tue, 24 Jul 2018 06:43:26 +0000 (UTC)
Date:   Tue, 24 Jul 2018 08:00:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [GIT PULL] FSI updates round 3 for 4.19
Message-ID: <20180724060059.GA15769@kroah.com>
References: <9071d5c82539c93f4a6cc8a76a11b14c3f507f09.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9071d5c82539c93f4a6cc8a76a11b14c3f507f09.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 02:13:16PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> This adds support for offloading the FSI low level bitbanging to the
> ColdFire coprocessor of the Aspeed SoCs. All the pre-requisites have
> already been merged, this is the final piece in the puzzle.
> 
> This branch also pull gpio/ib-aspeed which is a topic branch already
> in gpio/for-next (and thus in next) whic contains pre-requisites.
> 
> Finally, there's also a bug fix to the sbefifo driver for some
> inconsistent use of a mutex in the error handling code.
> 
> Note: The oddball "origin" commit of that pull request comes from
> the fact that Linus Walleij gpio/ib-aspeed tree is ahead of mine,
> so pulling his branch pulled a bunch of already upstream other things
> in. As such, i had to base this pull request off a local merge. This
> shouldn't affect you at all, and allows the diffstat below to be
> correct.
> 
> The bindings updates have been acked by Rob and the corresponding
> device-tree updates will be merged by Joel via the ARM SoC tree.
> 
> Thanks !
> Ben.
> 
> The following changes since commit d5e748ff2b996d83489ac76c072e8b99f9ecef13:
> 
>   Merge remote-tracking branch 'gpio/ib-aspeed' into upstream-ready (2018-07-23 15:21:39 +1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-07-24

Now pulled in and pushed out, thanks.

greg k-h
