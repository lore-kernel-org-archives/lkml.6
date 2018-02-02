Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeBBSxQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:53:16 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:55975 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBBSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:53:05 -0500
Date: Fri, 2 Feb 2018 10:53:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Benjamin Serebrin <serebrin@google.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
Message-ID: <20180202185301.GA8232@infradead.org>
References: <1517438756.3715.108.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517438756.3715.108.camel@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've got patches pending to replace all that code with
dma_direct_alloc, which will do the right thing.  They were
submitted for 4.16, and I will resend them after -rc1.
