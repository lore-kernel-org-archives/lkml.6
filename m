Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeCONsV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:48:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53509 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeCONsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:48:20 -0400
Date: Thu, 15 Mar 2018 14:48:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] x86: use generic swiotlb_ops
In-Reply-To: <20180315133530.GA17956@lst.de>
Message-ID: <alpine.DEB.2.21.1803151446420.1525@nanos.tec.linutronix.de>
References: <20180314175213.20256-1-hch@lst.de> <20180314175213.20256-5-hch@lst.de> <alpine.DEB.2.21.1803150956300.1525@nanos.tec.linutronix.de> <20180315115426.GB16210@lst.de> <alpine.DEB.2.21.1803151351280.1525@nanos.tec.linutronix.de>
 <20180315133530.GA17956@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Christoph Hellwig wrote:

> On Thu, Mar 15, 2018 at 01:52:14PM +0100, Thomas Gleixner wrote:
> > Yeah, I know that the standard defines it, but that doesn't mean it makes
> > sense. At least not to me.
> 
> It makes sense in that it logically is a boolean but we only want
> to allocate 1 bit for it, unlike the normal ABI allocations of at
> least a byte.
>
> Either way, tell me what you want it changed to, and I'll do it.

I'd prefer either bool or a regular bitfield, but I can live with the
boolean bitfield as well.
