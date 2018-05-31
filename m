Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755822AbeEaQlb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:41:31 -0400
Received: from verein.lst.de ([213.95.11.211]:39050 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755665AbeEaQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:41:30 -0400
Date: Thu, 31 May 2018 18:47:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
Message-ID: <20180531164759.GA31353@lst.de>
References: <20180530132049.5890-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530132049.5890-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 03:20:49PM +0200, Johannes Thumshirn wrote:
> Add disk name to tracepoints so we can better destinguish between
> individual disks in the trace output.

Doesn't apply to the nvme-4.18 branch, please resend.
