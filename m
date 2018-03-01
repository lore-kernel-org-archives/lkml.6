Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162357AbeCAVxM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:53:12 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43393 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162122AbeCAVxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:53:10 -0500
X-Google-Smtp-Source: AG47ELtRT1KNICk9nRNCrGioA+8ho4WH1vc6norWBjCm3hrkIPCpzbrmVqoWakMZKXhwvydN/bmKNQ==
Date: Thu, 1 Mar 2018 15:53:09 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] dt-bindings: arm: tegra: Remove duplicated
 Tegra30+ MC binding
Message-ID: <20180301215309.v6gk77j4trwkpn7j@rob-hp-laptop>
References: <cover.1519141896.git.digetx@gmail.com>
 <0d1b4a840954796f319621e481ec1a90baee98cc.1519141896.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1b4a840954796f319621e481ec1a90baee98cc.1519141896.git.digetx@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:25:14PM +0300, Dmitry Osipenko wrote:
> There are two bindings for the same Memory Controller. One of the bindings
> became obsolete long time ago and probably was left unnoticed, remove it
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra30-mc.txt           | 18 ------------------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-mc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
