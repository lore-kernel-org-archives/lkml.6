Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04361C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13DD2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13DD2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLAIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:37:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:18928 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:37:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 13:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="118884245"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2018 13:26:40 -0800
Date:   Fri, 30 Nov 2018 13:26:40 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bskeggs@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH RFC 03/15] drm/nouveau: replace **** with a hug
Message-ID: <20181130212640.GA23772@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-4-jarkko.sakkinen@linux.intel.com>
 <CA+ToGPHBNg7k3uT8yrgWuPgD113Sd44TZamYd7j=f_X2idej6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ToGPHBNg7k3uT8yrgWuPgD113Sd44TZamYd7j=f_X2idej6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 06:13:50PM -0200, Diego Viola wrote:
> On Fri, Nov 30, 2018 at 5:30 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > In order to comply with the CoC, replace **** with a hug.
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c        | 2 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> > index 9cc10e438b3d..55a0060881ea 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> > @@ -446,7 +446,7 @@ init_ram_restrict(struct nvbios_init *init)
> >  {
> >         /* This appears to be the behaviour of the VBIOS parser, and *is*
> >          * important to cache the NV_PEXTDEV_BOOT0 on later chipsets to
> > -        * avoid fucking up the memory controller (somehow) by reading it
> > +        * avoid hugging up the memory controller (somehow) by reading it
> >          * on every INIT_RAM_RESTRICT_ZM_GROUP opcode.
> >          *
> >          * Preserving the non-caching behaviour on earlier chipsets just
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> > index 3737bd27f74e..ee364c71cc2e 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> > @@ -46,7 +46,7 @@
> >  #define NV_PPWR_INTR_EN_SET_SUBINTR                                  0x00000800
> >  #define NV_PPWR_INTR_EN_SET_WATCHDOG                                 0x00000002
> >  #define NV_PPWR_INTR_EN_CLR                                              0x0014
> > -#define NV_PPWR_INTR_EN_CLR_MASK                    /* fuck i hate envyas */ -1
> > +#define NV_PPWR_INTR_EN_CLR_MASK                    /* hug i hate envyas */ -1
> 
> Can you also capitalize the "i" please?

Yeah, maybe I just change it as "/* I hate envyas */"?

/Jarkko
