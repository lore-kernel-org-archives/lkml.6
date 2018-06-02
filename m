Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeFBWQr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 18:16:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeFBWQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 18:16:46 -0400
Subject: Re: [PATCH] exec: binfmt_misc: update reference to documentation
To: tomkpz@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180602201115.3426-1-tomKPZ@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ff0bc0a-7507-871e-5bf2-145c983e44a0@infradead.org>
Date: Sat, 2 Jun 2018 15:16:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180602201115.3426-1-tomKPZ@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2018 01:11 PM, tomkpz@gmail.com wrote:
> From: tomKPZ <tomKPZ@gmail.com>
> 
> Documentation/binfmt_misc.txt was moved to
> Documentation/admin-guide/binfmt-misc.rst in 9d85025b.  This change
> updates a reference to the file.

Please see Documentation/process/submitting-patches.rst, about Signed-off-by:

then you just add a line saying::

	Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions.)



> ---
>  fs/binfmt_misc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index a41b48f82a70..5ad89b838c79 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -4,7 +4,8 @@
>   * Copyright (C) 1997 Richard Günther
>   *
>   * binfmt_misc detects binaries via a magic or filename extension and invokes
> - * a specified wrapper. See Documentation/binfmt_misc.txt for more details.
> + * a specified wrapper. See Documentation/admin-guide/binfmt-misc.rst for more
> + * details.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 

thanks,
-- 
~Randy
