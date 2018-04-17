Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeDQJNV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:13:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55243 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeDQJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:13:19 -0400
Date: Tue, 17 Apr 2018 11:13:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: x86@kernel.org, iommu@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: remove pci-nommu.c
In-Reply-To: <20180416124442.13831-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1804171112190.1694@nanos.tec.linutronix.de>
References: <20180416124442.13831-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Christoph Hellwig wrote:

> The commit that switches x86 to dma_direct_ops stopped using and building
> this file, but accidentally left it in the tree.  Remove it.

There is also stale documentation in

      Documentation/x86/x86_64/boot-options.txt

which mentiones that file. Could you please have a look and update that as
well?

Thanks,

	tglx
