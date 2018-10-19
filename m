Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BDECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F1320869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHs828yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F1320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeJSPUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJSPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:20:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8AB20869;
        Fri, 19 Oct 2018 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539933362;
        bh=hg9BFUD4E9q6vaym2ATf4FYPVtJNDeW5Y9GDlP8MhUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHs828yG0GdDw+h3zFuxA7zYf6Vv00zVa6UN0m2cyFeBhqm71Z1Ih3e0taYz+jyIn
         5zYLM9ulgDI/QZwYVfKGrVKH7AifPekEj/ULyS2qU/LF6gbUezwOAPwt8CsO9GrkLV
         BFEn/QrIaxipYt3MTnmRl8zwN3uvmbgG8StNjeT4=
Date:   Fri, 19 Oct 2018 09:16:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Sparc
Message-ID: <20181019071600.GC28551@kroah.com>
References: <20181018.163323.331525365210775149.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018.163323.331525365210775149.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:33:23PM -0700, David Miller wrote:
> 
> The main bit here is fixing how fallback system calls are handled in
> the sparc vDSO.
> 
> Unfortunately, I fat fingered the commit and some perf debugging hacks
> slipped into the vDSO fix, which I revert in the very next commit.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit c343db455eb3105f11bb5ac290d77ab2006b0209:
> 
>   Merge branch 'parisc-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2018-10-17 14:01:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

Now merged, thanks.

greg k-h
