Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeELM1K (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 08:27:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeELM1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 08:27:08 -0400
Date: Sat, 12 May 2018 14:26:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mchehab@kernel.org, linux-edac@vger.kernel.org, elliott@hpe.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ghes_edac: add DDR4 and NVDIMM memory types
Message-ID: <20180512122641.GD27593@pd.tnic>
References: <20180509222030.9299-1-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509222030.9299-1-toshi.kani@hpe.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 04:20:30PM -0600, Toshi Kani wrote:
> The ghes_edac driver obtains memory type from SMBIOS type 17,
> but it does not recognize DDR4 and NVDIMM types.
> 
> Add support of DDR4 and NVDIMM types.  NVDIMM type is set when
> memory type is DDR3/4 and non-volatile.
> 
> Reported-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/edac/ghes_edac.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
