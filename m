Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755205AbeCGX7Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:59:16 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:60345 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754994AbeCGX7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:59:14 -0500
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 199.249.223.61
Date: Thu, 8 Mar 2018 00:58:52 +0100
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: sed-opal: fix u64 short atom length
Message-ID: <20180307235836.lylfefpy6i44vqhz@studium.uni-erlangen.de>
References: <1520379912.4178.83.camel@intel.com>
 <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180307232428.hv3zkcxldbu5w3tx@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307232428.hv3zkcxldbu5w3tx@sbauer-Z170X-UD5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:24:29PM -0700, Scott Bauer wrote:
> On Wed, Mar 07, 2018 at 05:55:56PM +0100, Jonas Rabenstein wrote:
> > The length must be given as bytes and not as 4 bit tuples.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > ---
> > v2:
> >   - use fls64
> >   - shorten loop body
> > ---
> >  block/sed-opal.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> 
> Reviewed-by: Scott Bauer <scott.bauer@intel.com>
> 
> Your two patches should be sent to stable for 4.14. I can queue those up and do it,
> or if you want to you can do it as well. Let me know what you prefer!
As I am quite new to all that kernel patch submitting stuff, I would be
glad if you could do it for me so I will not mess it up (;

Thanks,
 Jonas
