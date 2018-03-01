Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162411AbeCAVzD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:55:03 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34129 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162136AbeCAVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:55:00 -0500
X-Google-Smtp-Source: AG47ELuEEVDIkwJ/wK+6C1x/jqOuQgi3ow1Uf/AAGd3kWfOnqKZH/U26nuBHdgiCOQaEDbNcsORfOg==
Date: Thu, 1 Mar 2018 15:54:57 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/15] dt-bindings: memory: tegra: Document
 #reset-cells property of the Tegra30 MC
Message-ID: <20180301215457.xaem7gblo2srez42@rob-hp-laptop>
References: <cover.1519141896.git.digetx@gmail.com>
 <cc137269e617947fe6b80629cb439ff17eec38a6.1519141896.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc137269e617947fe6b80629cb439ff17eec38a6.1519141896.git.digetx@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:25:15PM +0300, Dmitry Osipenko wrote:
> Memory Controller has a memory client "hot reset" functionality, which
> resets the DMA interface of a memory client. So MC is a reset controller
> in addition to IOMMU. Documentation the new property.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt     | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
