Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970514AbeCSSu2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965158AbeCSSuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:50:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD4A21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 19 Mar 2018 13:50:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] PCI/VPD: Encapsulate VPD stuff in vpd.c
Message-ID: <20180319185018.GC77194@bhelgaas-glaptop.roam.corp.google.com>
References: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 05:26:14PM -0500, Bjorn Helgaas wrote:
> This is strictly cleanup, not intended to change or fix anything.
> 
> Move all the VPD-related code and structures to drivers/pci/vpd.c.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI/VPD: Move VPD access code to vpd.c
>       PCI/VPD: Move VPD sysfs code to vpd.c
>       PCI/VPD: Move VPD quirks to vpd.c
>       PCI/VPD: Move VPD structures to vpd.c

Applied to pci/vpd for v4.17.
