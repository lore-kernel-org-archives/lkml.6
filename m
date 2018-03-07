Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754977AbeCGXta (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:49:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:36606 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754771AbeCGXt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:49:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="32169350"
Date: Wed, 7 Mar 2018 16:24:29 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: sed-opal: fix u64 short atom length
Message-ID: <20180307232428.hv3zkcxldbu5w3tx@sbauer-Z170X-UD5>
References: <1520379912.4178.83.camel@intel.com>
 <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 05:55:56PM +0100, Jonas Rabenstein wrote:
> The length must be given as bytes and not as 4 bit tuples.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
> v2:
>   - use fls64
>   - shorten loop body
> ---
>  block/sed-opal.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Your two patches should be sent to stable for 4.14. I can queue those up and do it,
or if you want to you can do it as well. Let me know what you prefer!
