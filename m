Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeERI7z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:59:55 -0400
Received: from verein.lst.de ([213.95.11.211]:57868 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbeERI7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:59:52 -0400
Date: Fri, 18 May 2018 11:04:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 1/2] m68k: Set default dma mask for platform devices
Message-ID: <20180518090434.GC24436@lst.de>
References: <cc9b01d2b0e12938fe0e9581dd9d650ad3c4159c.1526551115.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9b01d2b0e12938fe0e9581dd9d650ad3c4159c.1526551115.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This implementation of arch_setup_pdev_archdata() differs from the
> powerpc one, in that this one avoids clobbering a device dma mask
> which has already been initialized.

I think your implementation should move into the generic implementation
in drivers/base/platform.c instead of being stuck in m68k.

Also powerpc probably wants fixing, but that's something left to the
ppc folks..
