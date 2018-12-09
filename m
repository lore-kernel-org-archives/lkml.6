Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39120C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AED2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AED2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLIX12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:27:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLIX11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:27:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 249B685A04;
        Sun,  9 Dec 2018 23:27:26 +0000 (UTC)
Received: from bistromath.localdomain (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2E4608F2;
        Sun,  9 Dec 2018 23:27:23 +0000 (UTC)
Date:   Mon, 10 Dec 2018 00:27:22 +0100
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20181209232722.GA4425@bistromath.localdomain>
References: <20181210080045.0e67ad79@canb.auug.org.au>
 <20181209211139.GB21186@lunn.ch>
 <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
 <20181209214907.GC21186@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181209214907.GC21186@lunn.ch>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 09 Dec 2018 23:27:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-09, 22:49:07 +0100, Andrew Lunn wrote:
> On Sun, Dec 09, 2018 at 10:33:10PM +0100, Heiner Kallweit wrote:
> > On 09.12.2018 22:11, Andrew Lunn wrote:
> > > On Mon, Dec 10, 2018 at 08:00:45AM +1100, Stephen Rothwell wrote:
> > >> Hi all,
> > >>
> > >> Commits
> > >>
> > >>   dc9d38cec71c ("net: phy: mdio-gpio: Add phy_ignore_ta_mask to platform data")
> > >>   04fa26bab06d ("net: phy: mdio-gpio: Add platform_data support for phy_mask")
> > >>
> > >> are missing a Signed-off-by from their author.
> > > 
> > > Hi David.
> > > 
> > > Any idea what happened here? The version in my git repo has SOB.
> > > 
> > > https://patchwork.ozlabs.org/patch/1009811/ also has my SOB.
> > > 
> > Instead of
> > v2
> > --
> > int -> u32 in platform data structure
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > shouldn't it be
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > v2
> > - int -> u32 in platform data structure
> 
> Hi Heiner
> 
> David said he wanted to see the version history. So i deliberately put
> it above the ---.
> 
> I'm just wondering if -- was enough to trigger something in David's
> scripts? Or patchwork. The -- has disappeared in the commit which made
> it into net-next.
> 
>    Andrew

If you fetch the mbox from patchwork at

    https://patchwork.ozlabs.org/patch/1009811/mbox/

it contains:

-------- 8< --------
v2
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
int -> u32 in platform data structure

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
[diffstat]
-------- 8< --------

That's 3 dashes instead of the 2 from your mail. If you "git am" that,
the sign-off and actual history will get chopped off.

Maybe Stephen's script to detect those missing sign-offs could be run
as a commit/apply hook by David? This happens regularly, sometimes
dropping more than just a sign-off.

-- 
Sabrina
