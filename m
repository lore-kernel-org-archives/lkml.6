Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBRNXD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:23:03 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33470 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeBRNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:23:01 -0500
X-Google-Smtp-Source: AH8x224/MY6fmwiweU/QPy6frQa3jNmicbA6LC0pwyXJGF/kP2wt5ok+tdiMSbqQVLhKWCfTUTdyDA==
Date: Sun, 18 Feb 2018 05:22:56 -0800
From: Tejun Heo <tj@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] sata_dwc_460ex: Delete an error message for a failed
 memory allocation in sata_dwc_port_start()
Message-ID: <20180218132256.GC695913@devbig577.frc2.facebook.com>
References: <3ba388af-286a-df63-e78f-c82c1d084439@users.sourceforge.net>
 <1518773953.22495.366.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518773953.22495.366.camel@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:39:13AM +0200, Andy Shevchenko wrote:
> On Thu, 2018-02-15 at 22:22 +0100, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 15 Feb 2018 22:15:25 +0100
> > 
> > Omit an extra message for a memory allocation failure in this
> > function.
> > 
> > This issue was detected by using the Coccinelle software.
> 
> Tejun, it's up to you. In case you are fine with the change,

Yeah, these are marginal at best and one may be able to argue that
emitting a message with device identifier is still useful but these
allocations are order-zero and can't fail to begin with, so...

Thanks.

-- 
tejun
