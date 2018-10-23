Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE44DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818FB2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818FB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeJWRkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:40:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41452 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeJWRkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:40:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 957EA208FF; Tue, 23 Oct 2018 11:17:48 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E4B0208C7;
        Tue, 23 Oct 2018 11:17:38 +0200 (CEST)
Date:   Tue, 23 Oct 2018 11:17:38 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023111738.7f50e2bd@bbrezillon>
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, 23 Oct 2018 09:41:32 +0100
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> So I'm mainly pinging people I've already pulled to see how much
> people actually _care_. Yes, the ack is nice, but do people care
> enough that I should try to make that workflow change? Traditionally,
> you can see that I've pulled from just seeing the end result when it
> actually hits the public tree (which is yet another step removed from
> the steps above - I do build tests between every pull, but I generally
> tend to push out the end result in batches, usually a couple of times
> a day).
> 
> Comments?

I do like to receive notifications when a PR is merged (or when a patch
or patchset is applied). Note that I don't care if this notification is
sent in-reply to the original email or in a separate email. I know Mark
(Brown) has it automated in some way, not sure if it's through patchwork
or if he's using a custom tool, and I'm also not sure it works for pull
requests.

Anyway, it's just a nice thing to have, and I can do without it if it's
too complicated to automate.

Regards,

Boris
