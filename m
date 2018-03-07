Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeCGKm1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:42:27 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:43299 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeCGKm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:42:26 -0500
X-Google-Smtp-Source: AG47ELuzujGwhF980lVm5J0Jh5wXUwhfaiFhEcgif7i2o1o7fIN/N2yyNZFyPEpWqzv9OTz+71An3g==
Date: Wed, 7 Mar 2018 19:42:21 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Greentime Hu <green.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com,
        sfr@canb.auug.org.au, peterz@infradead.org, pmladek@suse.com
Subject: Re: [PATCH] nds32: To use the generic dump_stack()
Message-ID: <20180307104221.GB505@jagdpanzerIV>
References: <20180307101011.28689-1-greentime@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307101011.28689-1-greentime@andestech.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/18 18:10), Greentime Hu wrote:
> 
> Use the generic dump_stack() instead of nds32 one because they are doing
> the same thing.
> 
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
