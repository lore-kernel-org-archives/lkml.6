Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeEOPem (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:34:42 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33022 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbeEOPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:34:40 -0400
X-Google-Smtp-Source: AB8JxZp/OREiagUj+XHMLYY3FVW/th/Y0EXd3BN1StSKnsLMQyVlCmw7L/+9jn96SbT4lsRuxxIACg==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jan Kiszka'" <jan.kiszka@siemens.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: "'Vladimir Zapolskiy'" <vladimir_zapolskiy@mentor.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com> <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 4/8] PCI: Replace dev_node parameter of of_pci_get_host_bridge_resources with device
Date: Tue, 15 May 2018 11:34:38 -0400
Message-ID: <000101d3ec62$3ca4f4b0$b5eede10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHv8WjU+LO0eWxfJL86NrIpwhHMqAEd3Xdqo+/yfEA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 15, 2018 5:07 AM, Jan Kiszka wrote:
> 
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Another step towards a managed version of
> of_pci_get_host_bridge_resources(): Feed in the underlying device,
> rather than just the OF node. This will allow to use managed resource
> allocation internally later on.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/host/pci-aardvark.c        | 5 ++---
>  drivers/pci/host/pci-ftpci100.c        | 4 ++--
>  drivers/pci/host/pci-v3-semi.c         | 3 ++-
>  drivers/pci/host/pci-versatile.c       | 3 +--
>  drivers/pci/host/pci-xgene.c           | 3 ++-
>  drivers/pci/host/pcie-altera.c         | 5 ++---
>  drivers/pci/host/pcie-iproc-platform.c | 4 ++--
>  drivers/pci/host/pcie-rcar.c           | 5 ++---
>  drivers/pci/host/pcie-rockchip.c       | 4 ++--
>  drivers/pci/host/pcie-xilinx-nwl.c     | 4 ++--
>  drivers/pci/host/pcie-xilinx.c         | 4 ++--
>  drivers/pci/of.c                       | 9 +++++----
>  include/linux/of_pci.h                 | 4 ++--
>  14 files changed, 29 insertions(+), 30 deletions(-)
> 
