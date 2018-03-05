Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935062AbeCEND1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:03:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:8523 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934874AbeCEND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:03:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="22085658"
Date: Mon, 5 Mar 2018 15:03:20 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm_crb: use __le64 annotated variable for response
 buffer address
Message-ID: <20180305130320.GC3425@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180304121205.16934-3-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304121205.16934-3-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 02:12:05PM +0200, Tomas Winkler wrote:
> This suppresses sparse warning
> drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

The guideline is that you should describe what is wrong rather than
copy-paste the sparse message.

/Jarkko
