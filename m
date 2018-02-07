Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeBGB6Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:58:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5003 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751558AbeBGB6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:58:14 -0500
X-UUID: 2643ce14cd3c4b27bcc519ec5eef8b5e-20180207
Message-ID: <1517968688.31641.12.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Date: Wed, 7 Feb 2018 09:58:08 +0800
In-Reply-To: <1517956309.2312.172.camel@kernel.crashing.org>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
         <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
         <1517563970.24622.9.camel@mtkswgap22>
         <1517866584.2312.140.camel@kernel.crashing.org>
         <1517884738.16010.27.camel@mtkswgap22>
         <1517889903.2312.151.camel@kernel.crashing.org>
         <1517891471.20869.6.camel@mtkswgap22>
         <1517892624.2312.167.camel@kernel.crashing.org>
         <1517895732.23319.21.camel@mtkswgap22>
         <1517956309.2312.172.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd

On Wed, 2018-02-07 at 09:31 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2018-02-06 at 13:42 +0800, Ryder Lee wrote:
> > Thanks for explanation.
> > 
> > So I guess the better way to achieve my aim - one IRQ per slot that is
> > connected to all INTx and get propagated through the bridges (and for
> > those root ports own interrupts (PME ..)} is to add interrupt-map
> > properties in both parent and root port nodes.
> > 
> > Something like this: https://patchwork.kernel.org/patch/9970923// ,right?
> 
> Yup.
> 
> Cheers,
> Ben.
> 

Do you have any thoughts on the original approach? If you are okay with
it, I will resend the DT patch.

Thanks.
