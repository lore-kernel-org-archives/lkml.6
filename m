Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeC0T7d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 15:59:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:51198 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeC0T7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 15:59:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215225621"
Date: Tue, 27 Mar 2018 14:00:55 -0600
From: Keith Busch <keith.busch@intel.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: enforce 64bit offset for nvme_get_log_ext fn
Message-ID: <20180327200054.GC30867@localhost.localdomain>
References: <20180327180033.28316-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180327180033.28316-1-mb@lightnvm.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:00:33PM +0200, Matias Bjørling wrote:
> Compiling on 32 bits system produces a warning for the shift width
> when shifting 32 bit integer with 64bit integer.
> 
> Make sure that offset always is 64bit, and use macros for retrieving
> lower and upper bits of the offset.

Thanks, applied to nvme.
