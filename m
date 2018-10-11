Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57D6C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91872148C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91872148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeJLB1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:27:41 -0400
Received: from shell.v3.sk ([90.176.6.54]:59679 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeJLB1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:27:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 29F14BD113;
        Thu, 11 Oct 2018 19:59:19 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pLbrhro3LOfk; Thu, 11 Oct 2018 19:59:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5D556BD114;
        Thu, 11 Oct 2018 19:59:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AEdencj8ZIWZ; Thu, 11 Oct 2018 19:59:15 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 36E89BD113;
        Thu, 11 Oct 2018 19:59:15 +0200 (CEST)
Message-ID: <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP
 SPI Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 11 Oct 2018 19:59:15 +0200
In-Reply-To: <20181011142719.GE25351@sirena.org.uk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
         <20181010170936.316862-2-lkundrak@v3.sk>
         <20181011142719.GE25351@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:
> On Wed, Oct 10, 2018 at 07:09:26PM +0200, Lubomir Rintel wrote:
> > This is the SPI controller found on Marvel MMP2 and perhaps more
> > platforms.
> 
> *Way* more.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Thanks for the response.

I'm a little confused here. Why I chose this subject line is because I
did this:

  git log --no-merges Documentation/devicetree/bindings/

to figure out what's the typical subject for the DT binding changes.

I also believed that's the right way to get Rob Herring's and Mark
Rutland's attention. Do the device tree binding documentation typically
go in with the associated drivers, or via their tree ("OPEN FIRMWARE
AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?

Lubo

