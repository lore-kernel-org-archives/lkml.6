Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966248AbeBNAVZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:21:25 -0500
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:46184 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966200AbeBNAVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:21:23 -0500
Date: Tue, 13 Feb 2018 17:21:22 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 11/11] watchdog/hpwdt: Update driver version.
Message-ID: <20180214002122.GG22295@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-12-jerry.hoemann@hpe.com>
 <20180213170725.GA19405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213170725.GA19405@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:07:25AM -0800, Guenter Roeck wrote:
> On Sun, Feb 11, 2018 at 10:21:11PM -0700, Jerry Hoemann wrote:
> > Update driver version number to reflect changes.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index bb0dcc8709b8..78168e2f9b4e 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -23,7 +23,7 @@
> >  
> >  #include <asm/nmi.h>
> >  
> > -#define HPWDT_VERSION			"1.4.0"
> > +#define HPWDT_VERSION			"2.0.0"
> 
> I would suggest to drop the version entirely. History and experience shows
> that it is not really useful.
> 
> Guenter
> 

HPE can and does replace drivers w/o updating the underlying kernel version.

So having driver print its version has been very useful to me in debugging
issues in other drivers.  I want to maintain that in here.


> >  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
> >  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
> >  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> > -- 
> > 2.13.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
