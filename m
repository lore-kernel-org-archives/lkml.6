Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeBAVNX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:13:23 -0500
Received: from ozlabs.org ([103.22.144.67]:44569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbeBAVNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:13:16 -0500
Date: Fri, 2 Feb 2018 08:13:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180202081313.784358c6@canb.auug.org.au>
In-Reply-To: <20180201190033.GB63412@bhelgaas-glaptop.roam.corp.google.com>
References: <20180201105114.562aef46@canb.auug.org.au>
        <20180201085608.GA22568@axis.com>
        <20180201190033.GB63412@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, 1 Feb 2018 13:00:33 -0600 Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> I applied this resolution to the merge of lorenzo/pci/dwc.

Excellent, thanks.

-- 
Cheers,
Stephen Rothwell
