Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC2KuJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:50:09 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:51280 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeC2KuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:50:07 -0400
Date: Thu, 29 Mar 2018 13:50:02 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
In-Reply-To: <1597679.yzYZqmDdA5@amdc3058>
Message-ID: <alpine.LRH.2.21.1803291349480.12825@math.ut.ee>
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee> <alpine.LRH.2.21.1803291153070.12825@math.ut.ee> <CGME20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f@epcas2p2.samsung.com> <1597679.yzYZqmDdA5@amdc3058>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday, March 29, 2018 11:54:09 AM Meelis Roos wrote:
> > > 4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
> > > then continues with "blocked for more than 120 seconds" message with 
> > > libata detection functions in ther stack - 
> > > async_synchronize_cookie_domain() as the last. It seems to happen during 
> > > IDE CD-ROM detection (detected before but registered as sr0 after the 
> > > warning). After detection, the eject button on the drive did not work.
> > > 
> > > 
> > > pata_serverworks is the libata driver in use.
> 
> There were no changes to pata_serverworks since 2014 and libata changes
> in v4.16 look obviously correct..
> 
> > This is still the same in 4.16.0-rc7-00062-g0b412605ef5f.
> 
> Any chance that you could bisect this issue?

Yes, will do.

-- 
Meelis Roos (mroos@linux.ee)
