Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeCOQsE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:48:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:9723 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbeCOQsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:48:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="37713454"
Message-ID: <62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
Subject: Re: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:47:58 +0200
In-Reply-To: <20180310082428.31519-8-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-8-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Add tpm2_pcr_extend function to tpm2-cmd.c with signature required
> by tpm-interface.c. It wraps the original open code
> implementation. The original original tpm2_pcr_extend function
> is renamed and made static, called only from new tpm2_pcr_extend.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This might concern some of the earlier patches too but please use exact
names for functions in the short and long summary i.e.

  tpm: migrate all of the PCR extension code to tpm2_pcr_extend()

Check this also for your long descriptions and previous that I gave
reviewed-by (I think they were otherwise fine). And you refer to a
function in text use parentheses after the name. I don't like
hastily written commit messages.

/Jarkko
