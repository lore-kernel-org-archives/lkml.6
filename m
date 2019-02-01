Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BE720863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549011607;
	bh=5RoKxw105HLXN98in7hrCdZfSYbtrWOcHrTxj6ZJGQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s62RpnE22UhRr5AhljGyZiMJJsKGD/x0BBNLaY/kInXM1P6EsAd1XESegHs2oI8EF
	 IteQJORittlk6T0JByycnKJOyEO3J0LBgntQHQy1M21BnyD8nQ/sNTLXtYomNePHLN
	 9YSIquBC5Fqp+JgsApBWJmZMHHoe16NMi0kdkr5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfBAJAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfBAJAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:00:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4964A20863;
        Fri,  1 Feb 2019 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549011604;
        bh=5RoKxw105HLXN98in7hrCdZfSYbtrWOcHrTxj6ZJGQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpoHtwcvVK0IpcJ9dUopy97Poyw6PrI8WAYn8XzFM/PcW+tEarbxe5+b2aGhCnO/M
         RHtENHDe795SRhdPkorTgmXJgp5E1gxGYdA70uAICK82O8qY2WSi+QkJnaN8pwg0ql
         eq9kfV7t37teNRHakLivjnJL/cLsril8/m91YIZM=
Date:   Fri, 1 Feb 2019 10:00:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Umansky <mishka99@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: latest RT patches for the latest 4.20.6 release
Message-ID: <20190201090002.GA4166@kroah.com>
References: <CAOPCCyKnS6Eab6QD8Qd6-pyYTXP4VDMsjTfzzv8R+ijTDCVf4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOPCCyKnS6Eab6QD8Qd6-pyYTXP4VDMsjTfzzv8R+ijTDCVf4w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:04:40AM -0800, Michael Umansky wrote:
> Hello,
> 
> I found linux-stable-rt-4.20.2.tar.gz but the latest official patches
> are for 4.19.15 (in the rt directory).
> 
> While I can run the diffs against the regular 4.20.2 tree I'm curious
> if there will be official patches released against that version, or
> better yet, against current 4.20.6 stable version?

I recommend asking the -rt developers, as they know the most about this
and their plans for releases of that patchset.

good luck!

greg k-h
