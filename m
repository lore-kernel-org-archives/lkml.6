Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeDJJZl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:25:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40651 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeDJJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:25:39 -0400
X-Google-Smtp-Source: AIpwx49rTMI++sckt/AZYeiLMLQ70oQOF5PpmMJZjSUVZ8Ldxq9RvlncFcW0Nz2mLlpDishitsR/9g==
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Add DMA support for direct
 mode reads
To: Vignesh R <vigneshr@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20180410081910.858-1-vigneshr@ti.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <70777773-8ade-bd42-e75a-6d5d9c3e50a2@gmail.com>
Date: Tue, 10 Apr 2018 11:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410081910.858-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 10:19 AM, Vignesh R wrote:
> Add support to use DMA over memory mapped reads in direct mode. This
> helps in reducing CPU usage from ~100% to ~10% when reading data from
> flash. For non-DMA'able/vmalloc'd buffers, driver just falls back to CPU
> based memcpy.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
