Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeBGMnL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:43:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:32835 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753648AbeBGMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:43:10 -0500
X-UUID: ab031b8b815e4a17bdf73d274054570b-20180207
Message-ID: <1518007386.23115.6.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: MediaTek: Correct the
 interrupt-map properties
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date: Wed, 7 Feb 2018 20:43:06 +0800
In-Reply-To: <20180205060830.svkrwnn6wzuig7ns@rob-hp-laptop>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
         <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
         <20180205060830.svkrwnn6wzuig7ns@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, 2018-02-05 at 00:08 -0600, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 03:41:50PM +0800, Ryder Lee wrote:
> > Move the interrupt-map properties from the child nodes to the root node
> > and update each entry accordingly.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  .../devicetree/bindings/pci/mediatek-pcie.txt      | 28 ++++++++++++----------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Please ignore this patch as we think the original version is better than
this.  Sorry for the inconvenience.

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
