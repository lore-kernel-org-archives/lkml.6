Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeERPI7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:08:59 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35072 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:08:42 -0400
X-Google-Smtp-Source: AB8JxZr1O/jxhwEr9vQLGCJvxJM/5/BiauwTwTaU4Bz4kKh6EUfqJIrSTBc6/Gi9tlJmiElxMxwTmg==
Date: Fri, 18 May 2018 08:08:38 -0700
From: Tejun Heo <tj@kernel.org>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Or Gerlitz <ogerlitz@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Swapnil Ingle <swapnil.ingle@profitbricks.com>,
        Danil Kipnis <danil.kipnis@profitbricks.com>,
        Jack Wang <jinpu.wang@profitbricks.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/26] sysfs: export sysfs_remove_file_self()
Message-ID: <20180518150838.GC1718769@devbig577.frc2.facebook.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
 <20180518130413.16997-3-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518130413.16997-3-roman.penyaev@profitbricks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:03:49PM +0200, Roman Pen wrote:
> Function is going to be used in transport over RDMA module
> in subsequent patches.
> 
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to apply with other patches.

Thanks.

-- 
tejun
