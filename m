Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8311C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8102082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8102082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLBPCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:02:52 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36102 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeLBPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:02:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 41BD4606D48C;
        Sun,  2 Dec 2018 16:02:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4HPcC5_aDjQT; Sun,  2 Dec 2018 16:02:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DD1526074BBF;
        Sun,  2 Dec 2018 16:02:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xxi-C4Rt1p-Y; Sun,  2 Dec 2018 16:02:48 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5511B607BD9A;
        Sun,  2 Dec 2018 16:02:48 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martin.kepplinger@ginzinger.com, Stable <stable@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen <juergen.lachmann@harman.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Date:   Sun, 02 Dec 2018 16:02:47 +0100
Message-ID: <1678636.EYQpd7BODG@blindfold>
In-Reply-To: <20181202143543.GE221015@sasha-vm>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com> <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com> <20181202143543.GE221015@sasha-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha,

Am Sonntag, 2. Dezember 2018, 15:35:43 CET schrieb Sasha Levin:
> On Sun, Dec 02, 2018 at 11:50:33AM +0000, Sudip Mukherjee wrote:
> >> > Now queued up for 4.14.y, thanks.
> >>
> >> can you *please* slow a little down?
> >
> >True. It will really help if you can have some sort of fixed schedule
> >for stable release, like maybe stablerc is ready on Thursday or Friday
> >and release the stable on Monday. Having a weekend in stablerc will be
> >helpful for people like me who only get the time in weekends for
> >upstream or stable kernel.
> 
> Any sort of schedule will never work for everyone (for example, if it's
> part of your paid job - you don't necessarily want to review stuff over
> the weekend).

a schedule is not needed, but please give maintainers at least a chance
to react on stable inclusion request.
In this case Martin asked for inclusion on Monday and the patch was applied
two days later.

As you noted not everyone works full time on the kernel and gets paid for that.
So it might take a few days to react and review such a request.

Thanks,
//richard



