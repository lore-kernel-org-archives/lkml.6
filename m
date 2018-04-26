Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756078AbeDZUjp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:39:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:23928 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbeDZUjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:39:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,332,1520924400";
   d="scan'208";a="50260727"
Date: Thu, 26 Apr 2018 14:41:04 -0600
From: Keith Busch <keith.busch@intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: change order of qid and cmdid in completion
 trace
Message-ID: <20180426204104.GA3094@localhost.localdomain>
References: <20180426202515.20206-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426202515.20206-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 02:25:15PM -0600, Johannes Thumshirn wrote:
> Keith reported that command submission and command completion
> tracepoints have the order of the cmdid and qid fields swapped.
> 
> While it isn't easily possible to change the command submission
> tracepoint, as there is a regression test parsing it in blktests we
> can swap the command completion tracepoint to have the fields aligned.

It's the little things that matter. :)

Thanks, applied to nvme-4.18.
