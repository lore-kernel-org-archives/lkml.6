Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162424AbeCAVz3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:55:29 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35710 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162136AbeCAVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:55:27 -0500
X-Google-Smtp-Source: AG47ELsIQtYFQhrgdjPpQ9KfV0uuQLvasxGGSOpZYZL4T7G4zSCrYGKTxm6YxjQLZZUXO7JyReowtw==
Date: Thu, 1 Mar 2018 15:55:25 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] dt-bindings: arm: tegra: Document #reset-cells
 property of the Tegra20 MC
Message-ID: <20180301215525.tufu6qeikvfueauu@rob-hp-laptop>
References: <cover.1519141896.git.digetx@gmail.com>
 <c16e37ca23b7a3c53d121ba85889bb6f35576557.1519141896.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16e37ca23b7a3c53d121ba85889bb6f35576557.1519141896.git.digetx@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:25:16PM +0300, Dmitry Osipenko wrote:
> Memory Controller has a memory client "hot reset" functionality, which
> resets the DMA interface of a memory client, so MC is a reset controller.
> Documentation the new property.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt      | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
