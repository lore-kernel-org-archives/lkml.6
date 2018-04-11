Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDKAGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:06:03 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:44058 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeDKAGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:06:02 -0400
X-Google-Smtp-Source: AIpwx487kZPyfQzmTRd4mlfWU7LtGcYoAVtVD8TpI4yYKEMCmQECynZCpBqESfkOmOLZRVemUDXojA==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com> <a28d463d04b198f51c64c1a7eb5b3f77da2d4ab9.1523266508.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <a28d463d04b198f51c64c1a7eb5b3f77da2d4ab9.1523266508.git.gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2 7/9] PCI: dwc: Replace lower into upper case characters
Date: Tue, 10 Apr 2018 20:05:59 -0400
Message-ID: <000001d3d128$dfa4e8a0$9eeeb9e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEaRjwvEF5/h3QMrbPVq+Y0x5xNJwIuUtxypVxSa8A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 9, 2018 5:41 AM, Gustavo Pimentel wrote:
> 
> Replaces lower into upper case characters in comments and debug printks.
> 
> This is an attempt to keep the messages coherent within the designware
> driver.
> 
> Also fixed code style on dw_pcie_irq_domain_free function.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>


> ---
> Change v1->v2:
> - Added an extra log description line about code style following Fabio
> Estevam suggestion.
> 
>  drivers/pci/dwc/pcie-designware-ep.c   | 16 ++++++++--------
>  drivers/pci/dwc/pcie-designware-host.c | 35 ++++++++++++++++++-----------
> -----
>  drivers/pci/dwc/pcie-designware.c      | 22 ++++++++++-----------
>  3 files changed, 38 insertions(+), 35 deletions(-)
> 

[.....]
