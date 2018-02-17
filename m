Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBQOGq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 09:06:46 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39408 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeBQOGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 09:06:44 -0500
X-Google-Smtp-Source: AH8x226FZJh6quuM4TLyzplsqy+U+9vVThdyTaSE0VdazKT4HrXY45LToA/iLmJCNQ1whTXbVhsgfFlq5Gv3yiQm+0s=
MIME-Version: 1.0
In-Reply-To: <20180217072011.GB16074@avx2>
References: <20180217072011.GB16074@avx2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 17 Feb 2018 16:06:42 +0200
Message-ID: <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc: use set_puts() at /proc/*/wchan
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 9:20 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>


> -               seq_printf(m, "%s", symname);
> +               seq_puts(m, symname);

While this might have no security concerns, the pattern might be
brainlessly used by some janitors and there would have security
implications.

-- 
With Best Regards,
Andy Shevchenko
