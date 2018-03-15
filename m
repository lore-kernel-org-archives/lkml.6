Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCOKD1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:03:27 -0400
Received: from osg.samsung.com ([64.30.133.232]:63721 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbeCOKD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:03:26 -0400
Date: Thu, 15 Mar 2018 07:03:13 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 01/47] edac: remove tile driver
Message-ID: <20180315070313.12fc0c0e@vento.lan>
In-Reply-To: <20180314154847.GD16605@pd.tnic>
References: <20180314153603.3127932-1-arnd@arndb.de>
        <20180314153603.3127932-2-arnd@arndb.de>
        <20180314154847.GD16605@pd.tnic>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Mar 2018 16:48:47 +0100
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Mar 14, 2018 at 04:35:14PM +0100, Arnd Bergmann wrote:
> > The Tile architecture is obsolete and getting removed from the kernel,
> > this driver appears to only be used there, and not on the ARM based
> > successors (Tile-Mx, BlueField), so we should remove it as well.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/edac/Kconfig     |   8 --
> >  drivers/edac/Makefile    |   2 -
> >  drivers/edac/tile_edac.c | 265 -----------------------------------------------
> >  3 files changed, 275 deletions(-)
> >  delete mode 100644 drivers/edac/tile_edac.c  
> 
> Provided CONFIG_TILE gets removed, good riddance to that driver too.
> 
> Acked-by: Borislav Petkov <bp@suse.de>
Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

> 



Thanks,
Mauro
