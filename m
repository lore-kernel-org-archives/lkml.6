Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ADCC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E08E2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfARVyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:54:16 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43032 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfARVyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:54:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 38E72612DCB8;
        Fri, 18 Jan 2019 22:54:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7qZUYD4Vax5U; Fri, 18 Jan 2019 22:54:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C974B612DCBB;
        Fri, 18 Jan 2019 22:54:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yPPXVbl79z8j; Fri, 18 Jan 2019 22:54:13 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4A744612DCB8;
        Fri, 18 Jan 2019 22:54:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        yuehaibing@huawei.com, jdike@addtoit.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        jrdr.linux@gmail.com, brajeswar.linux@gmail.com
Subject: Re: [PATCH] um: Remove duplicate headers
Date:   Fri, 18 Jan 2019 22:54:12 +0100
Message-ID: <9119450.NpuUixIce5@blindfold>
In-Reply-To: <d9f525fb-847f-312e-43e7-c80b65936680@cambridgegreys.com>
References: <5c41e99b.1c69fb81.f240b.506a@mx.google.com> <4621128.kXzvTGAT2u@blindfold> <d9f525fb-847f-312e-43e7-c80b65936680@cambridgegreys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Januar 2019, 21:00:22 CET schrieb Anton Ivanov:
> >> Hi Sabyasachi,
> >>
> >> I believe we have an identical patch enqueued already from a couple of
> >> weeks back.
> > 
> > Hmm, did I miss that one in patchwork?
> > 
> > Thanks,
> > //richard
> > 
> > 
> > 
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> > 
> https://patchwork.ozlabs.org/patch/1020163/

Ahh, I thought I forgot this for the last merge window.
Now things make sense again.

Anton, can you please test/Ack the patch? Then it can go to -next.

Thanks,
//richard



