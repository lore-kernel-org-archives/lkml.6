Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeCLH77 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:59:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeCLH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:59:57 -0400
Date: Mon, 12 Mar 2018 00:59:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 01/13] PCI/portdrv: Merge pcieport_if.h into portdrv.h
Message-ID: <20180312075953.GA10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062199471.77693.15585860566110984931.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152062199471.77693.15585860566110984931.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 12:59:54PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pcieport_if.h contained the interfaces to register port service driver,
> e.g., pcie_port_service_register().  portdrv.h contained internal data
> structures of the port driver.
> 
> I don't think it's worth keeping those files separate, since both headers
> and their users are all inside the PCI core.
> 
> Merge pcieport_if.h directly in drivers/pci/pcie/portdrv.h and update the
> users to include that instead.

Looks good to me.  I always found the old struture rather confusing..

Reviewed-by: Christoph Hellwig <hch@lst.de>
