Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF76C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291292173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfAGQI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:08:56 -0500
Received: from muru.com ([72.249.23.125]:60294 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfAGQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:08:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EB79F813A;
        Mon,  7 Jan 2019 16:09:01 +0000 (UTC)
Date:   Mon, 7 Jan 2019 08:08:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP: DTS: N950/N9: fix onenand timings
Message-ID: <20190107160852.GE5544@atomide.com>
References: <20181223182413.29123-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223182413.29123-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181223 10:24]:
> Commit a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")
> started using DT specified timings for GPMC, and as a result the
> OneNAND stopped working on N950/N9 as we had wrong values in the DT.
> Fix by updating the values to bootloader timings that have been tested
> to be working on both Nokia N950 and N9.
> 
> Fixes: a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")

Applying into omap-for-v5.0/fixes thanks.

Tony
