Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeBHUTt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:19:49 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34257 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeBHUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:19:47 -0500
X-Google-Smtp-Source: AH8x22644is1KKLy2eQijgjGpvZ74zz73FRRC6KhoA55gcGh2pqT2ZJlzmkfuF5BMLOa76/7hd6Gxg==
Date: Thu, 8 Feb 2018 14:19:45 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: rui.zhang@intel.com, edubezval@gmail.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunli Wang <shunli.wang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: add binding for MT7622 SoC
Message-ID: <20180208201945.pssycij3tmj7clfn@rob-hp-laptop>
References: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:11:51PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add devicetree bindings for MediaTek MT7622 thermal controller
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
