Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92668C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E992147D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E992147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJBHx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:53:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBHx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:53:27 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 261A482;
        Tue,  2 Oct 2018 01:12:53 +0000 (UTC)
Date:   Mon, 1 Oct 2018 17:53:34 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com
Subject: Re: [GIT PULL] Late arm64 fixes for 4.19
Message-ID: <20181002005334.GC29284@kroah.com>
References: <20181001174600.GB14755@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001174600.GB14755@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:46:01PM +0100, Will Deacon wrote:
> Hi Greg,
> 
> Please pull these late arm64 fixes for 4.19. Details in the tag, but we've
> fixed a hugetlb livelock issue that was reported by Fujitsu as well as
> removing some useless flexibility in our KVM SET_ONE_REG ioctl().
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:
> 
>   Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

Now pulled, thanks.

greg k-h
