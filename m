Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbeD0OvV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:51:21 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36220 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934285AbeD0OvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:51:18 -0400
X-Google-Smtp-Source: AB8JxZomu4eiEpRwtiK3ZyE/exOTsKOKoslevhWOWBqHmSL+AiT8zaYUSx6aUK7AbDezsw94TxM+Rg==
Date: Fri, 27 Apr 2018 09:51:16 -0500
From: Rob Herring <robh@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaotong.lu@spreadtrum.com
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx
 vibrator documentation
Message-ID: <20180427145116.rhjs5vqg6czdexee@rob-hp-laptop>
References: <e2f85ec0b1fb66baa41dd85bb31e8113e23c704b.1524733425.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f85ec0b1fb66baa41dd85bb31e8113e23c704b.1524733425.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 05:12:33PM +0800, Baolin Wang wrote:
> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> 
> This patch adds the binding documentation for Spreadtrum SC27xx series
> vibrator device.
> 
> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - No updates.
> 
> Changes since v1:
>  - No updates.
> ---
>  .../bindings/input/sprd,sc27xx-vibra.txt           |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
> new file mode 100644
> index 0000000..92ead29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
> @@ -0,0 +1,12 @@
> +Spreadtrum SC27xx PMIC Vibrator
> +
> +Required properties:
> +- compatible: should be "sprd,sc27xx-vibrator".
> +- reg: address of vibrator control register.
> +
> +Example :
> +
> +vibrator@eb4 {
> +	compatible = "sprd,sc27xx-vibrator";
> +	reg = <0xeb4>;

What bus is this on? A mmio bus needs a length. Is this part of some 
other block?

Rob
