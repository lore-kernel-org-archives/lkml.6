Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFEHmc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:42:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751989AbeFEHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:42:29 -0400
Date: Tue, 5 Jun 2018 09:42:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL 0/6] vfio-ccw updates for 4.18
Message-ID: <20180605094225.033a6a97.cohuck@redhat.com>
In-Reply-To: <20180529123512.14393-1-cohuck@redhat.com>
References: <20180529123512.14393-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 14:35:06 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

Ping.

> The following changes since commit 3376d98021e915196f4894d835325a884e635a04:
> 
>   s390/archrandom: Rework arch random implementation. (2018-05-25 08:12:58 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180529
> 
> for you to fetch changes up to 3cd90214b70f7f971496bffc3c34d23b2141feb3:
> 
>   vfio: ccw: add tracepoints for interesting error paths (2018-05-29 09:27:42 +0200)
> 
> ----------------------------------------------------------------
> Various fixes and improvements in vfio-ccw, including a first stab
> at adding tracepoints.
> 
> ----------------------------------------------------------------
> 
> Dong Jia Shi (4):
>   vfio: ccw: fix error return in vfio_ccw_sch_event
>   vfio: ccw: shorten kernel doc description for pfn_array_pin()
>   vfio: ccw: refactor and improve pfn_array_alloc_pin()
>   vfio: ccw: set ccw->cda to NULL defensively
> 
> Halil Pasic (2):
>   vfio: ccw: push down unsupported IDA check
>   vfio: ccw: add tracepoints for interesting error paths
> 
>  drivers/s390/cio/Makefile         |   1 +
>  drivers/s390/cio/vfio_ccw_cp.c    | 140 ++++++++++++++++++++------------------
>  drivers/s390/cio/vfio_ccw_drv.c   |   5 +-
>  drivers/s390/cio/vfio_ccw_fsm.c   |  17 ++++-
>  drivers/s390/cio/vfio_ccw_trace.h |  54 +++++++++++++++
>  5 files changed, 150 insertions(+), 67 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_trace.h
> 
