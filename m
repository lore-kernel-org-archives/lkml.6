Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756117AbeDXFq1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:46:27 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:32979 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755954AbeDXFqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:46:23 -0400
X-Google-Smtp-Source: AIpwx49PaavVKlcgw98DeiF8jhNHVSo72RLRl5OKXL01vxeC1i9eUtX2pDrIFkE33L/2sXaf4bHaQQ==
Date: Tue, 24 Apr 2018 06:46:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rhyland Klein <rklein@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65911-comparator: Fix a build error
Message-ID: <20180424054620.qdgij3qsvdeitmh6@dell>
References: <20180420085938.ymf2jc46dswylxh4@mwanda>
 <20180420092105.GA28058@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420092105.GA28058@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Dan Carpenter wrote:

> In 2012, we changed the tps65910 API and fixed most drivers but forgot
> to update this one.
> 
> Fixes: 3f7e82759c69 ("mfd: Commonize tps65910 regmap access through header")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
