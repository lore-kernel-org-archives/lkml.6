Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeBLTQD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:16:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:42442 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753446AbeBLTQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:16:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="29452144"
Date: Mon, 12 Feb 2018 12:20:10 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme: fix the deadlock in nvme_update_formats
Message-ID: <20180212192009.GE16255@localhost.localdomain>
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518440086-583-2-git-send-email-jianchao.w.wang@oracle.com>
 <16c23a0c-666c-802e-2b4e-c6a6da6f016b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c23a0c-666c-802e-2b4e-c6a6da6f016b@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
