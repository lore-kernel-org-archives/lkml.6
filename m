Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeBQUIn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:08:43 -0500
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:19084 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBQUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:08:42 -0500
Date: Sat, 17 Feb 2018 13:08:41 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,06/11] watchdog/hpwdt: Select WATCHDOG_CORE
Message-ID: <20180217200841.GB27788@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180215234400.5022-7-jerry.hoemann@hpe.com>
 <20180217162130.GA30748@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217162130.GA30748@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 08:21:30AM -0800, Guenter Roeck wrote:
> On Thu, Feb 15, 2018 at 04:43:55PM -0700, Jerry Hoemann wrote:
> > Update Kconfig file to show that hpwdt now selects WATCHDOG_CORE.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> At this point, WATCHDOG_CORE is not required. This patch should
> be merged with the next patch, which adds the requirement.
> 
> Since it appears that you insist on having it as separate patch,
> deferring to Wim.
> 

I have no objection to squashing these two commits once we have
agreed upon the actual changes being made.

I re-ordered to address the bisectability question, but kept them
separate as it is a little bit easier for me to rework patches if
the patch contains only a single file.


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
