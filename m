Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbeBINqf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:46:35 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:59579 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753201AbeBINqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:46:31 -0500
Date: Fri, 9 Feb 2018 14:46:29 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "PCI: dwc: Clear MSI interrupt status after
 it is handled, not before"
Message-ID: <20180209134629.GA25931@axis.com>
References: <20180209120415.17590-1-vigneshr@ti.com>
 <20180209120415.17590-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209120415.17590-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:34:13PM +0530, Vignesh R wrote:
> Since commit 06e15e6883bed ("PCI: dwc: Clear MSI interrupt status after
> it is handled, not before"), MSI IRQ status in PCIE_MSI_INTR0_STATUS
> register is cleared after calling EP's IRQ handler.

Small nit, the SHA1 is actually:
8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled, not before")

Acked-by: Niklas Cassel <niklas.cassel@axis.com>
