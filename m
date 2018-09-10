Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8375C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F62086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1F62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIJMrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:47:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbeIJMrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:47:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04F94208AE; Mon, 10 Sep 2018 09:55:07 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C87E52079D;
        Mon, 10 Sep 2018 09:54:56 +0200 (CEST)
Date:   Mon, 10 Sep 2018 09:54:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] dt-bindings: Add vendor prefix for Microsys
Message-ID: <20180910075456.GA2494@piout.net>
References: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
 <20180903140840.23648-4-alexandre.belloni@bootlin.com>
 <20180910003852.GD21218@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910003852.GD21218@dragon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 08:38:53+0800, Shawn Guo wrote:
> +Rob
> 
> @Rob, Are you okay with this?  The patch should really be sent to you
> from the beginning.
> 

Ah right, Rob was cced on v1 and I forgot to do that in v2.

> Shawn
> 
> On Mon, Sep 03, 2018 at 04:08:39PM +0200, Alexandre Belloni wrote:
> > Add vendor prefix for MicroSys Electronics GmbH
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 2c3fc512e746..10155a44b783 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -235,6 +235,7 @@ micrel	Micrel Inc.
> >  microchip	Microchip Technology Inc.
> >  microcrystal	Micro Crystal AG
> >  micron	Micron Technology Inc.
> > +microsys	MicroSys Electronics GmbH
> >  minix	MINIX Technology Ltd.
> >  miramems	MiraMEMS Sensing Technology Co., Ltd.
> >  mitsubishi	Mitsubishi Electric Corporation
> > -- 
> > 2.19.0.rc1
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
