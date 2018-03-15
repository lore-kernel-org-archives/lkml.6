Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeCOEQs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:16:48 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45251 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOEQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:16:46 -0400
X-Google-Smtp-Source: AG47ELsGxPa3sduEil0zSMscFuOxeOPIB26XKOC1C/3FdRwup6E7U/yeZwFLYcINsD4DocxiPdL5hMcyVWeKR1xosTw=
MIME-Version: 1.0
In-Reply-To: <20180304065038.28373-1-nick.desaulniers@gmail.com>
References: <20180304065038.28373-1-nick.desaulniers@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Wed, 14 Mar 2018 21:16:44 -0700
Message-ID: <CAH7mPvjoaDiJmnj9CPNaKD8R=P3+0ESMetxMCWEq6=FgyHEfEg@mail.gmail.com>
Subject: Re: [PATCH] certs/blacklist: fix const confusion
To: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bumping for review

On Sat, Mar 3, 2018 at 10:50 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes commit 2be04df5668d ("certs/blacklist_nohashes.c: fix const confusion
> in certs blacklist")
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  certs/blacklist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/certs/blacklist.h b/certs/blacklist.h
> index 150d82da8e99..1efd6fa0dc60 100644
> --- a/certs/blacklist.h
> +++ b/certs/blacklist.h
> @@ -1,3 +1,3 @@
>  #include <linux/kernel.h>
>
> -extern const char __initdata *const blacklist_hashes[];
> +extern const char __initconst *const blacklist_hashes[];
> --
> 2.14.1
>
