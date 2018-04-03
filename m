Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbeDCXcP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:32:15 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36945 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeDCXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:32:13 -0400
X-Google-Smtp-Source: AIpwx4/Q19txiUMrKrh4HgwBRbpDvoSEengHedT474FMDFlZyazAjcUp+npmOW2s4H1eXMw2rGlcvQ==
Subject: Re: [PATCH 00/12] SWIM driver fixes
To: Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bdeed6f8-674a-3700-1510-c574da676d81@kernel.dk>
Date: Tue, 3 Apr 2018 17:32:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/18 7:41 PM, Finn Thain wrote:
> This patch series has fixes for bugs in the SWIM floppy disk controller
> driver, including an oops and a soft lockup.
> 
> There are also patches to add support for SWIM devices connected to IOPs.
> 
> Geert, would you please take this series through the m68k tree once the
> necessary "acked-by" tags arrive?
> 
> Jens, I've Cc'd you too because there's no official maintainer for
> drivers/block/swim.c and none for the drivers/block/ directory either.

The latter should just be added to the BLOCK LAYER entry.

> The series could be separated into m68k patches and block driver patches
> and sent through different trees if that's preferred.

I can take the block bits.


-- 
Jens Axboe
