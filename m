Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDLHJ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:09:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:55450 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbeDLHJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:09:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,440,1517904000";
   d="scan'208";a="46282278"
Date: Thu, 12 Apr 2018 10:09:52 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Refactor TPM event log code
Message-ID: <20180412070952.GB24124@linux.intel.com>
References: <20180411125501.188477-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411125501.188477-1-tweek@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 02:54:58PM +0200, Thiebaud Weksteen wrote:
> This patchset implements the proposal from Jarkko Sakkinen [1]. I have
> included the feedback from Nayna Jain about the function naming.
> 
> [1] https://lkml.kernel.org/r/20171024222148.gwnkj5vqsyj43qer@linux.intel.com

You could add suggested-by to these commits.

/Jarkko
