Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeFEPti (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:49:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42807 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFEPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:49:35 -0400
X-Google-Smtp-Source: ADUXVKIdGZYJtXaIS8aF4bV98szOc+b+nEpP048utwFJ1WisK+SPFuz+fTX9UluMZTLTsaUErNekVA==
Date: Tue, 5 Jun 2018 09:49:32 -0600
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 3/4] clk: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180605154932.GA20204@rob-hp-laptop>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <da121dede6d79460c5653a5bc360d413cb988c74.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da121dede6d79460c5653a5bc360d413cb988c74.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:18:53PM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC clock output.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../bindings/clock/rohm,bd71837-clock.txt          | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> new file mode 100644
> index 000000000000..771acfe34114
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> @@ -0,0 +1,38 @@
> +ROHM BD71837 Power Management Integrated Circuit clock bindings

This needs to be added to the MFD doc. One node should be covered by at 
most 1 document.

Rob
