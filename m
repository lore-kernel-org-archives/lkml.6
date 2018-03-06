Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeCFLUC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:20:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:32179 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCFLT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:19:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="32776290"
Message-ID: <1520335194.7549.7.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
 tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 13:19:54 +0200
In-Reply-To: <20180305202017.24008-3-tomas.winkler@intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
         <20180305202017.24008-3-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 22:20 +0200, Tomas Winkler wrote:
> Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
> and change the prefix from tpm_ to tpm1_.
> No functional change is done here.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This a good idea but can you go on and move all TPM 1.x stuff to
this new file while you are doing it?

/Jarkko
