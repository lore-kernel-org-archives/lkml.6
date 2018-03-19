Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeCSO4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:56:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeCSO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:56:37 -0400
Date: Mon, 19 Mar 2018 15:56:24 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
In-Reply-To: <20180319103826.12853-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1803191556140.2010@nanos.tec.linutronix.de>
References: <20180319103826.12853-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Christoph Hellwig wrote:

> Hi all,
> 
> this series switches the x86 code the the dma-direct implementation
> for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> getting rid of the special ops for the AMD memory encryption case and
> the STA2x11 SOC.  The generic implementations are based on the x86
> code, so they provide the same functionality.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
