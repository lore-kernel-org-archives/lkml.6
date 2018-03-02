Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427670AbeCBPZb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:25:31 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42688 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427160AbeCBPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:25:25 -0500
X-Google-Smtp-Source: AG47ELtUFV5aMB9Caz4wE8uyIhtZrgIhrhbXX6BZeE8CL+4Z5WQYYVtGpE4uO44s0JowKYidOZL7Eg==
Date: Fri, 2 Mar 2018 09:25:23 -0600
From: Rob Herring <robh@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        mark.rutland@arm.com, manabian@gmail.com, dinguyen@kernel.org,
        will.deacon@arm.com, xuwei5@hisilicon.com
Subject: Re: [PATCH 2/6] mmc: dw_mmc: remove the deprecated "num-slots"
Message-ID: <20180302152523.577q4ru466nt2gvo@rob-hp-laptop>
References: <20180223064138.18401-1-jh80.chung@samsung.com>
 <CGME20180223064140epcas2p41a734737c3fe7373329a94f485c21fd4@epcas2p4.samsung.com>
 <20180223064138.18401-2-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223064138.18401-2-jh80.chung@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:41:34PM +0900, Jaehoon Chung wrote:
> 'num-slots' property had already deprecated.
> Remove the 'nom-slots' property that is kept to maintain the compatibility.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
>  drivers/mmc/host/dw_mmc-pci.c                              | 1 -
>  drivers/mmc/host/dw_mmc.c                                  | 4 ----
>  drivers/mmc/host/dw_mmc.h                                  | 3 ---
>  4 files changed, 13 deletions(-)

Normally I'd say you need to wait some time after updating the dts 
files, but given that all the users are 1 slot I think this is fine.

For this and the rest of the series:

Reviewed-by: Rob Herring <robh@kernel.org>
