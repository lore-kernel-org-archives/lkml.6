Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7469C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1C20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F1C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbeKZKAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:00:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:39158 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeKZKAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:00:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wAPN7VBJ014862;
        Sun, 25 Nov 2018 17:07:32 -0600
Message-ID: <c343001944e6039ed2abdbae1c58c3a796f20cf8.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/fsi/fsi-scom.c: Remove duplicate header
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        eajames@linux.vnet.ibm.com, alistair@popple.id.au,
        cbostic@linux.vnet.ibm.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Mon, 26 Nov 2018 10:07:31 +1100
In-Reply-To: <CAFqtX7mbVfcB_fYL3Fj=+314Ze3ckR3iGZ=hhvsHROKA6bf7+w@mail.gmail.com>
References: <20181116104703.GA10221@hp-pavilion-15-notebook-pc-brajeswar>
         <CAFqtX7mbVfcB_fYL3Fj=+314Ze3ckR3iGZ=hhvsHROKA6bf7+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-24 at 13:51 +0530, Brajeswar Ghosh wrote:
> On Fri, Nov 16, 2018 at 4:17 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> > Remove linux/cdev.h which is included more than once
> > 
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> 
> Any comment on this patch?

Ah sorry, I missed it. Yeah it's fine. I will send it to Greg.

> > ---
> >  drivers/fsi/fsi-scom.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> > index df94021dd9d1..81dc01ac2351 100644
> > --- a/drivers/fsi/fsi-scom.c
> > +++ b/drivers/fsi/fsi-scom.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/fs.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/slab.h>
> > -#include <linux/cdev.h>
> >  #include <linux/list.h>
> > 
> >  #include <uapi/linux/fsi.h>
> > --
> > 2.17.1
> > 

