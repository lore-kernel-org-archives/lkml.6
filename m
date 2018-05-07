Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeEGMXn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:23:43 -0400
Received: from verein.lst.de ([213.95.11.211]:60198 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeEGMXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:23:39 -0400
Date: Mon, 7 May 2018 14:26:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix use-after-free in nvme_free_ns_head
Message-ID: <20180507122653.GB27843@lst.de>
References: <1525420917-9448-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525420917-9448-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
