Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8422C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFF4207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFF4207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeJWSOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:14:32 -0400
Received: from namei.org ([65.99.196.166]:47830 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbeJWSOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:14:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9N9pP0K020737;
        Tue, 23 Oct 2018 09:51:25 GMT
Date:   Tue, 23 Oct 2018 20:51:25 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810232049180.20656@namei.org>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Linus Torvalds wrote:

> Comments?

I'm used to watching the git-commits-head mailing list to see what's being 
pulled and don't need anything further as an ack.


-- 
James Morris
<jmorris@namei.org>

