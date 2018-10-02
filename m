Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B85C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E09A20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E09A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJCECG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:02:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeJCECG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:02:06 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54356EA4;
        Tue,  2 Oct 2018 21:16:46 +0000 (UTC)
Date:   Tue, 2 Oct 2018 14:16:45 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
Message-ID: <20181002211645.GA6454@kroah.com>
References: <20181002210213.GA17826@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002210213.GA17826@ls3530.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:02:13PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> please pull a last set of fixes for the parisc architecture for kernel 4.19 from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3
> 
> The major change is for parisc64 to use a 64-bit suseconds_t type to
> match what glibc expects for 64-bit userspace. It's an ABI change, but
> since we don't have a 64-bit userspace on parisc yet, it won't introduce
> a breakage.

Isn't it a bit "late" in the release cycle for such a change?  Why not
do this on the -rc1 release?

> Other than that we simply drop unused code and outdated gcc version
> checks.

Why are those needed now?

thanks,

greg k-h
