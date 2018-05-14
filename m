Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeENFwc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:52:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42623 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeENFwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:52:30 -0400
Date: Mon, 14 May 2018 07:52:28 +0200
From: Hannes Reinecke <hare@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] scsi: clean up generated file scsi_devinfo_tbl.c
Message-ID: <20180514075228.784a475f@pentland.suse.de>
In-Reply-To: <6e64c815-43dd-3945-6c58-66b1e0533403@infradead.org>
References: <6e64c815-43dd-3945-6c58-66b1e0533403@infradead.org>
Organization: SUSE Linux GmbH
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018 17:10:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> "make clean" should remove the generated file "scsi_devinfo_tbl.c",
> so list it in the clean-files variable so that the file gets
> cleaned up.
> 
> Fixes: 345e29608b4b ("scsi: scsi: Export blacklist flags to sysfs")
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/scsi/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-4.17-rc4.orig/drivers/scsi/Makefile
> +++ linux-4.17-rc4/drivers/scsi/Makefile
> @@ -182,7 +182,7 @@ zalon7xx-objs	:= zalon.o ncr53c8xx.o
>  NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
>  
>  # Files generated that shall be removed upon make clean
> -clean-files :=	53c700_d.h 53c700_u.h
> +clean-files :=	53c700_d.h 53c700_u.h scsi_devinfo_tbl.c
>  
>  $(obj)/53c700.o $(MODVERDIR)/$(obj)/53c700.ver: $(obj)/53c700_d.h
>  
> 
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
