Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeCTJEE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:04:04 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37611 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbeCTJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:03:55 -0400
X-Google-Smtp-Source: AG47ELthslpkjYpEcaKBUkLSgQotP4U88YPOFCyOAMetNkD0PsinPhkf5tkw/N8zulsn3j4+2Uyftg==
Date: Tue, 20 Mar 2018 10:03:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Message-ID: <20180320090351.2qnwcsauhodrqxdj@gmail.com>
References: <20180319103826.12853-1-hch@lst.de>
 <20180319152737.GK1110@char.us.oracle.com>
 <20180319152840.GA28041@lst.de>
 <20180320083751.nrpt64dsmpqbhzc6@gmail.com>
 <20180320084412.GA16337@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320084412.GA16337@lst.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Mar 20, 2018 at 09:37:51AM +0100, Ingo Molnar wrote:
> > > git://git.infradead.org/users/hch/misc.git dma-direct-x86
> > 
> > Btw., what's the upstreaming route for these patches?
> > 
> > While it's a multi-arch series it's all pretty x86-heavy as well so we can host it 
> > in -tip (in tip:core/dma or such), but feel free to handle it yourself as well:
> > 
> >   Reviewed-by: Ingo Molnar <mingo@kernel.org>
> 
> Either way is fine with me.  The dma-mapping tree is pretty light this
> cycles, so I don't expect any conflicts.  If you want it feel free to grab
> it, otherwise I'll queue it up.

Ok, I picked your series up into tip:core/dma:

 - added the newly arrived Tested-by's and Reviewed-by's
 - some minor edits to titles/changelogs, no functional changes

will push it all out after testing.

Thanks,

	Ingo
