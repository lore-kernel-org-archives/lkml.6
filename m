Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966196AbeBNAB5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:01:57 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:54712 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966108AbeBNABz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:01:55 -0500
Date: Tue, 13 Feb 2018 17:01:54 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 05/11] watchdog/hpwdt: Update Module info.
Message-ID: <20180214000154.GF22295@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-6-jerry.hoemann@hpe.com>
 <20180213174950.GC22401@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213174950.GC22401@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:49:50AM -0800, Guenter Roeck wrote:
> On Sun, Feb 11, 2018 at 10:21:05PM -0700, Jerry Hoemann wrote:
> > Update Module Author and permission on parameters so that the
> > parameters show up in sysfs.
> > 
> 
> Does it really add value to see the module parameters in sysfs ?
> You would get both in standardized form by enabling WATCHDOG_SYSFS.


Not as much value as it did before I knew about WATCHDOG_SYSFS.  :)

It might still offer some unit level debug insight.
The majority of users of module_param are specifying read permissions,
so there is a uniformity aspect to having it.

But, not a big deal.  I'll remove read permission change if you want me to.




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
