Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F1DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D162075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTcfR1uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D162075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeJHVii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJHVii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:38:38 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EED32075C;
        Mon,  8 Oct 2018 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539008799;
        bh=zxseK8LQxoaEWrgH1VTQNH677057d6PhHDbMfHxbtEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTcfR1uj9fMk2nWI1zZh8S4rItxobba4uTRM+28sQLdFs8ydD53QJBJCKzV56Qia0
         znTuXT9niiqXaEPH7aszFdOxQ+UjNPx+lnbZGTrRC87PMMxgOKgI830YUDSJTirbfd
         /BOpYd1NE2lJ9qIBzwjtVG5ziTkX+SeSIuWzRx6M=
Date:   Mon, 8 Oct 2018 16:26:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Sparc
Message-ID: <20181008142637.GA13671@kroah.com>
References: <20181007.234832.1963273306260975472.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007.234832.1963273306260975472.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 11:48:32PM -0700, David Miller wrote:
> 
> I've been moving so haven't had access to my Sparc boxes during this
> time.  That's been resolved, and now I can get the patches flowing
> again.
> 
> 1) Minor fallthru comment tweaks from Gustavo A. R. Silva.
> 
> 2) VLA removal from Kees Cook.
> 
> 3) Make sparc vdso Makefile match x86, from Masahiro Yamada.
> 
> 4) Fix clock divider programming in mach64 driver, from Mikulas
>    Patocka.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit c1d84a1b42ef70d8ae601df9cadedc7ed4f1beb1:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-06 02:11:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

Now merged, thanks.

greg k-h
