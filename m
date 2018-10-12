Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F9F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F69uzfB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F9F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJLPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbeJLPzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:55:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572AA2086A;
        Fri, 12 Oct 2018 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539332639;
        bh=OV8Fno+uloy1JgUM/EuwfIIUWFQh/9kIbxlkndYadJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F69uzfB2SINVR2E3CuI8AgRkyg55sHTYB+IMjUMl8KOnDNX3VF3shKa08TvbRNuwD
         St8Fo1hMxAIdVhSYKjvHVTc/AtQw4J2SvOYdlfCeZOMQPTx5tVDTP9nUyftAeHaalR
         VGk6KGpetBMFyWUuB1zKFpvJtCqKYPUMc/n2AXJw=
Date:   Fri, 12 Oct 2018 10:23:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20181012082357.GB23069@kroah.com>
References: <20181011.190615.78309421924776793.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011.190615.78309421924776793.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 07:06:15PM -0700, David Miller wrote:
> 
> 1) RXRPC receive path fixes from David Howells.
> 
> 2) Re-export __skb_recv_udp(), from Jiri Kosina.
> 
> 3) Fix refcounting in u32 classificer, from Al Viro.
> 
> 4) Userspace netlink ABI fixes from Eugene Syromiatnikov.
> 
> 5) Don't double iounmap on rmmod in ena driver, from Arthur
>    Kiyanovski.
> 
> 6) Fix devlink string attribute handling, we must pull a copy
>    into a kernel buffer if the lifetime extends past the netlink
>    request.  From Moshe Shemesh.
> 
> 7) Fix hangs in RDS, from Ka-Cheong Poon.
> 
> 8) Fix recursive locking lockdep warnings in tipc, from Ying Xue.
> 
> 9) Clear RX irq correctly in socionext, from Ilias Apalodimas.
> 
> 10) bcm_sf2 fixes from Florian Fainelli.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit c1d84a1b42ef70d8ae601df9cadedc7ed4f1beb1:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-06 02:11:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 
> 

Now merged, thanks.

greg k-h
