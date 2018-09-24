Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1BAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6838E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6838E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeIXVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:45:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39456 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:45:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id c25-v6so4168657qtp.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 08:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJqsjI10EjsQdn2hNpexsOrBkjiIBLMshrPrWfxVD0E=;
        b=cmqj9+DlhnUkKp3oLfDVJX9Xp0OyRUAwi8aAor9BzMPrs9v48gsvW0fpzECCdr090T
         7zeSl/wsBCC8qHU3xPbiPYuKt6e5SAzeZ+7hum7sEXYJ6ZJofM+YP5bqYTqbBQSs0UqS
         CzixcOCKF+Ranl2853VbEtcur1Hs/rlvvK69vLQRX3wzVfBZJB5F09Is91LbadN0tvZI
         N/lVbOp/sKlH11k7ohfYriftMhsi4Ozqgwg0H7N8Ts3dtyALd4jc8f2nP4FqKWdYONpw
         0zml0qcyBfL9U+FRQgOkzAFl1a04fh/AO1qHJvdirzmlwnOjL8ydL8g0n8VU2tgFbDBd
         yJxg==
X-Gm-Message-State: APzg51CHQs9Y4PRaNksaK6f8XFQfiAh/GFJ7eC0I9gGfEk153A5REFQq
        hVCfKG1Dq/TvoVEY8pxCQ5ZulnXicbxmh1UIZaM=
X-Google-Smtp-Source: ACcGV63UqeBn6kKq6x0os3i5eBrSqzBysQu93ZkfDx9OqnSy12AcZ3JiQ6S5mO4UerOdW1SDEo7Bt7+VZBeDzH+q4Vs=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr803366qtf.185.1537803737266;
 Mon, 24 Sep 2018 08:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <1537764195-19117-1-git-send-email-daniel.lezcano@linaro.org>
 <CAK8P3a0YjbCHRHaTzev-rwi5qM3aBeFUUObL1dPKww_o_J_2vw@mail.gmail.com> <bfffe304-b42c-b2a2-f164-642469aff640@mleia.com>
In-Reply-To: <bfffe304-b42c-b2a2-f164-642469aff640@mleia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 17:42:00 +0200
Message-ID: <CAK8P3a0mSqO+VFHLMYHYa01HjDxbrZejNkxC8-eHKKpVsGvt3A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Set ARM/LPC18XX architecture orphan
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 5:19 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
> On 09/24/2018 04:19 PM, Arnd Bergmann wrote:
> > On Mon, Sep 24, 2018 at 6:43 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> While sending patches around, Joachim Eastwood was Cc'ed but I got an error
> >> its mailbox was full and the mail can not be delivered which makes me think
> >> there is no body at the other end of the line.
> >>
> >> After doing some statistics, it appears the latest commit as author/commiter
> >> is:
> >>
> >> commit b16ebc017ebf52a81e5e88743ccd68fc25e99ba9
> >> Author: Joachim Eastwood <manabian@gmail.com>
> >> Date:   Mon Oct 31 14:45:17 2016 +0000
> >>
> >> Remove the maintainer entry and set the component as orphan.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I also checked the github account and any other mails I could
> > find from Joachim, which stopped around the same time.
> >
> > I've added the lpc32xx maintainers to Cc, as the two platforms are
> > related. Maybe they are interested in picking up support for this
> > as well, and/or merge the two directories into one (there is only
> > one trivial file in mach-lpc18xx, the rest are drivers).
> >
>
> I'm interested in maintenance of lpc18xx/lpc43xx, I have one board
> powered by LPC4357, so it would make the maintenance easier for me,
> also multiple controllers are equal on lpc18xx/lpc43xx and lpc32xx,
> and thus familiar to me.
>
> And I greatly appreciate Joachim's contribution, all platform drivers
> written by Joachim are of perfect quality.
>
> I'll send a patch to MAINTAINERS later on.

Awesome, thanks for stepping up!

       Arnd
