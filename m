Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeDBOUg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:20:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:24145 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeDBOUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:20:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,395,1517904000";
   d="scan'208";a="42749982"
Date: Mon, 2 Apr 2018 08:23:08 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>, Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v1] PCI/DPC: Rename from pcie-dpc.c to dpc.c.
Message-ID: <20180402142308.GD28945@localhost.localdomain>
References: <152253566671.104119.5361437405172766528.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152253566671.104119.5361437405172766528.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 05:34:26PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename from pcie-dpc.c to dpc.c.  The path "drivers/pci/pcie/pcie-dpc.c"
> has more occurrences of "pci" than necessary.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good.

Acked-by: Keith Busch <keith.busch@intel.com>
