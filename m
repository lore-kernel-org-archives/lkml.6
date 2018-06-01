Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeFAKSc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:18:32 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43287 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFAKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:18:30 -0400
X-Google-Smtp-Source: ADUXVKILCfikNqm5qWuhUczTm11jLyzzXKgrhnqiMhJsp4MqWnkci3arZtObJIzs8KOMgFGqGmwQggvJ9lhR9yc+jTg=
MIME-Version: 1.0
In-Reply-To: <20180601004233.37822-6-keescook@chromium.org>
References: <20180601004233.37822-1-keescook@chromium.org> <20180601004233.37822-6-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:18:29 +0300
Message-ID: <CAHp75Vdgz7edHYnqyC9d0ciSwDDyMEF7Jwr1bgnBe-UvUqoUtg@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] lib: overflow: Add memory allocation overflow tests
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 3:42 AM, Kees Cook <keescook@chromium.org> wrote:
> Make sure that the memory allocators are behaving as expected in the face
> of overflows.

>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/mm.h>

A nit, can we keep it in order?

-- 
With Best Regards,
Andy Shevchenko
