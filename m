Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A26C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E44214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547103267;
	bh=XmV08IZ0mlgrH8IgaXgXI/TS47sK+N09DPWVyqjHFrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wVB2xR50+PUyEI7kMmAaO2uj9WI7yltMViGEmXFZ0+mNBJOOQ+IQJCpDx+zpVRDcc
	 4kAqRGsco7hyXj0kvg5q/XCrOpyn1SnPEN5XloQ/iyw7cMxQncxpczKM5wuzMgoHz/
	 BfYGMEU+LCe3kvyHq6AtqDfmf2i7+FVS8T7eR/Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfAJGy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJGy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:54:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96565214DA;
        Thu, 10 Jan 2019 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547103266;
        bh=XmV08IZ0mlgrH8IgaXgXI/TS47sK+N09DPWVyqjHFrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdJM3vKcKZl+wFEsbXsdL0Rxryefb51puNnfMu2OfzGceQROkp0HzXjPKHqV6EwjW
         q/DxDAA6W+sTOkcclr0AgyJGfpNz7RzYeQ8pF7whQ6OWVVxgpNdO0E7jEoN6RkgDRp
         03BIco1HmG381Hmo2RUgRglvayGanjj4ELJ3JsRw=
Date:   Thu, 10 Jan 2019 07:54:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for 5.0
Message-ID: <20190110065423.GA28646@kroah.com>
References: <20190110025613.1E42020665@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110025613.1E42020665@mail.kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 09:56:12PM -0500, Sasha Levin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
> 
> for you to fetch changes up to b5679cebf780c6f1c2451a73bf1842a4409840e7:
> 
>   vmbus: fix subchannel removal (2019-01-09 19:20:31 -0500)
> 
> - ----------------------------------------------------------------
> hyperv-fixes-signed
> 
> - ----------------------------------------------------------------

That's a horrible merge request message :(

Please provide at least some hint as to what is in this pull request, I
can't take this as-is, sorry.

greg k-h
