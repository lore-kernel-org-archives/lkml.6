Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932484AbeC0QpJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:45:09 -0400
Received: from verein.lst.de ([213.95.11.211]:41324 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755713AbeC0QpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:45:07 -0400
Date: Tue, 27 Mar 2018 18:45:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dma_zalloc_coherent broken with
        57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7
Message-ID: <20180327164505.GA10522@lst.de>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi> <20180327143341.GA4968@lst.de> <alpine.LFD.2.21.1803271717580.26440@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1803271717580.26440@schleppi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 05:24:10PM +0200, Sebastian Ott wrote:
> What do you mean by current implementations? Arch specific code? At least
> on s390 we don't do that. dma-mapping.h doesn't do it either.

The arch implementations should do it.  Seems like s390 and potentially
a few others don't.  I'm a little slow due to a cast on one arm, but I'll
do an audit and will fix up anything I'll find.
