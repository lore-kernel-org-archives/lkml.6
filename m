Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeBZQRs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:17:48 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:49356 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751334AbeBZQRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:17:47 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM PLLs
Date: Mon, 26 Feb 2018 17:17:41 +0100
Message-ID: <2662255.10CUWtpM2s@jernej-laptop>
In-Reply-To: <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net> <20180224214545.3740-2-jernej.skrabec@siol.net> <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne ponedeljek, 26. februar 2018 ob 10:38:00 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
> > Some NM PLLs doesn't work well when their output clock rate is set below
> > certain rate.
> > 
> > Add support for that constrain.
> 
> In such a case, you should round the rate to the minimum the clock can
> operate at, and not return an error.

OK.

Best regards,
Jernej
