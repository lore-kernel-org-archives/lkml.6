Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDPHmZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:42:25 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:39932 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeDPHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:42:23 -0400
X-Google-Smtp-Source: AIpwx4/GOn9Xy/m4XAbOBOdl/uG4y8JBbBaGCEkA90bQDjl6QWNQMT4e4DCURfwkDAVZbV05Jiqv5g==
Date: Mon, 16 Apr 2018 16:42:18 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v4 0/4] zram memory tracking
Message-ID: <20180416074218.GA27769@jagdpanzerIV>
References: <20180416033110.32361-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416033110.32361-1-minchan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/16/18 12:31), Minchan Kim wrote:
> Minchan Kim (4):
>   zram: correct flag name of ZRAM_ACCESS
>   zram: mark incompressible page as ZRAM_HUGE
>   zram: record accessed second
>   zram: introduce zram memory tracking

Looks OK to me. After Randy's comments addressed:

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
