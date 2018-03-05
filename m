Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964838AbeCENCe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:02:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:9013 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935020AbeCENCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:02:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="22085343"
Date: Mon, 5 Mar 2018 15:02:15 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tpm: add new tpm2 commands according to TCG 1.36
Message-ID: <20180305130136.GB3425@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180304121205.16934-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304121205.16934-2-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 02:12:04PM +0200, Tomas Winkler wrote:
> 1. TPM2_CC_LAST has moved from 182 to 193
> 2. Convert tpm2_ordinal_duration from an array into a switch statement,
>    as there are not so many commands that require special duration
>    relative to a number of commands.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

My previous suggestion applies here.

/Jarkko
