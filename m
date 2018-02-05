Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeBEK7F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeBEK67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:58:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B09214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 18:58:39 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Jagan Teki <jagannadh.teki@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 0/7] ARM: dts: imx6q: engicam LVDS panel changes
Message-ID: <20180205105838.GZ31354@dragon>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 11:19:24PM +0530, Jagan Teki wrote:
> Series adda LVDS panel attributes on panel drivers instead of defining
> them in dts nodes, and also added new icorem6 engicam boards.
> 
> Jagan Teki (7):
>   drm/panel: simple: add support for Ampire AM-800480AYTZQW-00H
>   ARM: dts: imx6q-icore: Switch LVDS timings from panel-simple
>   ARM: dts: imx6dl-icore: Add LVDS node
>   drm/panel: simple: Add support for KEO TX31D200VM0BAA
>   ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
>   ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 7
>     initial support
>   ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit
>     support
> 
>  .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 +++++++++
>  .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 +++++++++
...
>  drivers/gpu/drm/panel/panel-simple.c               | 54 ++++++++++++++++++

The dts files should really be sent only after above bindings doc and
driver changes get merged first.

Shawn
