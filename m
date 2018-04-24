Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeDXQBp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:01:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:29204 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbeDXQBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:01:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="50430371"
Date: Tue, 24 Apr 2018 09:01:37 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH] perf vendor events intel: Fix double words "are are" in
 cache.json
Message-ID: <20180424160137.GA14273@tassilo.jf.intel.com>
References: <20180424150249.26644-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424150249.26644-1-standby24x7@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 12:02:49AM +0900, Masanari Iida wrote:
> This patch fix double words "are are".

These files are auto generated from another source. I don't think
it makes much sense to do a lot of editing on the Linux copies.

I will pass it on to the owners of the original files.

-Andi
