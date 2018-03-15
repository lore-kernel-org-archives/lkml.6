Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCOQht (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:37:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:14394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeCOQhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:37:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="39203461"
Message-ID: <f70bda7aa50a99a3ed535742ac0939823d4a9f45.camel@linux.intel.com>
Subject: Re: [PATCH v2 4/8] tpm: move tpm1 selftest code from tpm-interface
 tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:37:43 +0200
In-Reply-To: <20180310082428.31519-5-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-5-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Move the tmp1 selftest code functions to tpm1-cmd.c
> and adjust callers to use the new function names.
>  1. tpm_pcr_read_dev to tpm1_pcr_read_dev
>  2. tpm_continue_selftest to tpm1_continue_selftest
>  3. tpm_do_selftest to tpm1_do_selftest
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

/Jarkko
