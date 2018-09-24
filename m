Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C2ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF292148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF292148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeIXMYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:24:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43891 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeIXMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:24:09 -0400
Received: from tmo-108-1.customers.d1-online.com ([80.187.108.1] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g4KHR-0007zB-3a; Mon, 24 Sep 2018 08:23:37 +0200
Date:   Mon, 24 Sep 2018 08:23:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rob Prowel <rprowel@comcast.net>
cc:     linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon bogus performance value causing RCU stalls?
In-Reply-To: <de33e029-2be3-85de-4777-64dd8803fe1e@comcast.net>
Message-ID: <alpine.DEB.2.21.1809240822020.1398@nanos.tec.linutronix.de>
References: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net> <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de> <de33e029-2be3-85de-4777-64dd8803fe1e@comcast.net>
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

On Sun, 23 Sep 2018, Rob Prowel wrote:
> On 09/23/18 17:19, Thomas Gleixner wrote:
> > It's in the 4.18.8 stable kernel, which should be available from your
> > fedora repo anytime soon.
> > 
> Will check with the newer kernel when it's available but please do double
> check if this problem might exist on 64 bit architectures as well...and
> of course I'm interested to know whether it is the likely cuprit of my
> RCU problem.

No that thing does not affect 64bit for sure. Can you please provide me a
full dmesg from that machine?

Thanks,

	tglx
