Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbeCILqB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:46:01 -0500
Received: from elvis.franken.de ([193.175.24.41]:46576 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbeCILqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:46:00 -0500
Date: Fri, 9 Mar 2018 11:52:49 +0100
From: Tom Bogendoerfer <tsbogend@alpha.franken.de>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: jazz_esp, sun3x_esp: Pass struct device pointer in
 dma calls
Message-ID: <20180309105249.GA6536@alpha.franken.de>
References: <S1751161AbeCGG4v/20180307065653Z+38@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S1751161AbeCGG4v/20180307065653Z+38@vger.kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 05:56:41PM +1100, Finn Thain wrote:
> In jazz_esp and sun3x_esp, the esp_driver_ops methods pass esp->dev
> in dma api calls as if it was a pointer to a struct device. But
> it actually points to a struct platform_device. Fix this.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good.

Reviewed-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
