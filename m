Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeCNIym (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:54:42 -0400
Received: from verein.lst.de ([213.95.11.211]:34615 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbeCNIyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:54:40 -0400
Date: Wed, 14 Mar 2018 09:54:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
Subject: Re: [pci PATCH v6 2/5] virtio_pci: Add support for unmanaged
        SR-IOV on virtio_pci devices
Message-ID: <20180314085438.GB28796@lst.de>
References: <20180313212508.3553.65326.stgit@localhost.localdomain> <20180313212855.3553.97762.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313212855.3553.97762.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
