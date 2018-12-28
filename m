Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9393C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7882F20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbeL1Qej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:34:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbeL1Qei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:34:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 331661596;
        Fri, 28 Dec 2018 08:34:38 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D070E3F5D4;
        Fri, 28 Dec 2018 08:34:37 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 2F98E68036A; Fri, 28 Dec 2018 16:34:36 +0000 (GMT)
Date:   Fri, 28 Dec 2018 16:34:36 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Message-ID: <20181228163436.GP22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-10-james.qian.wang@arm.com>
 <20181224123314.GK22341@e110455-lin.cambridge.arm.com>
 <CAKMK7uGt63=_KuECQc2ivuSZb8gMD1=6n0=Q2bcvzCEPo84uFw@mail.gmail.com>
 <20181228111534.GA19025@james-ThinkStation-P300>
 <CAKMK7uFaGnjznux9E9gzmppW-+Pbx6UoFHEYjtWvBJWh3ro-nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uFaGnjznux9E9gzmppW-+Pbx6UoFHEYjtWvBJWh3ro-nA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:56:27PM +0100, Daniel Vetter wrote:
> On Fri, Dec 28, 2018 at 12:15 PM james qian wang (Arm Technology
> China) <james.qian.wang@arm.com> wrote:
> >
> > On Mon, Dec 24, 2018 at 02:05:43PM +0100, Daniel Vetter wrote:
> > > On Mon, Dec 24, 2018 at 1:33 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > >
> > > > On Fri, Dec 21, 2018 at 10:01:06AM +0000, james qian wang (Arm Technology China) wrote:
> > > > > v2: Adjusted the position of KOMEDA by alphabetical order
> > > > >
> > > > > Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> > > >
> > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> > > >
> > > > Best regards,
> > > > Liviu
> > > >
> > > > > ---
> > > > >  MAINTAINERS | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 254b7b267731..e48c2e5fd29f 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -1124,6 +1124,15 @@ S:     Supported
> > > > >  F:   drivers/gpu/drm/arm/hdlcd_*
> > > > >  F:   Documentation/devicetree/bindings/display/arm,hdlcd.txt
> > > > >
> > > > > +ARM KOMEDA DRM-KMS DRIVER
> > > > > +M:   James (Qian) Wang <james.qian.wang@arm.com>
> > > > > +M:   Mali DP Maintainers <malidp@foss.arm.com>
> > > > > +S:   Supported
> > > > > +F:   drivers/gpu/drm/arm/display/include/
> > > > > +F:   drivers/gpu/drm/arm/display/komeda/
> > > > > +F:   Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> > > > > +F:   Documentation/gpu/komeda-kms.rst
> > >
> > > Mentioning the git tree would be good. And I guess you'll do some kind
> > > of group maintainership? Probably still good if you send out a
> > > dedicated/topic pull request for this new driver, but from then on
> > > it's all in the same git repo.
> > > -Daniel
> >
> > Hi Daniel:
> >
> > The komeda driver will use an Arm-hosted tree:
> >
> > git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
> >
> > Same as other arm display drivers. And Liviu Dudau will help to send the pull
> > request to merge this topic into drm-next.
> >
> > And we are planning to adopt a group maintainership and migrate towards drm-misc-next,
> > but we just need to have enough people and enough experience with working with upstream
> > before we jump all in.
> 
> arm drivers are probably a bit too big for drm-misc, but you could use
> the same tooling to maintain a drm-arm tree. I guess that's the idea?

Yes, the long term plan is to have the same process. We're just at the
early steps right now, where we're getting weened off internal tools had
bad habits :)

Best regards,
Liviu

> -Daniel
> 
> > Last a T: entry will be added in the next version.
> >
> > T:      git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
> >
> > James
> >
> > > > > +
> > > > >  ARM MALI-DP DRM DRIVER
> > > > >  M:   Liviu Dudau <liviu.dudau@arm.com>
> > > > >  M:   Brian Starkey <brian.starkey@arm.com>
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
