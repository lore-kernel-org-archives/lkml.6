Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056AF2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbfBRQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:28:18 -0500
Received: from muru.com ([72.249.23.125]:39324 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbfBRQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:28:18 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7092480E4;
        Mon, 18 Feb 2019 16:28:27 +0000 (UTC)
Date:   Mon, 18 Feb 2019 08:28:14 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
Subject: Re: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using
 external dma
Message-ID: <20190218162814.GI15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-4-faiz_abbas@ti.com>
 <20190215200718.GB15711@atomide.com>
 <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com>
 <20190218162033.GF15711@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218162033.GF15711@atomide.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190218 16:20]:
> * Faiz Abbas <faiz_abbas@ti.com> [190218 13:38]:
> > Hi Tony,
> > 
> > On 16/02/19 1:37 AM, Tony Lindgren wrote:
> > > * Faiz Abbas <faiz_abbas@ti.com> [190215 19:18]:
> > >> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> > >>
> > >> sdhci-omap can support both external dma controller via dmaengine
> > >> framework as well as ADMA which standard SD host controller
> > >> provides.
> > > 
> > > Care to describe here also how to configure things for ADMA and
> > > instead of DMA? Just leave out dmas property?
> > >
> > That's correct. If dmas property is populated, then use external DMA.
> > Otherwise use ADMA/SDMA depending on what you read from the CAPS register.
> 
> OK thanks.

So I guess the dma properties should be under optional
properties in the binding doc then.

Regards,

Tony
