Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA35C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5612322BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5612322BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934271AbeGFUqC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:46:02 -0400
Received: from mailoutvs22.siol.net ([185.57.226.213]:51040 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933856AbeGFUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6907A520414;
        Fri,  6 Jul 2018 22:46:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4yb5HdTnCzt1; Fri,  6 Jul 2018 22:46:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id EBD4A520BF5;
        Fri,  6 Jul 2018 22:46:15 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 1DBDB520414;
        Fri,  6 Jul 2018 22:46:15 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Rob Herring <robh@kernel.org>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON description
Date:   Fri, 06 Jul 2018 22:44:20 +0200
Message-ID: <8232482.X57NU8v1zb@jernej-laptop>
In-Reply-To: <20180706204052.GA9680@rob-hp-laptop>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-7-jernej.skrabec@siol.net> <20180706204052.GA9680@rob-hp-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 06. julij 2018 ob 22:40:52 CEST je Rob Herring napisal(a):
> On Fri, Jul 06, 2018 at 07:51:02PM +0200, Jernej Skrabec wrote:
> > TCON description is expanded with R40 TV TCON compatible. It is a bit
> > special, because it is connected to TCON TOP instead directly to mixer
> > and it needs special handling.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Please add acks/reviews when posting new versions.

This is not exactly the same version you give ack for, so I didn't include it. 
I'm not sure where the line for that is.

In contrast to previous version, it doesn't introduce additional clock.

Best regards,
Jernej



