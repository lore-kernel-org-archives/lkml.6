Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeDVGJm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 02:09:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:29798 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeDVGJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 02:09:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,310,1520924400";
   d="scan'208";a="45108627"
Date: Sun, 22 Apr 2018 11:43:28 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/15] dmaengine: pxa: use a dma slave map
Message-ID: <20180422061328.GT6014@localhost>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-2-robert.jarzmik@free.fr>
 <87604kz7mu.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87604kz7mu.fsf@belgarion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 09:23:05PM +0200, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > In order to remove the specific knowledge of the dma mapping from PXA
> > drivers, add a default slave map for pxa architectures.
> >
> > This won't impact MMP architecture, but is aimed only at all PXA boards.
> >
> > This is the first step, and once all drivers are converted,
> > pxad_filter_fn() will be made static, and the DMA resources removed from
> > device.c.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> 
> Vinod, could I have your ack please ?

Sure thing:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
