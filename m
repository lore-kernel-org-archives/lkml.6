Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966239AbeEYLQo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:16:44 -0400
Received: from smtp97.ord1c.emailsrvr.com ([108.166.43.97]:60784 "EHLO
        smtp97.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965906AbeEYLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:16:43 -0400
X-Auth-ID: siepeng@mev.co.uk
X-Sender-Id: siepeng@mev.co.uk
Subject: Re: [PATCH] staging: comedi: comedidev.h: Fix SPDX-License-Identifier
 tag style
To: Nishad Kamdar <nishadkamdar@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180524174436.GA10724@nishad>
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <a53f7415-2638-b761-b880-e99ef8e6d4c5@mev.co.uk>
Date: Fri, 25 May 2018 12:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524174436.GA10724@nishad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 18:44, Nishad Kamdar wrote:
> Replace // SPDX-License-Identifier: GPL-2.0+ by
> /* SPDX-License-Identifier: GPL-2.0+ */ as per licensing rule
> for C header files. Issue found by checkpatch. Part of
> Eudyptula Challenge.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>   drivers/staging/comedi/comedidev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
> index f3474a4ba69e..c54ac94d89d2 100644
> --- a/drivers/staging/comedi/comedidev.h
> +++ b/drivers/staging/comedi/comedidev.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * comedidev.h
>    * header file for kernel-only structures, variables, and constants
> 

That looks fine thanks.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
