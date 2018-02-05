Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeBEGJH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:09:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:47091 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbeBEGIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:32 -0500
X-Google-Smtp-Source: AH8x224DmcGQDyyFdmLMf7MMGn9QmFxpQca+xbOdwz2VC2KZDzmD12TTEXmVrY/BWqrEOoNm8kypHQ==
Date: Mon, 5 Feb 2018 00:08:30 -0600
From: Rob Herring <robh@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: MediaTek: Correct the
 interrupt-map properties
Message-ID: <20180205060830.svkrwnn6wzuig7ns@rob-hp-laptop>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:41:50PM +0800, Ryder Lee wrote:
> Move the interrupt-map properties from the child nodes to the root node
> and update each entry accordingly.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt      | 28 ++++++++++++----------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
