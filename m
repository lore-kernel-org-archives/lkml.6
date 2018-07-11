Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF40208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="dlJiCyYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF40208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeGKHPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:15:22 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42337 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeGKHPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:15:22 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 305D025B78E;
        Wed, 11 Jul 2018 17:12:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531293151; bh=Eb7LIfPqAtMDI7JrKCUa1dso1HdvG0i3IZHuYh+YEZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlJiCyYrVWL1piCxl1hWmKr9aFn0SJkhZ1U8fEt3pvsuvRps7fvLgME5zuEoXFNjn
         ytgsUeU/LhxhKi8JeSb522tlPuVk8b4ZNnFt3+rH1iTU+KVrxJzV7NGGuszCzXoVBC
         3wtFl9v9ai9OasR9vzj5ehI6vnMVE+0Vj1dyXqAc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 81DE794048A; Wed, 11 Jul 2018 09:12:28 +0200 (CEST)
Date:   Wed, 11 Jul 2018 09:12:28 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the renesas tree
Message-ID: <20180711071049.sz67dqusxvj5fzax@verge.net.au>
References: <20180710074433.2975b9f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710074433.2975b9f8@canb.auug.org.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 07:44:33AM +1000, Stephen Rothwell wrote:
> Hi Simon,
> 
> Commit
> 
>   19145e19bb08 ("ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n")
> 
> is missing a Signed-off-by from its committer.

Thanks Stephen,

I'll fix that in my next push.

