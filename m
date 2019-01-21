Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F14C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4397820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfAUUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:00:34 -0500
Received: from muru.com ([72.249.23.125]:34588 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbfAUUAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:00:34 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 424C980C0;
        Mon, 21 Jan 2019 20:00:41 +0000 (UTC)
Date:   Mon, 21 Jan 2019 12:00:30 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Arthur Demchenkov <spinal.by@gmail.com>, bcousson@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Message-ID: <20190121200030.GJ5544@atomide.com>
References: <20190121032109.10220-1-spinal.by@gmail.com>
 <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabio Estevam <festevam@gmail.com> [190121 17:52]:
> On Mon, Jan 21, 2019 at 5:43 AM Arthur Demchenkov <spinal.by@gmail.com> wrote:
> >
> > Wrong polarity of card detect GPIO pin leads to the system not
> > booting from external mmc, if the back cover of N900 is closed.
> > When the cover is open the system boots fine.
> >
> > This wasn't noticed before, because of a bug, which was fixed
> > by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
> > CD and WP).
> >
> > Kernels up to 4.19 ignored the card detect GPIO from DT.
> 
> Signed-off-by tag is missing.

Arthur, please reply with your Signed-off-by for this
thread so I can apply it. That is unless you want to
repost the patch for updated comments etc.

Regards,

Tony
