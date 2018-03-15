Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeCOQaB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:30:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:41311 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeCOQ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:29:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="39199738"
Message-ID: <3f6082da29c0f779faed7a14f068b601c87d92c6.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/8] tpm: move tpm_getcap to tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:29:48 +0200
In-Reply-To: <20180310082428.31519-3-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-3-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> 1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
> 2. Remove unused tpm_getcap_header with unused constant
> as this functionality is already implemented using tpm_buf construct.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
