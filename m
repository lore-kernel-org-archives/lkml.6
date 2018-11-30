Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981F020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981F020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLAHyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAHye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:54:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B002080A;
        Fri, 30 Nov 2018 20:43:59 +0000 (UTC)
Date:   Fri, 30 Nov 2018 15:43:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Abuse <abuse@2.abuse.bgcomp.co.uk>
Cc:     David Miller <davem@davemloft.net>, axboe@kernel.dk,
        dave@stgolabs.net, keescook@chromium.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, dja@axtens.net,
        linux@dominikbrodowski.net, dri-devel@lists.freedesktop.org,
        edumazet@google.com, federico.vaga@vaga.pv.it,
        geert+renesas@glider.be, deller@gmx.de, corbet@lwn.net,
        kumba@gentoo.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, paul.burton@mips.com, pmladek@suse.com,
        robh@kernel.org, sean.wang@mediatek.com,
        sergey.senozhatsky@gmail.com, shannon.nelson@oracle.com,
        sbrivio@redhat.com, me@tobin.cc, makita.toshiaki@lab.ntt.co.jp,
        willemb@google.com, yhs@fb.com, yanjun.zhu@oracle.com
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
Message-ID: <20181130154242.39f59eea@gandalf.local.home>
In-Reply-To: <2007856.n5V9iKLVsV@eth7>
References: <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
        <d7c34289-f03a-b641-cc9c-00395306511d@kernel.dk>
        <20181130.123507.1940310466680455876.davem@davemloft.net>
        <2007856.n5V9iKLVsV@eth7>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 20:39:01 +0000
Abuse <abuse@2.abuse.bgcomp.co.uk> wrote:

> On Friday, 30 November 2018 20:35:07 GMT David Miller wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> > Date: Fri, 30 Nov 2018 13:12:26 -0700
> >   
> > > On 11/30/18 12:56 PM, Davidlohr Bueso wrote:  
> > >> On Fri, 30 Nov 2018, Kees Cook wrote:
> > >>   
> > >>> On Fri, Nov 30, 2018 at 11:27 AM Jarkko Sakkinen
> > >>> <jarkko.sakkinen@linux.intel.com> wrote:  
> > >>>>
> > >>>> In order to comply with the CoC, replace **** with a hug.  
> > >> 
> > >> I hope this is some kind of joke. How would anyone get offended by reading
> > >> technical comments? This is all beyond me...  
> > > 
> > > Agree, this is insanity.  
> > 
> > And even worse it is censorship.
> >   
> 
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> Hug
> 
> I assume I will now be barred.
> 

-- Steve

