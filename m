Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F35CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88FC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391021AbfAPMAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:00:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53663 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbfAPMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:00:40 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 7f9222f6e9b3cbdd; Wed, 16 Jan 2019 13:00:38 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Intel graphics driver community testing & development 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime interface
Date:   Wed, 16 Jan 2019 12:59:46 +0100
Message-ID: <4866621.FvdCIrMUTQ@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0i_xyKTtMShut5JEFSE=8GrE4cfb_Yi+eeMPZdRsNvmbA@mail.gmail.com>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org> <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com> <CAJZ5v0i_xyKTtMShut5JEFSE=8GrE4cfb_Yi+eeMPZdRsNvmbA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 7, 2019 3:21:49 PM CET Rafael J. Wysocki wrote:
> On Mon, Jan 7, 2019 at 3:04 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Tvrtko,
> >
> > On Mon, 31 Dec 2018 at 13:32, Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> > >
> > >
> > > On 21/12/2018 13:26, Vincent Guittot wrote:
> > > > On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin
> >
> > [snip]
> >
> > > >>
> > > >> If it is always monotonic, then worst case we report one wrong sample,
> > > >> which I guess is still not ideal since someone could be querying the PMU
> > > >> with quite low frequency.
> > > >>
> > > >> There are tests which probably can hit this, but to run them
> > > >> automatically your patches would need to be rebased on drm-tip and maybe
> > > >> sent to our trybot. I can do that after the holiday break if you are
> > > >> okay with having the series waiting until then.
> > > >
> > > > yes looks good to me
> > >
> > > Looks good to me as well. And our CI agrees with it. So:
> > >
> > > Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> >
> > Thanks for the review and the test
> >
> > >
> > > I assume you will take the patch through some power related tree and we
> > > will eventually pull it back to drm-tip.
> >
> > Rafael,
> > How do you want to proceed with this patch and the 2 others of the serie ?
> 
> I'm going to queue up the whole series for 5.1.

And it has been queued up now, thanks!

