Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03892C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD0720873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfARABP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:01:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48120 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfARABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:01:14 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkHaJ-0001uc-Gq; Fri, 18 Jan 2019 01:00:31 +0100
Date:   Fri, 18 Jan 2019 01:00:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        YueHaibing <yuehaibing@huawei.com>, Yonghong Song <yhs@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Sean Young <sean@mess.org>, Jiri Benc <jbenc@redhat.com>,
        David Calavera <david.calavera@gmail.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Petar Penkov <ppenkov@stanford.edu>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Stephen Hemminger <stephen@networkplumber.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        okash.khawaja@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch 8/9] tools: bpftool: Cleanup license mess
In-Reply-To: <20190117152430.7e47764e@cakuba.netronome.com>
Message-ID: <alpine.DEB.2.21.1901180056570.1647@nanos.tec.linutronix.de>
References: <20190117231416.111952141@linutronix.de> <20190117231501.560475279@linutronix.de> <20190117152430.7e47764e@cakuba.netronome.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Jakub Kicinski wrote:

> On Fri, 18 Jan 2019 00:14:24 +0100, Thomas Gleixner wrote:
> > Precise and non-ambiguous license information is important. The recent
> > relicensing of the bpftools introduced a license conflict.
> > 
> > The files have now:
> > 
> >      SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause
> > 
> > and
> > 
> >      * This program is free software; you can redistribute it and/or
> >      * modify it under the terms of the GNU General Public License
> >      * as published by the Free Software Foundation; either version
> >      * 2 of the License, or (at your option) any later version
> > 
> > Amazingly about 20 people acked that change and neither they nor the
> > committer noticed. Oh well.
> 
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> Sorry about that!  
> 
> These files as you found out are from Stephen, so we probably don't
> need the full litany of acks.

I agree. I cc'ed everyone just to make them aware that licensing is not
just an annoyance. It's a important part of the project and it has legal
implications - in the worst case on the personal level. We already have an
unholy mess in that area, so we really need everybody to take it serious.

Thanks,

	tglx
