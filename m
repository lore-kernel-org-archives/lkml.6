Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0538F2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0538F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeJEWgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:36:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbeJEWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:36:45 -0400
Received: from localhost (unknown [216.9.110.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5BBD1448;
        Fri,  5 Oct 2018 15:37:31 +0000 (UTC)
Date:   Fri, 5 Oct 2018 08:37:22 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [git pull] IOMMU Fixes for Linux v4.19-rc6
Message-ID: <20181005153722.GD530@kroah.com>
References: <20181005083005.ctclagex4fu73tvf@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005083005.ctclagex4fu73tvf@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:30:09AM +0200, Joerg Roedel wrote:
> Hi Greg,
> 
> The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:
> 
>   Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.19-rc6

Now merged, thanks,

greg k-h
