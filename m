Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C7C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5362083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5362083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJPReT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:34:19 -0400
Received: from shell.v3.sk ([90.176.6.54]:51362 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeJPReT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:34:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C5930BD785;
        Tue, 16 Oct 2018 11:44:39 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id W7TXrftDPv7G; Tue, 16 Oct 2018 11:44:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9F64ABD788;
        Tue, 16 Oct 2018 11:44:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2uAriDGphmVQ; Tue, 16 Oct 2018 11:44:36 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B465FBD785;
        Tue, 16 Oct 2018 11:44:35 +0200 (CEST)
Message-ID: <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Tue, 16 Oct 2018 11:44:34 +0200
In-Reply-To: <20181015195612.GB29649@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
         <20181015195612.GB29649@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

On Mon, 2018-10-15 at 21:56 +0200, Pavel Machek wrote:
> Hi!
> 
> > This makes keyboard/touchpad work on a DT MMP2 platform.
> > 
> > I believe that it would be a good idea if this, once reviewed, went
> > in
> > via the input tree. The DT and CLK parts got reviews/acks.
> > 
> > Changes from v1:
> > - Basically none, just re-send, including Ack and Review tags in
> > patches
> >   that received them. Plus an extra Cc.
> >   I'd be very thankful for reviews.
> 
> Ok, I believe I have OLPC 1.75, and it is actually a nice
> machine. Can I get recent kernel working there in useful fashion? (Is
> there docs somewhere)?

A lovely machine indeed. I've written this now:

https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75

I didn't test it yet -- will do when I get home in the evening. But
chances are it's good enough and I guess you'd be able to get it
working even if I messed up some details.

Please let me know if it works for you -- I'm having trouble getting
reviews/acks/tested-bys for the XO-1.75 patch sets [1] and will be
super thankful if I get some feedback from you.

[1] https://lore.kernel.org/patchwork/bundle/lkundrak/OLPC%20XO%201.75/

> 
> Thanks,
> 									
> Pavel

Cheers,
Lubo

