Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDQPis (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:38:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:57152 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbeDQPiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:38:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="34943680"
Date: Tue, 17 Apr 2018 21:13:12 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tanmay Inamdar <tinamdar@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH] dt-bindings: more status property removal from examples
Message-ID: <20180417154312.GW6014@localhost>
References: <20180417135732.10100-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417135732.10100-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 08:57:32AM -0500, Rob Herring wrote:
> Whack-a-mole some more occurrences of status in examples.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Tanmay Inamdar <tinamdar@apm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt       | 1 -
>  Documentation/devicetree/bindings/dma/ti-edma.txt     | 1 -

These:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
