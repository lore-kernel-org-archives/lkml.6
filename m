Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeBLT0s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:26:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:42972 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeBLT0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:26:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="174271387"
Date: Mon, 12 Feb 2018 12:30:54 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nvme: change namespaces_mutext to namespaces_rwsem
Message-ID: <20180212193054.GA16862@localhost.localdomain>
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518440086-583-3-git-send-email-jianchao.w.wang@oracle.com>
 <83870bcb-5d43-df08-24f1-2aa538643c1a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83870bcb-5d43-df08-24f1-2aa538643c1a@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 08:47:47PM +0200, Sagi Grimberg wrote:
> This looks fine to me, but I really want Keith and/or Christoph to have
> a look as well.

This looks fine to me as well.

Reviewed-by: Keith Busch <keith.busch@intel.com>
