Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeDBRgD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:36:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:1237 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753055AbeDBRgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:36:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000";
   d="scan'208";a="42801647"
Date: Mon, 2 Apr 2018 11:38:39 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, rodrigorosattig@gmail.com
Subject: Re: [PATCH v3] nvmet: fix nvmet_execute_write_zeroes function
Message-ID: <20180402173839.GG28945@localhost.localdomain>
References: <1522686699-26894-1-git-send-email-rosattig@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522686699-26894-1-git-send-email-rosattig@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've applied the patch with a simpler changelog explaining
the bug.
