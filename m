Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeDTFkO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 01:40:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:46048 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeDTFkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 01:40:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,300,1520924400";
   d="scan'208";a="221933005"
Date: Fri, 20 Apr 2018 08:40:09 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tpm: Move shared eventlog functions to common.c
Message-ID: <20180420054009.GC15364@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-4-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412101350.210547-4-tweek@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 12:13:49PM +0200, Thiebaud Weksteen wrote:
> Functions and structures specific to TPM1 are renamed from tpm* to tpm1*.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
