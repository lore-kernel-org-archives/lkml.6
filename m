Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934705AbeEWWD2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:03:28 -0400
Received: from muru.com ([72.249.23.125]:44336 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934235AbeEWWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:03:24 -0400
Date: Wed, 23 May 2018 15:03:20 -0700
From: Tony Lindgren <tony@atomide.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com,
        abcloriens@gmail.com, sre@kernel.org, martijn@brixit.nl,
        filip.matijevic.pz@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>, clayton@craftyguy.net,
        patrikbachan@gmail.com, serge@hallyn.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: omapdrm regression in v4.17-rc series
Message-ID: <20180523220320.GX98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I bisected the n900 LCD issue to commit 24aac6011f70 ("drm: omapdrm:
sdi: Allocate the sdi private data structure dynamically"). Reverting
this patch makes LCD work for me again on n900.

Any ideas?

Regards,

Tony
