Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeDTFkm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 01:40:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:43204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbeDTFkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 01:40:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,300,1520924400";
   d="scan'208";a="221933074"
Date: Fri, 20 Apr 2018 08:40:38 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tpm: Move eventlog declarations to its own header
Message-ID: <20180420054038.GD15364@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-5-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412101350.210547-5-tweek@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 12:13:50PM +0200, Thiebaud Weksteen wrote:
> Reduce the size of tpm.h by moving eventlog declarations to a separate
> header.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
