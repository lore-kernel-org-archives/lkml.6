Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B42EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041B520673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041B520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbeK3Bt6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:49:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46308 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732641AbeK3Bt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:49:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 52C3A20D0E; Thu, 29 Nov 2018 15:44:21 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id C993920E00;
        Thu, 29 Nov 2018 15:43:14 +0100 (CET)
Date:   Thu, 29 Nov 2018 15:43:14 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/25] nvmem: add new config option
Message-ID: <20181129154314.1d3cd914@bbrezillon>
In-Reply-To: <CAMRc=Md4PbYDhmBNx5Rk5F9OZw2Om3D6F21iV6za-+dq0NshYw@mail.gmail.com>
References: <20181113140133.17385-1-brgl@bgdev.pl>
        <20181113140133.17385-2-brgl@bgdev.pl>
        <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com>
        <b8f08722-d3d5-6ddf-5845-15eb5079094c@linaro.org>
        <CAMRc=Md4PbYDhmBNx5Rk5F9OZw2Om3D6F21iV6za-+dq0NshYw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 15:35:58 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> czw., 29 lis 2018 o 15:32 Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> napisał(a):
> >
> >  
> > >
> > > Hi Srinivas,
> > >
> > > if there are no objections - can you Ack this patch for Greg to pick
> > > up into char-misc?  
> >
> > Patch is fine for me. I normally send all the nvmem patches just before rc5.
> >
> > --srini  
> > >
> > > Bart
> > >  
> 
> Boris, are you fine with Srinivas sending the MTD patch as well so
> that they stay together?

Yes, I'll just need an immutable branch/tag in case we have conflicting
changes in the MTD tree.
