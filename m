Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A5ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01FA20854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01FA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeKEIGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:06:23 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:56052 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbeKEIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:06:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E1EFB60765A4;
        Sun,  4 Nov 2018 23:49:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Acp5VJZmNroe; Sun,  4 Nov 2018 23:49:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7395D60765AD;
        Sun,  4 Nov 2018 23:49:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZH6LxSdk2Rsk; Sun,  4 Nov 2018 23:49:46 +0100 (CET)
Received: from blindfold.localnet (213-225-38-78.nat.highway.a1.net [213.225.38.78])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 137B560765A4;
        Sun,  4 Nov 2018 23:49:46 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     richard.weinberger@gmail.com, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] UBIFS updates for 4.20-rc1
Date:   Sun, 04 Nov 2018 23:49:45 +0100
Message-ID: <2384747.GWp2V3nPiV@blindfold>
In-Reply-To: <CAHk-=wj-4T0XEK4fPrnzRxODD1TO4rs4dz6xXH8dL8LJpEXReA@mail.gmail.com>
References: <2346471.iD2boZGiFq@blindfold> <CAFLxGvyP51DcR_=YqP1P4kt=cPpiMdG9n4FGOxpkOYtsfdRg=w@mail.gmail.com> <CAHk-=wj-4T0XEK4fPrnzRxODD1TO4rs4dz6xXH8dL8LJpEXReA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 4. November 2018, 23:45:50 CET schrieb Linus Torvalds:
> On Sun, Nov 4, 2018 at 11:25 AM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> >
> > I'm sorry to pester you a second time.
> > The first ping had you only in CC,
> > let's hope this mail passes your spam filter.
> 
> Interesting. Your two first emails used 'torvalds@linuxfoundation.org"
> (without the dash between "linux" and "foundation"), which works, but
> with my new email setup it didn't get marked as "to me" and got
> auto-archived as "not directly to me".
> 
> This third reminder was to my normal "torvalds@linux-foundation.org"
> address, so now I see it in my inbox.

For the third mail I used Gmail mobile and not KMail, so auto complete used
the other address by accident.
Good to have this sorted out now. :-)

Thanks,
//richard


