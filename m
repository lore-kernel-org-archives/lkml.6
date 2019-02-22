Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB38C00319
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC62207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBVB41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:56:27 -0500
Received: from shell.v3.sk ([90.176.6.54]:39750 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfBVB41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:56:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5E948100CCD;
        Fri, 22 Feb 2019 02:56:24 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SaCSQ5hr94RB; Fri, 22 Feb 2019 02:56:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7E6D4100DF2;
        Fri, 22 Feb 2019 02:56:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1rc4q0hLSkHr; Fri, 22 Feb 2019 02:56:21 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A3361100CCD;
        Fri, 22 Feb 2019 02:56:20 +0100 (CET)
Message-ID: <2a40b7e92d913705547d07b71b263c0badb33513.camel@v3.sk>
Subject: Re: [PATCH 1/2] dt-bindings: marvell,mmp2: Add clock id for the
 LCDC clock
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 22 Feb 2019 02:56:19 +0100
In-Reply-To: <155078650801.77512.6725660289964680903@swboyd.mtv.corp.google.com>
References: <20190211102050.24422-1-lkundrak@v3.sk>
         <155078650801.77512.6725660289964680903@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 14:01 -0800, Stephen Boyd wrote:
> Quoting Lubomir Rintel (2019-02-11 02:20:49)
> > The peripheral clock is required for access the the LCDC registers. It
> > is in fact separate from the "AXI clock" that is optionally used to generate
> > the pixel clock and as such requires a separate clock id.
> > 
> > Link: https://lists.freedesktop.org/archives/dri-devel/2019-January/203975.html
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> 
> It's a resend? I picked up the other one.

It is. Sorry for not marking it as such -- I forgot I already sent it.
The patches are indeed the same.

Thanks for picking it up.

Lubo

