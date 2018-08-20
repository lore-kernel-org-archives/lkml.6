Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A44CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C57721735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57721735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeHTWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:51:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50878 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTWvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:51:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF6EE20737; Mon, 20 Aug 2018 21:34:28 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 94C3D2072F;
        Mon, 20 Aug 2018 21:34:28 +0200 (CEST)
Date:   Mon, 20 Aug 2018 21:34:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v4 4/7] i2c: designware: document MSCC Ocelot bindings
Message-ID: <20180820193427.GV21707@piout.net>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
 <20180816084521.16289-5-alexandre.belloni@bootlin.com>
 <20180820181341.GA982@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820181341.GA982@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2018 13:13:41-0500, Rob Herring wrote:
> On Thu, Aug 16, 2018 at 10:45:18AM +0200, Alexandre Belloni wrote:
> > Document bindings for the Microsemi Ocelot integration of the Designware
> > I2C controller.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> No need to re-spin just for the subject.
> 

Great, thanks a lot!

> Reviewed-by: Rob Herring <robh@kernel.org>

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
