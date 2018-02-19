Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeBSSeJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:34:09 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45969 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753326AbeBSSeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:34:07 -0500
X-Google-Smtp-Source: AH8x227o8SVvzMDWHYb/t842CzW1FxLnswQg2wz818wsYLnkBX1YlkKZvTCDdETeohdPGv8sLB8L1g==
Date: Mon, 19 Feb 2018 12:34:05 -0600
From: Rob Herring <robh@kernel.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/2] dt-bindings/interrupt-controller: pdc: describe
 PDC device binding
Message-ID: <20180219183405.us2qjjza7sveahay@rob-hp-laptop>
References: <20180215212742.4675-1-ilina@codeaurora.org>
 <20180215212742.4675-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215212742.4675-3-ilina@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:27:42PM -0700, Lina Iyer wrote:
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
