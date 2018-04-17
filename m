Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeDQWSZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 18:18:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:28916 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbeDQWSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 18:18:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="47750345"
Date: Tue, 17 Apr 2018 16:19:27 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Wei Xu <wxu@cnexlabs.com>, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: lightnvm: add granby support
Message-ID: <20180417221926.GH11513@localhost.localdomain>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
 <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
 <20180417220901.GG11513@localhost.localdomain>
 <6701f433-e865-5a17-f1c7-4c0e0c5effaa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6701f433-e865-5a17-f1c7-4c0e0c5effaa@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:15:38PM -0600, Jens Axboe wrote:
> >> Looks good to me.
> >>
> >> Reviewed-by: Matias Bjørling <mb@lightnvm.io>
> >>
> >> Keith, when convenient can you pick this up for 4.18?
> > 
> > This looks safe for 4.17-rc2, no? Unless you want to wait for the next
> > release.
> 
> It should wait for the next release, it's not a fix.

Okay, queued up for the next release. I'll wait a few more rc's before
posting the  nvme-4.18 branch.
