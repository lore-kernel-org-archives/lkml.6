Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeEPRiS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:38:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750775AbeEPRiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:38:17 -0400
Date: Wed, 16 May 2018 19:39:08 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180516173908.GA21169@asgard.redhat.com>
References: <20180406160541.GA28094@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406160541.GA28094@ziepe.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 10:05:41AM -0600, Jason Gunthorpe wrote:
>       RDMA: Change all uapi headers to use __aligned_u64 instead of __u64
Looks like this change changed the size of struct hfi1_ctxt_info and the
value of HFI1_IOCTL_CTXT_INFO ioctl number as a result.

>       IB/uverbs: Extend uverbs_ioctl header with driver_id
This patch changed the value of the RDMA_VERBS_IOCTL ioctl number.

(see https://lists.strace.io/pipermail/strace-devel/2018-May/008196.html
for the reference)
