Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeCFMRL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:17:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:49160 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932646AbeCFMRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:17:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="209252114"
Message-ID: <1520338622.3779.1.camel@linux.intel.com>
Subject: Re: [PATCH 0/5 V2] tpm: timeouts revamp
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 14:17:02 +0200
In-Reply-To: <20180306092503.11568-1-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> This series cleans up tpm timeouts setting and handling.
> 
> First motivation was to fix failures coming from too short timeouts
> for commands that creates keys.
> Key generation may take significant time depending on the underlying
> hardware. Rather than increasing default timeout a new constant is
> added, to not stall too long on regular commands failures.
> 
> Second is to define timeouts for new tpm2 commands
> defined in TCG 1.36 spec.

Where can we get that specification? I don't have that new
version and couldn't find it from the public internet.

/Jarkko
