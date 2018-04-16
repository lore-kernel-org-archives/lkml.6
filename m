Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeDPVfG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:35:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46987 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPVfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:35:04 -0400
X-Google-Smtp-Source: AIpwx4/SgcZkkTEdQgJMYwO3WqTMDBdkEVbbSCuRnyi7q7GjsIficHivXeeL9XDuQyNz0MNADPkJng==
Date: Mon, 16 Apr 2018 16:35:03 -0500
From: Rob Herring <robh@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: artpec6: Add reset-gpios for PERST# control
Message-ID: <20180416213503.im3dfmbqnqho32w7@rob-hp-laptop>
References: <20180415185621.GR16746@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415185621.GR16746@axis.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 08:56:21PM +0200, Jesper Nilsson wrote:
> Some devices need an optional external gpio for controlling
> the PERST# signal to bring up for example a PCIe switch
> after a soft reset.
> 
> Without this, some boards (the ARTPEC-6 master devboard)
> would not get the PCIe link back after a soft reset.
> 
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
> ---
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt    |  4 ++++
>  drivers/pci/dwc/pcie-artpec6.c                       | 20 +++++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
