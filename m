Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0964C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C59218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfAZPTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:19:45 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:44028 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:19:45 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id F2D2B20025;
        Sat, 26 Jan 2019 16:19:41 +0100 (CET)
Date:   Sat, 26 Jan 2019 16:19:40 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190126151940.GA17756@ravnborg.org>
References: <20190124215131.17452-1-jagan@amarulasolutions.com>
 <20190124215131.17452-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124215131.17452-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8 a=7gkXJVJtAAAA:8
        a=J7eFq0QTHBzpPFEyLm8A:9 a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry.

> ST7701 designed for small and medium sizes of TFT LCD display, is
> capable of supporting up to 480RGBX864 in resolution. It provides
> several system interfaces like MIPI/RGB/SPI.
> 
> Currently added support for Techstar TS8550B which is ST7701 based
> 480x854, 2-lane MIPI DSI LCD panel.
> 
> Driver now registering mipi_dsi device, but indeed it can extendable
> for RGB if any requirement trigger in future.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

The driver is, as far as I can tell, ready to be committed to drm-misc.
I assume you will take it.

	Sam
