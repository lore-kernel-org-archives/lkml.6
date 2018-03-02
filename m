Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427356AbeCBPWq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:22:46 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35668 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423755AbeCBPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:22:44 -0500
X-Google-Smtp-Source: AG47ELuSW3CUbsvnQl9A1p1y1DiZltIazS8KfXq1ps6XZiiB8km5D5gewvg3IFrdg7Ug1ywtEYK/iQ==
Date: Fri, 2 Mar 2018 09:22:42 -0600
From: Rob Herring <robh@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        mark.rutland@arm.com, manabian@gmail.com, dinguyen@kernel.org,
        will.deacon@arm.com, xuwei5@hisilicon.com
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
Message-ID: <20180302152242.lmnsy3b3ibrnshpv@rob-hp-laptop>
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223064138.18401-1-jh80.chung@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:41:33PM +0900, Jaehoon Chung wrote:
> 'clock-freq-min-max' property had already deprecated.
> Remove the 'clock-freq-min-max' property that is kept to maintain
> the compatibility.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt          |  4 ----
>  drivers/mmc/host/dw_mmc.c                                 | 15 ++++-----------
>  2 files changed, 4 insertions(+), 15 deletions(-)

In no way an endorsement that this is the right time to remove,

Reviewed-by: Rob Herring <robh@kernel.org>
