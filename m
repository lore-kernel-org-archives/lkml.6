Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B3C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786E20BF3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7786E20BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeGGPEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:04:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:04:19 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F9D9DB3;
        Sat,  7 Jul 2018 15:04:17 +0000 (UTC)
Date:   Sat, 7 Jul 2018 17:03:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [GIT PULL v2]  FSI updates for 4.17
Message-ID: <20180707150312.GA410@kroah.com>
References: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
 <5c7f9044fefed8bc0e4ca5688801ffa379f38f62.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7f9044fefed8bc0e4ca5688801ffa379f38f62.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:54:39PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> There are a first round of updates of the FSI stack, aiming at reducing/removing
> he gap with the OpenBMC tree and a first step in getting dependent drivers
> upstream.
> 
> These changes significantly improve the FSI bitbanging driver performance
> and reliability, and add the new "sbefifo" driver for communicating with
> the POWER9 Self Boot Engine (which will be needed for some upcoming
> additional drivers).
> 
> These were posted to the list as patches a couple of weeks ago and were
> prior to that tested in the OpenBMC tree and CI. Some subsequent driver
> work depends on some of these, so merging early is probably the best.
> 
> The following changes since commit 8efcf34a263965e471e3999904f94d1f6799d42a:
> 
>   Merge tag 'armsoc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-06-11 18:19:45 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-06-12

Sorry for the delay, now merged.

greg k-h
