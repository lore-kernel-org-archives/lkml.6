Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCLIAX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:00:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeCLIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:00:21 -0400
Date: Mon, 12 Mar 2018 01:00:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 02/13] PCI/PM: Move pcie_clear_root_pme_status() to
 core
Message-ID: <20180312080021.GB10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062200018.77693.9632596426168244205.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152062200018.77693.9632596426168244205.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 01:00:00PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Move pcie_clear_root_pme_status() from the port driver to the PCI core so
> it will be available even when the port driver isn't present.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
