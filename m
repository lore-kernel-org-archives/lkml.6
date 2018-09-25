Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8084BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D8F20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D8F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeIYMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:47:22 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34656 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:47:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62D896098131;
        Tue, 25 Sep 2018 08:41:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7S5n-U09N1GQ; Tue, 25 Sep 2018 08:41:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 21D7A6094C3B;
        Tue, 25 Sep 2018 08:41:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XA-rVVhszIAB; Tue, 25 Sep 2018 08:41:18 +0200 (CEST)
Received: from blindfold.localnet (089144196103.atnat0005.highway.a1.net [89.144.196.103])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 91494603B55E;
        Tue, 25 Sep 2018 08:41:17 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Diego Viola <diego.viola@gmail.com>,
        miguel.ojeda.sandonis@gmail.com
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
Date:   Tue, 25 Sep 2018 08:41:16 +0200
Message-ID: <2213595.i1YkRDAqRz@blindfold>
In-Reply-To: <CA+ToGPG-z0GOka6EMruqTto64cpCZaSaTwA3A97-vgN9OKFSJg@mail.gmail.com>
References: <20180912035352.11191-1-diego.viola@gmail.com> <CAFLxGvxZmuXb6KbGggQf4y1_Tkv=Ri3PuE4Jnfwbs1VuA9z2QQ@mail.gmail.com> <CA+ToGPG-z0GOka6EMruqTto64cpCZaSaTwA3A97-vgN9OKFSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. September 2018, 02:09:20 CEST schrieb Diego Viola:
> > Diego, I know you can do better. :-)
> > How about running linux-next and hunting down regressions?
> > I think we suggested this already on IRC.
> 
> OK. I'll do that after I'm done with the documentation.

By the definition of done. ;-)
If you want to help,
Documentation/virtual/uml/UserModeLinux-HOWTO.txt
needs an update.

Thanks,
//richard


