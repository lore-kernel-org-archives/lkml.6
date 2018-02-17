Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeBQUja (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:39:30 -0500
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:45470 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeBQUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:39:29 -0500
Date: Sat, 17 Feb 2018 13:39:27 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,05/11] watchdog/hpwdt: Update Module info.
Message-ID: <20180217203927.GD27788@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180215234400.5022-6-jerry.hoemann@hpe.com>
 <20180217161923.GA27212@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217161923.GA27212@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 08:19:23AM -0800, Guenter Roeck wrote:
> On Thu, Feb 15, 2018 at 04:43:54PM -0700, Jerry Hoemann wrote:
> > Update Module Author and description to reflect changes in driver.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index d5989acf3e37..71e49d0ab789 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -425,8 +425,8 @@ static struct pci_driver hpwdt_driver = {
> >  	.remove		= hpwdt_exit,
> >  };
> >  
> > -MODULE_AUTHOR("Tom Mingarelli");
> > -MODULE_DESCRIPTION("hp watchdog driver");
> > +MODULE_AUTHOR("Jerry Hoemann");
> > +MODULE_DESCRIPTION("hpe watchdog driver");
> 
> It is quite unusual to replace an author name. The original author is
> still the original author and should be retained. Adding another author
> is fine, but I disagree with the removal.

Wasn't intending to usurp Tom's credit (I left him in as Author in
comment block at top of file.)  But as Tom has retired,  I didn't want
anyone having problems with the rewrite of the driver to bother him
about it.

I'll redact this change.

> 
> Guenter
> 
> >  MODULE_LICENSE("GPL");
> >  MODULE_VERSION(HPWDT_VERSION);
> >  

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
