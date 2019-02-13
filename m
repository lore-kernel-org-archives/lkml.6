Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF310C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9AA222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403936AbfBMPtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:49:11 -0500
Received: from muru.com ([72.249.23.125]:38524 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBMPtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:49:10 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 279EC80AE;
        Wed, 13 Feb 2019 15:49:19 +0000 (UTC)
Date:   Wed, 13 Feb 2019 07:49:06 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH] ARM: dts: omap3-gta04: declare backlight
 in lcd node
Message-ID: <20190213154906.GU5720@atomide.com>
References: <20190211162007.15626-1-andreas@kemnade.info>
 <E556C766-1B1D-4352-9D64-D18B631ADB7D@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E556C766-1B1D-4352-9D64-D18B631ADB7D@goldelico.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190211 18:14]:
> 
> > Am 11.02.2019 um 17:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > The lcd display of the gta04 has a backlight but the backlight
> > was not referenced in the lcd node, so screen blanking did
> > not turn off the backlight. Fix that.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> 
> Works fine.
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks applied into omap-for-v5.1/dt.

Tony
