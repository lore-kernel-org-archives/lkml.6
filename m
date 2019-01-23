Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07855C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E5C21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfAWF6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 00:58:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:8780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfAWF6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 00:58:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 21:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,509,1539673200"; 
   d="scan'208";a="136939666"
Received: from szhan10-mobl3.ccr.corp.intel.com ([10.249.172.83])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2019 21:58:35 -0800
Message-ID: <1548223114.4006.45.camel@intel.com>
Subject: Re: [PATCH 1/2] thermal/int340x_thermal: Add additional UUIDs
From:   Zhang Rui <rui.zhang@intel.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Nisha Aram <nisha.aram@intel.com>
Date:   Wed, 23 Jan 2019 13:58:34 +0800
In-Reply-To: <CACPK8Xdb0fEjU3kf_ZETtYE+D42QF-fNQacaHjVsLeE4MU0qFw@mail.gmail.com>
References: <20181010083007.239938-1-matthewgarrett@google.com>
         <20181010083007.239938-2-matthewgarrett@google.com>
         <1543849707.2841.9.camel@intel.com>
         <CACPK8Xdb0fEjU3kf_ZETtYE+D42QF-fNQacaHjVsLeE4MU0qFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2019-01-23 at 11:44 +1100, Joel Stanley wrote:
> Hello Rui,
> 
> On Tue, 4 Dec 2018 at 02:12, Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > On 三, 2018-10-10 at 01:30 -0700, Matthew Garrett wrote:
> > > 
> > > Platforms support more DPTF policies than the driver currently
> > > exposes.
> > > Add them. This effectively reverts
> > > 31908f45a583e8f21db37f402b6e8d5739945afd which removed several
> > > UUIDs
> > > without explaining why.
> > > 
> > I'm going to apply this patch series, just with two minor changes,
> > 1. 31908f45a583e8f21db37f402b6e8d5739945afd does not follow the git
> > commit description style 'commit <12+ chars of sha1> ("<title
> > line>")'
> > 2. the UUIDs were removed previously because these policies were
> > not
> > used.
> Which tree did this series get applied to?
> 
it is in my next branch, and I will queue it for 5.1.
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/log/?h
=next

thanks,
rui
> Cheers,
> 
> Joel
> 
> > 
> > 
> > thanks,
> > rui
> > 
> > > 
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Nisha Aram <nisha.aram@intel.com>
> > > ---
> > >  drivers/thermal/int340x_thermal/int3400_thermal.c | 14
> > > ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
> > > b/drivers/thermal/int340x_thermal/int3400_thermal.c
> > > index e26b01c05e82..51c9097eaf7a 100644
> > > --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> > > +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> > > @@ -22,6 +22,13 @@ enum int3400_thermal_uuid {
> > >       INT3400_THERMAL_PASSIVE_1,
> > >       INT3400_THERMAL_ACTIVE,
> > >       INT3400_THERMAL_CRITICAL,
> > > +     INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
> > > +     INT3400_THERMAL_EMERGENCY_CALL_MODE,
> > > +     INT3400_THERMAL_PASSIVE_2,
> > > +     INT3400_THERMAL_POWER_BOSS,
> > > +     INT3400_THERMAL_VIRTUAL_SENSOR,
> > > +     INT3400_THERMAL_COOLING_MODE,
> > > +     INT3400_THERMAL_HARDWARE_DUTY_CYCLING,
> > >       INT3400_THERMAL_MAXIMUM_UUID,
> > >  };
> > > 
> > > @@ -29,6 +36,13 @@ static char
> > > *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
> > >       "42A441D6-AE6A-462b-A84B-4A8CE79027D3",
> > >       "3A95C389-E4B8-4629-A526-C52C88626BAE",
> > >       "97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
> > > +     "63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
> > > +     "5349962F-71E6-431D-9AE8-0A635B710AEE",
> > > +     "9E04115A-AE87-4D1C-9500-0F3E340BFE75",
> > > +     "F5A35014-C209-46A4-993A-EB56DE7530A1",
> > > +     "6ED722A7-9240-48A5-B479-31EEF723D7CF",
> > > +     "16CAF1B7-DD38-40ED-B1C1-1B8A1913D531",
> > > +     "BE84BABF-C4D4-403D-B495-3128FD44dAC1",
> > >  };
> > > 
> > >  struct int3400_thermal_priv {
