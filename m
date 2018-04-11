Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeDKKd6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:33:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36873 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeDKKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:33:56 -0400
X-Google-Smtp-Source: AIpwx49cHdyTfJWgAMUzGlyIk7WbF7EkALH90uDstB1igBA0P3hT9Hw9n558fSIvy0CQF1i6gJW7kw==
Date: Wed, 11 Apr 2018 12:33:53 +0200
From: niklas soderlund <niklas.soderlund@ragnatech.se>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: renesas: r8a77970: add LVDS support
Message-ID: <20180411103353.GY12256@bigcity.dyn.berto.se>
References: <1523357646-3946-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357646-3946-4-git-send-email-jacopo+renesas@jmondi.org>
 <0baa0f6e-f275-4a27-c76b-e4f8aec0b5f6@cogentembedded.com>
 <20180410121352.GD6436@w540>
 <9f54ba77-368f-3d0c-cb58-4849672af449@cogentembedded.com>
 <20180411095328.GE20945@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180411095328.GE20945@w540>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo, Sergei,

On 2018-04-11 11:53:28 +0200, Jacopo Mondi wrote:
> Hi Sergei, Niklas
> 
> On Tue, Apr 10, 2018 at 08:12:36PM +0300, Sergei Shtylyov wrote:
> > On 04/10/2018 03:13 PM, jacopo mondi wrote:
> >
> > >>> From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > >>>
> > >>> Add the LVDS device to r8a77970.dtsi in a disabled state. Also connect
> > >>> the it to the LVDS output of the DU.
> > >>>
> > >>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >>>
> > >>> ---
> > >>> v1 -> v2:
> > >>> - Rebased on the modified endpoint name and changed patch subject to
> > >>>   comply with other patches in the series from Sergei.
> > >>
> > >>    Stop, what was wrong with my R8A77970 LVDS patch, reposted on the popular
> > >> demand? :-)
> > >>
> > >
> > > Nothing wrong, I found out about your right now.
> > > I see a very small difference as
> > >          lvds@feb90000 vs lvds-encoder@feb90000
> >
> >    Yes, I thought the latter was closer to a "generic" name that DT spec requires...
> >
> > > You can add your signed-off-by ofc if you think that's the case.
> >
> >    Didn't understand what you mean here...
> 
> Don't worry, I will resend this and use (part of) your series
> [PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support
> 
> But please note that:
> [1/5] from your series has already been collected by Simon
> I have to reapply Laurent's comment on this series to your one (so I
> have to resend it anyhow)
> [5/5] from your series shall be resent to take into account the newly
> developed LVDS decoder driver (once it has been accepted)
> 
> I have anyway to repost your patches then, and as I did in this series
> you are ofc listed as author already, so I have missed what's the
> difference actually except from LVDS patch I collected from Niklas and not
> from your series.
> 
> Niklas I picked up patches 1-3 of this series from your tree.
> 1 and 2 are patches from Sergei's series
> 3 is from you but was also in Sergei's series and I picked yours as it
> was there already. Can I rebase on top of Sergei's one instead?

Yes please do so. And sorry for this mess, it is my fault as I missed 
one of Sergei's patches when integrating changes I made to 
r8a77970-eagle.dts. For this series always pick Sergei's patches over 
mine :-)

Once more sorry for the mess to both of you.

> 
> Thanks
>    j



-- 
Regards,
Niklas Söderlund
