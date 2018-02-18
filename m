Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBRXvP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:51:15 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44311 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeBRXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:51:13 -0500
X-Google-Smtp-Source: AH8x224bW6a7ynt2sFa8ODc0M1bEPneTQl4IicL41I3HBocrIN9S8SbVjWFr0qe1nV91yYVNkwi2OQ==
Date: Sun, 18 Feb 2018 17:51:11 -0600
From: Rob Herring <robh@kernel.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings/interrupt-controller: pdc: descibe
 PDC device binding
Message-ID: <20180218235111.ih5fnrjqseasjpsw@rob-hp-laptop>
References: <20180209165735.19151-1-ilina@codeaurora.org>
 <20180209165735.19151-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209165735.19151-3-ilina@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 09:57:35AM -0700, Lina Iyer wrote:
> From: Archana Sathyakumar <asathyak@codeaurora.org>
> 
> Add device binding documentation for the PDC Interrupt controller on
> QCOM SoC's like the SDM845. The interrupt-controller can be used to
> sense edge low interrupts and wakeup interrupts when the GIC is
> non-operational.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../bindings/interrupt-controller/qcom,pdc.txt     | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
