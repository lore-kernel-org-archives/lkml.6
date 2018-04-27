Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbeD0O0Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:26:16 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44946 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934205AbeD0O0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:26:13 -0400
X-Google-Smtp-Source: AB8JxZrAehsRniyhNORH9vVOLau4M+mqhT7y7SowFaTA96EqBbC/3t0EX6rD61AC6SaXCiiMHaadrQ==
Date: Fri, 27 Apr 2018 09:26:11 -0500
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 13/14] dt-bindings: sdhci-omap: Add pinctrl bindings
Message-ID: <20180427142611.n5qysqpc2cvfcmnw@rob-hp-laptop>
References: <20180427114723.2687-1-kishon@ti.com>
 <20180427114723.2687-14-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427114723.2687-14-kishon@ti.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 05:17:22PM +0530, Kishon Vijay Abraham I wrote:
> Add pinctrl binding rquired to get the mux mode and IODelay
> values from devicetree.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
