Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeDPJMl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:12:41 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:39397 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeDPJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:12:40 -0400
X-Google-Smtp-Source: AIpwx480nlkWI3lyDN6ZCufHddTQU/hJZYbyfYEKW1lweKnJSlDFs+2tftXV4BGJowm5nNARB4gItQ==
Date: Mon, 16 Apr 2018 18:12:34 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] zram memory tracking
Message-ID: <20180416091234.GA64023@rodete-desktop-imager.corp.google.com>
References: <20180416033110.32361-1-minchan@kernel.org>
 <20180416074218.GA27769@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416074218.GA27769@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 04:42:18PM +0900, Sergey Senozhatsky wrote:
> On (04/16/18 12:31), Minchan Kim wrote:
> > Minchan Kim (4):
> >   zram: correct flag name of ZRAM_ACCESS
> >   zram: mark incompressible page as ZRAM_HUGE
> >   zram: record accessed second
> >   zram: introduce zram memory tracking
> 
> Looks OK to me. After Randy's comments addressed:
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Thanks for the review, Sergey!
