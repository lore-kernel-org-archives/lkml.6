Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeFDMzh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:55:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeFDMzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:55:36 -0400
Date: Mon, 4 Jun 2018 05:55:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180604125530.GA16378@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180604153558-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604153558-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:43:09PM +0300, Michael S. Tsirkin wrote:
> Another is that given the basic functionality is in there, optimizations
> can possibly wait until per-device quirks in DMA API are supported.

We have had per-device dma_ops for quite a while.
