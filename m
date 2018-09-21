Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A72ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FB121523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FB121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbeIUTug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:50:36 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:55614 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:50:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B31760A3589;
        Fri, 21 Sep 2018 16:01:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SjG0EzqGnGgz; Fri, 21 Sep 2018 16:01:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AF0C6609F834;
        Fri, 21 Sep 2018 16:01:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ROEGBB5zuIui; Fri, 21 Sep 2018 16:01:33 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 850FE606094E;
        Fri, 21 Sep 2018 16:01:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] UBIFS fixes for 4.19-rc4
Date:   Fri, 21 Sep 2018 16:01:33 +0200
Message-ID: <1614017.BCjLPTCWnn@blindfold>
In-Reply-To: <20180921135342.GA13900@kroah.com>
References: <3383200.5o9oegka29@blindfold> <20180921135342.GA13900@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. September 2018, 15:53:42 CEST schrieb Greg KH:
> On Fri, Sep 21, 2018 at 11:33:15AM +0200, Richard Weinberger wrote:
> > Greg,
> > 
> > The following changes since commit ae596de1a0c8c2c924dc99d23c026259372ab234:
> > 
> >   Compiler Attributes: naked can be shared (2018-09-20 15:23:58 +0200)
> 
> Wow, bold move, new patches with less than 24 hours in your tree.  That
> means linux-next didn't see them :(
> 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc4
> 
> Now pulled, but really, don't you think that they should at least go
> through 0-day first?  Maybe no one runs ubifs on mainline kernels...

Huh? I checked this morning next-20180921 and saw all patches.

Thanks,
//richard


