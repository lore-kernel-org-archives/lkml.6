Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756421AbeEJBjd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:39:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:5172 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756379AbeEJBjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:39:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,383,1520924400";
   d="scan'208";a="57378212"
Date: Thu, 10 May 2018 04:39:25 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Thiebaud Weksteen <tweek@google.com>, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltp <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
Message-ID: <20180510013925.GJ6190@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-3-tweek@google.com>
 <20180420053926.GB15364@linux.intel.com>
 <1525725397.3551.10.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525725397.3551.10.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:36:37PM -0400, Mimi Zohar wrote:
> [Cc'ing Petr Vorel and the ltp mailing list]
> 
> Hi Jarrko,
> 
> On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I just noticed this is queued in your next branch.
> 
> Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
> tests includes walking the TPM binary_runtime_measurements in order to
> calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
> measurement in the IMA measurement list.
> 
> Mimi

Sorry, not following how these connect directly?

/Jarkko
