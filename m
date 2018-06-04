Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeFDMBv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:01:51 -0400
Received: from verein.lst.de ([213.95.11.211]:54597 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeFDMBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:01:50 -0400
Date: Mon, 4 Jun 2018 14:08:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme: trace: add disk name to tracepoints
Message-ID: <20180604120850.GA29495@lst.de>
References: <20180604075612.7277-1-jthumshirn@suse.de> <5af6f3ad-0932-ae45-a6f2-90e8e45726c5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af6f3ad-0932-ae45-a6f2-90e8e45726c5@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:48:57PM +0300, Sagi Grimberg wrote:
>
>> Add disk name to tracepoints so we can better destinguish between
>> individual disks in the trace output.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> Nit: s/destinguish/distinguish/g
>
> Christoph, can you fix it up when applying or you want me
> to do it?

I can fix it up.
