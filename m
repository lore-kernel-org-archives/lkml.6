Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeE2HFZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754787AbeE2HFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:05:22 -0400
Date: Tue, 29 May 2018 09:05:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        stable@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 199/496] scsi: core: return BLK_STS_OK for DID_OK in
 __scsi_error_from_host_byte()
Message-ID: <20180529070501.GC2473@kroah.com>
References: <20180528100319.498712256@linuxfoundation.org>
 <20180528100328.325324152@linuxfoundation.org>
 <ebdbc325-6f1c-ceab-97f8-d57194367440@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdbc325-6f1c-ceab-97f8-d57194367440@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:59:56PM +0200, Steffen Maier wrote:
> question:
> drop because of upstream's
> 
> cbe095e2b584 ("Revert "scsi: core: return BLK_STS_OK for DID_OK in
> __scsi_error_from_host_byte()"")
> Fixes: e39a97353e53 ("scsi: core: return BLK_STS_OK for DID_OK in
> __scsi_error_from_host_byte()")
> 
> as in stable-queue's
> 
> c40541008b93 ("drop a scsi patch from 4.14")
> 
> ?

Ugh, you are right, sorry about this, now dropping it again :)

Sasha, any way your scripts can detect that a patch was later reverted
so you don't add it to your patch series?

thanks,

greg k-h
