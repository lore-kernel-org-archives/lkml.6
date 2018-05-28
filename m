Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeE1F1k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:27:40 -0400
Received: from verein.lst.de ([213.95.11.211]:46739 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbeE1F1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:27:37 -0400
Date: Mon, 28 May 2018 07:33:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh
        SONIC based ethernet
Message-ID: <20180528053338.GA3195@lst.de>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <20180527041505.GB31985@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527041505.GB31985@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 09:15:05PM -0700, Guenter Roeck wrote:
> Good point. Maybe it would be better to limit the warning to SMP systems
> instead of (unnecessarily) fixing drivers all over the place ?

No.  The coherent_dma_mask is the mask used for dma_alloc_coherent and
dma_alloc_attrs.  It has nothing to do with cache coherent in SMP
systems.
