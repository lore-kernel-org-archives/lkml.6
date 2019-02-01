Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7118EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4654620870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfBAJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:46:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56998 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfBAJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:46:11 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 5102a5d7e8d85aec; Fri, 1 Feb 2019 10:46:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add "consumer autoprobe" flag
Date:   Fri, 01 Feb 2019 10:45:01 +0100
Message-ID: <2319086.FUgXjVqvWV@aspire.rjw.lan>
In-Reply-To: <20190201090536.GA17484@kroah.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <20190201090536.GA17484@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 1, 2019 10:05:36 AM CET Greg Kroah-Hartman wrote:
> On Fri, Feb 01, 2019 at 01:44:59AM +0100, Rafael J. Wysocki wrote:
> > Hi Greg at al,
> > 
> > This is a combination of the two device links series I have posted
> > recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> > and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> > on top of your driver-core-next branch.
> > 
> > Recently I have been looking at the device links code because of the
> > recent discussion on possibly using them in the DRM subsystem (see for
> > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > found a few issues in that code which should be addressed by this patch
> > series.  Please refer to the patch changelogs for details.
> > 
> > None of the problems addressed here should be manifesting themselves in
> > mainline kernel today, but if there are more device links users in the
> > future, they most likely will be encountered sooner or later.  Also they
> > need to be fixed for the DRM use case to be supported IMO.
> > 
> > On top of this the series makes device links support the "composite device"
> > use case in the DRM subsystem mentioned above (essentially, the last patch
> > in the series is for that purpose).
> 
> All now queued up, thanks!

Thank you!

