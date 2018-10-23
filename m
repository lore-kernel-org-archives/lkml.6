Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EDC2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIDZfecR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EDC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeJWRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeJWRud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:50:33 -0400
Received: from localhost (unknown [185.7.230.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D25F20665;
        Tue, 23 Oct 2018 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540286879;
        bh=mVvJJ40S1Zy1t/hAkNla28BVCNIUzsKVVXifDxZVJGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIDZfecRnG/16SPs7TtJ5gTcz1X0RJTFDZIbQeJIte5dXVRSIDxQ3P0e4vxlcf+5K
         sXNkilaWIorBHGRfpFy19Ws7n2qiCZK6l2a3ApR5iLk4MYs5LISlyV5/FpHmS8phJ+
         WDTb8JHUWoKpfaSFdc4AeZEMa+V9DtWgcyFY+dqQ=
Date:   Tue, 23 Oct 2018 10:25:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023092534.GB4659@kroah.com>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:41:32AM +0100, Linus Torvalds wrote:
> In particular, the issue is that after each pull, I do a build test
> before the pull is really "final", and while that build test is
> ongoing (which takes anything from a few minutes to over an hour when
> I'm on the road and using my laptop), I go on and look at the *next*
> pull (or one of the other pending ones).
> 
> So by the time the build test has finished, the original pull request
> is already long gone - archived and done - and I have moved on.
> 
> End result: answering the pull request is somewhat inconvenient to my
> flow, which is why I haven't done it.

I had this same issue, as I had full builds run and had to wait for the
results.  But I had a much smaller number of pull requests, so I just
dumped them all into one folder and then did the responses when the
tests came back.

So I had the same issue as you, but you have much more requests to deal
with, sorry.

greg k-h
