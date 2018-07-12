Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6A9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381132086B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381132086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGLGwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:52:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeGLGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:52:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6ACC3BAF;
        Thu, 12 Jul 2018 06:43:50 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:42:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [GIT PULL] FSI updates round 2 for 4.19
Message-ID: <20180712064258.GA25229@kroah.com>
References: <6b3728c37095b54666827d61d0540dddf0187a80.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3728c37095b54666827d61d0540dddf0187a80.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:03:44PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> This is the second round of updates of the FSI stack.
> 
> These comprise of:
> 
>  - Some build fixes detected with COMPILE_TEST when
> used on "other" archs
> 
>  - Sparse warning fixes
> 
>  - Some object lifetime fixes
> 
>  - A new feature to control some of the protocol delays
> 
>  - Overheaul of the "SCOM" driver used to access the POWER
> processor internal SCOM bus.
> 
>  - Preparatory work for the new ColdFire coprocessor based FSI master
> work which, along some other newer work is still going through the last
> few rounds of polish and DT bindings reviews.
> 
> The following changes since commit 9f4a8a2d7f9d71093f41c4bb0ef8707e8145bad3:
> 
>   fsi/sbefifo: Add driver for the SBE FIFO (2018-06-12 14:05:39 +1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-07-12

Pulled and pushed out now, thanks.

greg k-h
