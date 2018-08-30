Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B79C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45A620645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45A620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeH3LsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:48:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47931 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeH3LsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:48:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8F9E2208C7; Thu, 30 Aug 2018 09:47:15 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4FB8522A3E;
        Thu, 30 Aug 2018 09:47:05 +0200 (CEST)
Date:   Thu, 30 Aug 2018 09:47:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Message-ID: <20180830074704.56x5xzfhauhd7ncy@flea>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
 <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
 <CAL_JsqKMPm=qmfYMQH99_gqSv0-ynUSvbkoNjjeDKtyxfgE1tg@mail.gmail.com>
 <20180827151140.luysp2kfbcq6patg@flea>
 <ec22950d-ae18-0cec-3bef-a4840618eb7d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7643npv2arymjmqd"
Content-Disposition: inline
In-Reply-To: <ec22950d-ae18-0cec-3bef-a4840618eb7d@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7643npv2arymjmqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 29, 2018 at 03:33:29PM +0300, Georgi Djakov wrote:
> On 08/27/2018 06:11 PM, Maxime Ripard wrote:
> > On Fri, Aug 24, 2018 at 10:35:23AM -0500, Rob Herring wrote:
> >> On Fri, Aug 24, 2018 at 9:51 AM Georgi Djakov <georgi.djakov@linaro.or=
g> wrote:
> >>>
> >>> Hi Maxime,
> >>>
> >>> On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> >>>> Hi Georgi,
> >>>>
> >>>> On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
> >>>>>> There is also a patch series from Maxime Ripard that's addressing =
the
> >>>>>> same general area. See "dt-bindings: Add a dma-parent property". We
> >>>>>> don't need multiple ways to address describing the device to memory
> >>>>>> paths, so you all had better work out a common solution.
> >>>>>
> >>>>> Looks like this fits exactly into the interconnect API concept. I s=
ee
> >>>>> MBUS as interconnect provider and display/camera as consumers, that
> >>>>> report their bandwidth needs. I am also planning to add support for
> >>>>> priority.
> >>>>
> >>>> Thanks for working on this. After looking at your serie, the one thi=
ng
> >>>> I'm a bit uncertain about (and the most important one to us) is how =
we
> >>>> would be able to tell through which interconnect the DMA are done.
> >>>>
> >>>> This is important to us since our topology is actually quite simple =
as
> >>>> you've seen, but the RAM is not mapped on that bus and on the CPU's,
> >>>> so we need to apply an offset to each buffer being DMA'd.
> >>>
> >>> Ok, i see - your problem is not about bandwidth scaling but about usi=
ng
> >>> different memory ranges by the driver to access the same location. So
> >>> this is not really the same and your problem is different. Also the
> >>> interconnect bindings are describing a path and endpoints. However i =
am
> >>> open to any ideas.
> >>
> >> It may be different things you need, but both are related to the path
> >> between a bus master and memory. We can't have each 'problem'
> >> described in a different way. Well, we could as long as each platform
> >> has different problems, but that's unlikely.
> >>
> >> It could turn out that the only commonality is property naming
> >> convention, but that's still better than 2 independent solutions.
> >=20
> > Yeah, I really don't think the two issues are unrelated. Can we maybe
> > have a particular interconnect-names value to mark the interconnect
> > being used to perform DMA?
>=20
> We can call one of the paths "dma" and use it to perform DMA for the
> current device. I don't see a problem with this. The name of the path is
> descriptive and makes sense. And by doing we avoid adding more DT
> properties, which would be an other option.

That works for me. If Rob is fine with it too, I'll send an updated
version of my serie based on yours.

Thanks!
Maxime



--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7643npv2arymjmqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluHoPcACgkQ0rTAlCFN
r3ThBg/4mLeazs76XAj3fa7GTLC18Ea9bZiuglPP73B634W8pWzZxT+HHlGGFv+B
iCPvC/rFk6ne48fG7m62RMvls+/SLZJ6QmMM8MSs5MVaj/w8WKw9pVNMkvRqufcH
o4lfE6uRlj/RZZGDXApmwBlFgHf70C1u0+v7uuBfQQ5tvJdbkMud0WZywLHvNDeR
f8+UTQMoMWQC6DLogRMVOicZDeykBMAiNHCk8kJkF9IZzHyhw2RP+Vx1lM8C8Axt
I92o76XB3mnboZJ4XHAXBmkNjE+uQFvH5hV5uEnzsIPlJAZMUyR8HgmI4lG59e5g
T0w1aQt/hwa1T8GlMMg4Ci/EMqyjScXQ1JhklWB67u2+uOuRTfuQ3vOO7j29iidQ
JVq7iYt+kW5HaESlxBO8QpfGqdmG1KM9uqbwd+LCPbuhqHvpIHA+yYduR0ScBsgx
HfWYL/zhrTCLyJdZR6WDxZsKoMcBQITpz5buhuOQxeSo0ZYaAKiKe60KfhEU2oc3
2Ce8cegFIxbYyJlV5IgbmG9HhaAVMx4HcoxqXDh7fnxS7dwt/6X2+E6OOtCXNDsv
UqdEfgmLFsGFUpCxnrLHhWXV7e6dhiDsm+WNowQE39/7J8WaXD9JIXUdKh22GLQh
DxuA2SB2r0kNiPVDYzSedtKUSnQutCbJ4GyEOJPCBqgKrU/CBA==
=sdv+
-----END PGP SIGNATURE-----

--7643npv2arymjmqd--
