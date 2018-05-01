Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755404AbeEANYR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:24:17 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40338 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbeEANYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:24:15 -0400
X-Google-Smtp-Source: AB8JxZrcb4xUMyn08aVVxDR35mfnMVGplmTWXMsA7I3VTXiQxYPS3O/GdRcwH+1iF9JIN6HMGmwHzw==
Date: Tue, 1 May 2018 14:24:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180501132412.GO5147@dell>
References: <20180501094553.31545-1-lee.jones@linaro.org>
 <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
 <20180501131036.bm7rcujohxi5devs@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180501131036.bm7rcujohxi5devs@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2018, Dan Carpenter wrote:

> The background is that no one noticed that this driver stopped being
> buildable in 2012 until I fixed it last week.  This is the third
> proposed patch to fix the off by one.  All three patches fix the bug,
> but Lee refused to accept my style and I refused to use Lee's style...
> Absolutely *no way*!  LOL.  But really neither of us take it personally
> and we've met in person before and collaborate over email and get along.
> 
> This thread has been pretty amusing for me, but let's move on.  :P

+999

Plan is to let it sit for a week or so.  Give some more idle
passers-by to have their say.  Then I'll merge it regardless (/me
jokes).

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
