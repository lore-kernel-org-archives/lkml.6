Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeD3HUv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:20:51 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:41952 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeD3HUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:20:49 -0400
Date: Mon, 30 Apr 2018 09:20:45 +0200
From: Simon Horman <horms@verge.net.au>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fbdev/drm: sh_mobile: remove unused MERAM support
Message-ID: <20180430072045.pveq4t63amanu6tx@verge.net.au>
References: <CGME20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8@epcas2p3.samsung.com>
 <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 01:21:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset removes unused MERAM support (last user was removed
> 3 years ago) from shmobile fbdev & drm drivers and then removes
> MERAM driver itself.
> 
> If it is okay to merge this patches I would like patch #1 to go
> through fbdev tree and patch #2 to go through drm tree. Once they
> are both upstream (v4.18) I will apply patch #3 to fbdev tree.

Nice to see this cleanup, thanks.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
