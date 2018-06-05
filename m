Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeFEPsD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:48:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41993 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeFEPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:48:00 -0400
X-Google-Smtp-Source: ADUXVKJ2v4pnDEVTlPB/lCD/Jcc/xzfIqj+THM2NDHjcbFKTY5lXbroGh/BUlLxWI0Ft8X4+VErgMQ==
Date: Tue, 5 Jun 2018 09:47:57 -0600
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 2/4] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180605154757.GA26812@rob-hp-laptop>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <6509bbe0238c20c16930c9f23d63656b1d5f4af2.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6509bbe0238c20c16930c9f23d63656b1d5f4af2.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:18:30PM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

I've replied on the prior version discussion. Please don't send new 
versions if the last one is still under discussion.

Rob
