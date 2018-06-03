Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeFCFJq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 01:09:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeFCFJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 01:09:44 -0400
Subject: Re: [PATCH v2] exec: binfmt_misc: update reference to documentation
To: tomkpz@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <20180603044935.18011-1-tomKPZ@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bd9b4eea-2b62-34ad-6a92-40846fdcabd5@infradead.org>
Date: Sat, 2 Jun 2018 22:09:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180603044935.18011-1-tomKPZ@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2018 09:49 PM, tomkpz@gmail.com wrote:
> From: Thomas Anderson <tomKPZ@gmail.com>
> 
> Documentation/binfmt_misc.txt was moved to
> Documentation/admin-guide/binfmt-misc.rst in 9d85025b.  This change
> updates a reference to the file.
> 
> Signed-off-by: Thomas Anderson <tomKPZ@gmail.com>

Al,
I see a similar patch from Tom Saeger <tom.saeger@oracle.com> last Sept-27-2017
and also one from Henning Schild <henning@hennsch.de> last Sept-2017.

I also see a reply that Jon Corbet merged one of those (Tom's I think),
but it appears to still be needed...

Jon?

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


-- 
~Randy
