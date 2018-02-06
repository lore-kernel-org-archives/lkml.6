Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeBFXHb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:07:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:33295 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753302AbeBFXH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:07:29 -0500
Message-ID: <1517956309.2312.172.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Date: Wed, 07 Feb 2018 09:31:49 +1100
In-Reply-To: <1517895732.23319.21.camel@mtkswgap22>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
         <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
         <1517563970.24622.9.camel@mtkswgap22>
         <1517866584.2312.140.camel@kernel.crashing.org>
         <1517884738.16010.27.camel@mtkswgap22>
         <1517889903.2312.151.camel@kernel.crashing.org>
         <1517891471.20869.6.camel@mtkswgap22>
         <1517892624.2312.167.camel@kernel.crashing.org>
         <1517895732.23319.21.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 13:42 +0800, Ryder Lee wrote:
> Thanks for explanation.
> 
> So I guess the better way to achieve my aim - one IRQ per slot that is
> connected to all INTx and get propagated through the bridges (and for
> those root ports own interrupts (PME ..)} is to add interrupt-map
> properties in both parent and root port nodes.
> 
> Something like this: https://patchwork.kernel.org/patch/9970923// ,right?

Yup.

Cheers,
Ben.
