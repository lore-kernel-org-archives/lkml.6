Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80902075C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80902075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeGCMwh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:52:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37831 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752251AbeGCMwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:52:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4291220775; Tue,  3 Jul 2018 14:52:33 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11AAB20714;
        Tue,  3 Jul 2018 14:52:23 +0200 (CEST)
Date:   Tue, 3 Jul 2018 14:52:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH v2 1/6] mtd: spi-nor: atmel-quaspi: Typo fix
Message-ID: <20180703125224.GC14626@piout.net>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-2-bugalski.piotr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627131609.13681-2-bugalski.piotr@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/06/2018 15:16:04+0200, Piotr Bugalski wrote:
> Just minor typo fix. Fixed in preparation of new driver.
> 
> Signed-off: Piotr Bugalski <pbu@cryptera.com>

This SoB line must match the author. It doesn't matter which one you
change. note that you can still submit your patch from an address
different from your work address if necessary (git format-patch will
insert the proper From line).

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
