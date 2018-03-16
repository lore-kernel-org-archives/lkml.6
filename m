Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbeCPQDe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:03:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:39792 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934671AbeCPQDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:03:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="38587886"
Date: Fri, 16 Mar 2018 09:38:09 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v2] block: sed-opal: fix u64 short atom length
Message-ID: <20180316153808.bwhyhwxgne7oqtoh@sbauer-Z170X-UD5>
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

Reviewed-by: Scott Bauer <scott.bauer@intel.com>
Tested-by: Scott Bauer <scott.bauer@intel.com>

Hi Jens,

When you get time can you apply this if you have no objections?

Thanks
