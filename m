Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeCQEbY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 00:31:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55924 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeCQEbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 00:31:22 -0400
Date: Sat, 17 Mar 2018 05:30:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180317043040.GA973@pd.tnic>
References: <20180314182131.GA25259@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180314182131.GA25259@embeddedgus>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 01:21:32PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Also, remove max_interleave as it is no longer useful.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v4:
>  - Remove max_interleave.
> 
> Changes in v3:
>  - Update macro MAX_INTERLEAVE in order to avoid too long lines.
>    This change is based on Mauro's feedback.
>  - Update changelog with Mauro's Reviewed-by.
> 
> Changes in v2:
>  - Use macro max_t to compute the max of all three array sizes.
>    This change is based on Borislav's feedback.
> 
>  drivers/edac/sb_edac.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
