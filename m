Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7F0C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7C32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfARTmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:42:17 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36710 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbfARTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:42:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 857E6612DC94;
        Fri, 18 Jan 2019 20:42:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ogYuyjgplhnO; Fri, 18 Jan 2019 20:42:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 231E4612DC93;
        Fri, 18 Jan 2019 20:42:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 40DglaUbvJi0; Fri, 18 Jan 2019 20:42:14 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A28C460D4820;
        Fri, 18 Jan 2019 20:42:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>, jdike@addtoit.com,
        yuehaibing@huawei.com, brajeswar.linux@gmail.com,
        linux-um@lists.infradead.org, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: Remove duplicate headers
Date:   Fri, 18 Jan 2019 20:42:13 +0100
Message-ID: <4621128.kXzvTGAT2u@blindfold>
In-Reply-To: <dfdf5e70-f782-d90e-1059-a524a5e72b7d@cambridgegreys.com>
References: <5c41e99b.1c69fb81.f240b.506a@mx.google.com> <dfdf5e70-f782-d90e-1059-a524a5e72b7d@cambridgegreys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Januar 2019, 20:23:07 CET schrieb Anton Ivanov:
> 
> On 18/01/2019 14:58, Sabyasachi Gupta wrote:
> > Remove sys/socket.h and sys/uio.h which are included more than once
> > 
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > ---
> >   arch/um/drivers/vector_user.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> > index d2c17dd..c863921 100644
> > --- a/arch/um/drivers/vector_user.c
> > +++ b/arch/um/drivers/vector_user.c
> > @@ -23,7 +23,6 @@
> >   #include <netinet/ether.h>
> >   #include <linux/if_ether.h>
> >   #include <linux/if_packet.h>
> > -#include <sys/socket.h>
> >   #include <sys/wait.h>
> >   #include <sys/uio.h>
> >   #include <linux/virtio_net.h>
> > @@ -31,7 +30,6 @@
> >   #include <stdlib.h>
> >   #include <os.h>
> >   #include <um_malloc.h>
> > -#include <sys/uio.h>
> >   #include "vector_user.h"
> >   
> >   #define ID_GRE 0
> > 
> 
> Hi Sabyasachi,
> 
> I believe we have an identical patch enqueued already from a couple of 
> weeks back.

Hmm, did I miss that one in patchwork?

Thanks,
//richard


