Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeCLIBt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:01:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeCLIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:01:47 -0400
Date: Mon, 12 Mar 2018 01:01:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 06/13] PCI/portdrv: Remove pcie_port_bus_type link
 order dependency
Message-ID: <20180312080147.GC10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062202196.77693.13201322126291517429.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152062202196.77693.13201322126291517429.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if ((driver->port_type != PCIE_ANY_PORT) &&
> +	    (driver->port_type != pci_pcie_type(pciedev->port)))

No need for the inner braces here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
