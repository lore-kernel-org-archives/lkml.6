Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E110C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229F4208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229F4208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH0XGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:06:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50371 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeH0XGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:06:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 63600207B0; Mon, 27 Aug 2018 21:18:58 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 17F1E2072C;
        Mon, 27 Aug 2018 21:18:58 +0200 (CEST)
Date:   Mon, 27 Aug 2018 21:18:56 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] drm/atmel-hlcdc: revise selection of pixel-clock
 frequency divider
Message-ID: <20180827211856.04b4b11f@bbrezillon>
In-Reply-To: <20180824092458.13165-1-peda@axentia.se>
References: <20180824092458.13165-1-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 11:24:56 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> Some background can be found here:
> https://lists.freedesktop.org/archives/dri-devel/2018-August/187182.html
> 
> The "10 times" discriminator in patch 2/2 can certainly be discussed...

Queued to drm-misc-next.

Thanks,

Boris

> 
> Cheers,
> Peter
> 
> Changes since v1    https://lkml.org/lkml/2018/8/24/187
> 
> - added {} to an if body for symmetry
> - reformatted comments a little bit
> - spelling/grammar fixes
> 
> Peter Rosin (2):
>   drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
>   drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 30 ++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 

