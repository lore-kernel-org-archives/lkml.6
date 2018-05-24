Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970140AbeEXNyO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:54:14 -0400
Received: from muru.com ([72.249.23.125]:44448 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966622AbeEXNyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:54:11 -0400
Date: Thu, 24 May 2018 06:54:07 -0700
From: Tony Lindgren <tony@atomide.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com,
        abcloriens@gmail.com, sre@kernel.org, martijn@brixit.nl,
        filip.matijevic.pz@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>, clayton@craftyguy.net,
        patrikbachan@gmail.com, serge@hallyn.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: omapdrm regression in v4.17-rc series
Message-ID: <20180524135407.GB98604@atomide.com>
References: <20180523220320.GX98604@atomide.com>
 <2f803bfc-3ffe-332a-7b9a-d59a39db4630@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f803bfc-3ffe-332a-7b9a-d59a39db4630@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [180524 08:00]:
> 
> On 24/05/18 01:03, Tony Lindgren wrote:
> > Hi all,
> > 
> > I bisected the n900 LCD issue to commit 24aac6011f70 ("drm: omapdrm:
> > sdi: Allocate the sdi private data structure dynamically"). Reverting
> > this patch makes LCD work for me again on n900.
> > 
> > Any ideas?
> 
> This should help to get the SDI enabled.

Thanks yes that fixes it:

Fixes: 24aac6011f70 ("drm: omapdrm: sdi: Allocate the sdi private data
structure dynamically")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
