Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF949C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E77A2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E77A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeKJBvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:51:46 -0500
Received: from muru.com ([72.249.23.125]:53652 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbeKJBvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:51:46 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4084080AE;
        Fri,  9 Nov 2018 16:10:33 +0000 (UTC)
Date:   Fri, 9 Nov 2018 08:10:30 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Vignesh R <vigneshr@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
Message-ID: <20181109161030.GP56134@atomide.com>
References: <20181108091931.3342-1-vigneshr@ti.com>
 <20181108091931.3342-4-vigneshr@ti.com>
 <20181108092320.GC951@kunai>
 <d57ace5e-d42a-0a0e-2813-4a25cc6b37bb@ti.com>
 <20181108150231.GF56134@atomide.com>
 <20181109155517.GF1031@kunai>
 <20181109155647.GG1031@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109155647.GG1031@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wolfram Sang <wsa@the-dreams.de> [181109 15:56]:
> > Cool, thanks all! Tony, I took the liberty to interpret this message as
> > an Acked-by so I could apply V3 of this series right away.
> 
> Doh, v4 I meant. Sorry for the noise.

OK

Thanks,

Tony


