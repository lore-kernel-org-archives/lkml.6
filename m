Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2467C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BFA2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547198157;
	bh=EPkfhSzD35jlc0RrFf/THPBSQE3JZqtVVQepjXg9emQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0XWBChuQ4nKov6NIX8F3I+p0SO5wByHjExTxiEk8Y+JN26S05HuPJ4cAgku21KJcb
	 FrzZWtMErIx12tSJ5I6P8Lm/V9ARUsrjoy6IFJH4trRovuvg8UXMOZ1ZTvPLwiDVUQ
	 7SFvAu1l7nOLl97tAYzbevae/c8pQ8aiM3Eh9ayk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfAKJP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbfAKJP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:15:56 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30F6D20870;
        Fri, 11 Jan 2019 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547198156;
        bh=EPkfhSzD35jlc0RrFf/THPBSQE3JZqtVVQepjXg9emQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZO44XxHLzsphwIhSUcSPcx33VlosgnQ/lDw9BKyb5i+UZ9B9ywUQ7MQuJgdvTVUDK
         XNWh8/kjybfqjaZseTS1s+17hTdlxdTaxcenERv3wT5tV0EOsytWpQ1LBdXOHglc1/
         xD+8BQi0gs9wUawaEVyUoKC0BQhZeJCd0J8Q5D/E=
Date:   Fri, 11 Jan 2019 10:15:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0
Message-ID: <20190111091552.GA16264@kroah.com>
References: <20190110152432.75529214C6@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110152432.75529214C6@mail.kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:24:31AM -0500, Sasha Levin wrote:
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
> Three bug fixes for different parts of the hyper-v code:
> 
>  - Fix for a lockup when changing NIC's MTU from Dexuan.
>  - Fix of use of uninitialized memory from Dexuan.
>  - Fix for memory corruption caused by ballooning from Vitaly.
> 
> All 3 were tested internally.
> 
> - ----------------------------------------------------------------

Did you really push out an updated tag?  I still get the following text
when doing a pull of this tag:

-----------
hyperv-fixes-signed
-----------

So it looks like nothing changed from your previous request.

Note, when creating the signed tag, with 'git tag -s' you have to enter
the text you want to show up in the tag into the editor at that time.

thanks,

greg k-h
