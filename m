Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbeDKUj0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 16:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756157AbeDKUjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 16:39:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD8C21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Wed, 11 Apr 2018 15:39:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com, kwankhede@nvidia.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] sample: vfio mdev display - guest driver
Message-ID: <20180411203922.GA145698@bhelgaas-glaptop.roam.corp.google.com>
References: <20180409103513.8020-1-kraxel@redhat.com>
 <20180409103513.8020-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409103513.8020-3-kraxel@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:35:12PM +0200, Gerd Hoffmann wrote:
> Guest fbdev driver for CONFIG_SAMPLE_VFIO_MDEV_MDPY.

> +	dev_info(&pdev->dev, "mdpy found: %dx%d framebuffer\n",
> +		 width, height);

You can now use

  pci_info(pdev, "mdpy found ...")

if it seems worthwhile to you.
