Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeCUUvu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:51:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:63020 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753414AbeCUUvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:51:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="213681930"
Date: Wed, 21 Mar 2018 14:54:01 -0600
From: Keith Busch <keith.busch@intel.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: make nvme_get_log_ext non-static
Message-ID: <20180321205400.GG12909@localhost.localdomain>
References: <20180321192707.17749-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180321192707.17749-1-mb@lightnvm.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 08:27:07PM +0100, Matias Bjørling wrote:
> Enable the lightnvm integration to use the nvme_get_log_ext()
> function.
> 
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>

Thanks, applied to nvme-4.17.
