Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755907AbeCSP2n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:28:43 -0400
Received: from verein.lst.de ([213.95.11.211]:59313 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755726AbeCSP2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:28:41 -0400
Date: Mon, 19 Mar 2018 16:28:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Message-ID: <20180319152840.GA28041@lst.de>
References: <20180319103826.12853-1-hch@lst.de> <20180319152737.GK1110@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319152737.GK1110@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 11:27:37AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 19, 2018 at 11:38:12AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series switches the x86 code the the dma-direct implementation
> > for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> > getting rid of the special ops for the AMD memory encryption case and
> > the STA2x11 SOC.  The generic implementations are based on the x86
> > code, so they provide the same functionality.
> 
> I need to test this on my baremertal and Xen setup - and I lost your
> git repo URL - any chance you mention point out to me so I can
> kick of a build?

git://git.infradead.org/users/hch/misc.git dma-direct-x86
