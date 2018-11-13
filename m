Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF004C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9976620868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9976620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbeKMX5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:57:43 -0500
Received: from shell.v3.sk ([90.176.6.54]:39147 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733103AbeKMX5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:57:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3C6E7C5810;
        Tue, 13 Nov 2018 14:59:24 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ortHkdKk0nm6; Tue, 13 Nov 2018 14:59:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0738DC5812;
        Tue, 13 Nov 2018 14:59:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U3rmEt_tnLkl; Tue, 13 Nov 2018 14:59:20 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B0708C5810;
        Tue, 13 Nov 2018 14:59:19 +0100 (CET)
Message-ID: <5a4c548be4cf9fb3fb6ce5128d6780eea3005215.camel@v3.sk>
Subject: Re: [PATCH 04/15] Platform: OLPC: Remove an unused include
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Date:   Tue, 13 Nov 2018 14:59:18 +0100
In-Reply-To: <CAHp75Veb++-F3yd9r5h305UQFvBFosRQvmPDfTTMFak9ZNVc7g@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-5-lkundrak@v3.sk>
         <CAHp75Veb++-F3yd9r5h305UQFvBFosRQvmPDfTTMFak9ZNVc7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for the response.

On Fri, 2018-10-19 at 16:05 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > Also, the header is x86 specific, while there are non-x86 OLPC
> > machines.
> 
> Same concern. as per patch 2.

Which concern? If it's that it doesn't make sense in that particular
place in the patch set, then I don't think so; this header is
unnecessary and the patch has no other dependencies. But the changes
that enable the OLPC EC platform code depend on this.

> Also, you might want to sort headers in alphabetical order.

But should I? Doing so in the same commit would obscure the actual
change, and a separate commit would needlessly clobber git annotate.

Thank you
Lubo

> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/platform/olpc/olpc-ec.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/platform/olpc/olpc-ec.c
> > b/drivers/platform/olpc/olpc-ec.c
> > index f99b183d5296..35a21c66cd0d 100644
> > --- a/drivers/platform/olpc/olpc-ec.c
> > +++ b/drivers/platform/olpc/olpc-ec.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/module.h>
> >  #include <linux/list.h>
> >  #include <linux/olpc-ec.h>
> > -#include <asm/olpc.h>
> > 
> >  struct ec_cmd_desc {
> >         u8 cmd;
> > --
> > 2.19.0
> > 
> 
> 

