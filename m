Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeENK1T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:27:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:38331 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeENK1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:27:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="228266996"
Date: Mon, 14 May 2018 13:27:13 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: verify locality released before returning from
 release_locality
Message-ID: <20180514102713.GA8228@linux.intel.com>
References: <20180505195453.10431-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505195453.10431-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 12:54:53PM -0700, Jerry Snitselaar wrote:
> For certain tpm chips releasing locality can take long enough that a
> subsequent call to request_locality will see the locality as being
> active when the access register is read in check_locality. So check
> that the locality has been released before returning from
> release_locality.
> 
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Reported-by: Laurent Bigonville <bigon@debian.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
