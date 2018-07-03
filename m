Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73332C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C46824C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C46824C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933223AbeGCHtK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:49:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34440 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbeGCHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:49:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C75C560A359E;
        Tue,  3 Jul 2018 09:49:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RFcB8fVN9Lyk; Tue,  3 Jul 2018 09:49:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8781860A3591;
        Tue,  3 Jul 2018 09:49:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dWumM4WhB8gH; Tue,  3 Jul 2018 09:49:07 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 61FDD609199F;
        Tue,  3 Jul 2018 09:49:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 0/2] x86/build/vdso: a little more Makefile cleanups
Date:   Tue, 03 Jul 2018 09:49:06 +0200
Message-ID: <5699106.FCe4rGpKHi@blindfold>
In-Reply-To: <20180703073533.GA6573@gmail.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com> <2251685.NraJYuIFmt@blindfold> <20180703073533.GA6573@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. Juli 2018, 09:35:33 CEST schrieb Ingo Molnar:
> 
> * Richard Weinberger <richard@nod.at> wrote:
> 
> > Masahiro,
> > 
> > Am Dienstag, 3. Juli 2018, 03:50:12 CEST schrieb Masahiro Yamada:
> > > 
> > > At first, I sent the first patch to UML ML,
> > > but they did not pick it up.
> > > Instead, I was able to get Acked-by from Richard,
> > > one of the UML maintainers.
> > > 
> > > https://patchwork.kernel.org/patch/10399787/
> > > 
> > > I am resending it to x86 ML.
> > 
> > Uhh, I thought you want to carry this via your tree?
> > I don't mind picking up these patches.
> 
> I already picked them up, as one of them affects the x86 tree.
> 
> Is that OK?

Perfectly fine with me.

Thanks,
//richard
