Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F7206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfAPAKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:10:30 -0500
Received: from muru.com ([72.249.23.125]:33802 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbfAPAKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:10:30 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 996A28022;
        Wed, 16 Jan 2019 00:10:35 +0000 (UTC)
Date:   Tue, 15 Jan 2019 16:10:25 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190116001025.GL5544@atomide.com>
References: <20190115192840.GK5544@atomide.com>
 <20190115210920.GJ5522@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115210920.GJ5522@sirena.org.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [190115 21:09]:
> On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:
> 
> > Any ideas what's needed? Some triggering mapping data to palmas.c
> > driver?
> 
> There should be a fix in -next already waiting for me to send it to
> Linus, can you check there (a couple actually, in my for-linus branch)?

OK great, yes the two drivers/base/regmap patches fix the issue
for me.

Regards,

Tony

