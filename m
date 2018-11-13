Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69532C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C83223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C83223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbeKNApo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:45:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58568 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732356AbeKNApo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:45:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 479652217E; Tue, 13 Nov 2018 15:47:14 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id D2628207F4;
        Tue, 13 Nov 2018 15:46:47 +0100 (CET)
Date:   Tue, 13 Nov 2018 15:46:47 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Hans Verkuil <hansverk@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media <linux-media@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20181113154647.06900549@windsurf>
In-Reply-To: <CAOMZO5DHfgV+iDo4ye7DV9CAA0QjSVXsYH1nbD2+5d9iE-uTCg@mail.gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
        <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
        <CAOMZO5CjFt1dyu8KOK+jKd88x8hwGNy9aJ-sGgooS9970TGTVQ@mail.gmail.com>
        <9a9616d2-a189-bd0e-e2e6-f84bdcb1dfd1@cisco.com>
        <CAOMZO5DHfgV+iDo4ye7DV9CAA0QjSVXsYH1nbD2+5d9iE-uTCg@mail.gmail.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 13 Nov 2018 12:13:09 -0200, Fabio Estevam wrote:

> > Actually, LICENSES/preferred/GPL-2.0 has GPL-2.0-or-later
> > as a valid license:
> >
> > Valid-License-Identifier: GPL-2.0-or-later
> >
> > Personally I very much prefer GPL-2.0-or-later since I think it is
> > much clearer.  
> 
> I saw feedback from Greg to use the SPDX style from
> Documentation/process/license-rules.rst.
> 
> Please check:
> https://lkml.org/lkml/2018/11/10/232

According to https://spdx.org/licenses/, i.e the reference SPDX site,
GPL-2.0-or-later is the right thing to use, and GPL-2.0+ is
"deprecated". But apparently Greg's feedback is "let's not used the
SDPX style, as we don't want to change this all over".

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
