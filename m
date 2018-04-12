Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeDLHMq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:12:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:54125 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeDLHMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:12:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,440,1517904000";
   d="scan'208";a="46282781"
Date: Thu, 12 Apr 2018 10:12:30 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm: Move eventlog declarations to its own header
Message-ID: <20180412071230.GC24124@linux.intel.com>
References: <20180411125501.188477-1-tweek@google.com>
 <20180411125501.188477-4-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411125501.188477-4-tweek@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 02:55:01PM +0200, Thiebaud Weksteen wrote:
> Reduce the size of tpm.h by moving eventlog declarations to a separate
> header.
> 
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>

Will be fine with suggested-by added.

/Jarkko
