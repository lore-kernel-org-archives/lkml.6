Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeA3JCi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:02:38 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52276 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeA3JCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:02:31 -0500
X-Google-Smtp-Source: AH8x2262bP0QujBbxz6So5r0pw53vPECy7jNQihME0d/VK1KUDyUjLpPmSKNH6Qon+hWlbCyo+T4JQ==
Date: Tue, 30 Jan 2018 09:02:26 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sean Paul <seanpaul@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 03/10] video: backlight: Add of_find_backlight helper
 in backlight.c
Message-ID: <20180130090226.d33reyxzvorvtyay@dell>
References: <cover.1516810725.git.meghana.madhyastha@gmail.com>
 <116d160ba78be2e6dcbdcb6855622bce67da9472.1516810725.git.meghana.madhyastha@gmail.com>
 <20180126094839.iksjiw4xj2n62yzn@dell>
 <b9221c2e-590e-405b-349f-908b7f89e6b9@infradead.org>
 <20180129091120.xs74nu75fype2amq@dell>
 <CAOw6vbK2BXJPf_hHSR9Pkdg9OdatwLejqw5tpQywfkhMrdafpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOw6vbK2BXJPf_hHSR9Pkdg9OdatwLejqw5tpQywfkhMrdafpg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018, Sean Paul wrote:
> On Mon, Jan 29, 2018 at 4:11 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 26 Jan 2018, Randy Dunlap wrote:
> >
> >> On 01/26/2018 01:48 AM, Lee Jones wrote:
> >> > On Wed, 24 Jan 2018, Meghana Madhyastha wrote:
> >> >
> >> >> Add of_find_backlight, a helper function which is a generic version
> >> >> of tinydrm_of_find_backlight that can be used by other drivers to avoid
> >> >> repetition of code and simplify things.
> >> >>
> >> >> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> >> >> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
> >> >> Reviewed-by: Sean Paul<seanpaul@chromium.org>
> >> >> Signed-off-by: Meghana Madhyastha <meghana.madhyastha@gmail.com>
> >> >
> >> > Nit: These should be in chronological order.
> >>
> >> Where does that tidbit of information come from?
> >> I have never heard or read that.
> >
> > Not sure it is documented anywhere.  It appeared to be the widely
> > used, most sensible approach, so I adopted it a few years ago.
> >
> > This method provides us with information which would otherwise be
> > absent; including description of the patch submission/acceptance path
> > and an idea of who did what, when.
> >
> > For example:
> >
> > Original Author sign-off
> > Original Co-author sign-off
> > [Additional contributions: rebase, API changes, fix-ups]
> > Re-worker's sign-off
> > Tester's tested-by
> > Reviewer's acked-by/reviewed-by
> > Level-2 Maintainer sign-off
> > Level-1 Maintainer sign-off
> >
> > Are you aware of a more functional/practical/useful method?
> 
> Our tooling adds a Link: tag to the commit message pointing back to
> mailing list archives. This provides more detailed patch provenance in

I've been avoiding using tooling for Maintainership for a long time.
I really do not want to go via that route.  The simpler the better as
far as I'm concerned (KISS [no, I'm not coming on to you!]).

Also, a ML link only provides you with information on the final
iteration of the submitted patch, and still does not provide
information on who did what, when.

> addition to reducing the burden on contributors to order tags

It's not really much of a burden.  Just keep putting the tags at the
bottom when you collect them.  Fortunately this is most developer's
default pattern, so I do not have to bring this up much.

> correctly (I had never heard of this as a requirement either). Check
> out [1]  if you're interested.
> 
> Sean
> 
> [1]- https://01.org/linuxgraphics/gfx-docs/maintainer-tools/dim.html
> 
> >

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
