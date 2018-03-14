Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCNPtY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:49:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58976 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbeCNPtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:49:23 -0400
Date: Wed, 14 Mar 2018 16:48:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 01/47] edac: remove tile driver
Message-ID: <20180314154847.GD16605@pd.tnic>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-2-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:14PM +0100, Arnd Bergmann wrote:
> The Tile architecture is obsolete and getting removed from the kernel,
> this driver appears to only be used there, and not on the ARM based
> successors (Tile-Mx, BlueField), so we should remove it as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/Kconfig     |   8 --
>  drivers/edac/Makefile    |   2 -
>  drivers/edac/tile_edac.c | 265 -----------------------------------------------
>  3 files changed, 275 deletions(-)
>  delete mode 100644 drivers/edac/tile_edac.c

Provided CONFIG_TILE gets removed, good riddance to that driver too.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
