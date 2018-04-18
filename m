Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeDRKSi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:18:38 -0400
Received: from verein.lst.de ([213.95.11.211]:59749 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDRKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:18:35 -0400
Date: Wed, 18 Apr 2018 12:19:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix the suspicious RCU usage warning in
        nvme_mpath_clear_current_path
Message-ID: <20180418101913.GB15833@lst.de>
References: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:32:47PM +0800, Jianchao Wang wrote:
> With lockdep enabled, when trigger nvme_remove, suspicious RCU
> usage warning will be printed out.
> Fix it with adding srcu_read_lock/unlock in it.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
