Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeCORFe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:05:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:41530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeCORFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:05:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="37713764"
Message-ID: <1122028a7efd57fa6b5c1cabfd470fe986f7acba.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/8] tpm: move tpm2 code validation to tpm2-space.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:49:01 +0200
In-Reply-To: <20180310082428.31519-9-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-9-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Add new function tpm2_validate_command to tpm2-space.c
> that wraps up open coded functionality from tpm_validate_command.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Same comment as for 7/8. Probably might apply also for 1-6.

/Jarkko
