Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429B820897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429B820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbeG0L0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:51745 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbeG0L0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 03:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="asc'?scan'208";a="219584821"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by orsmga004.jf.intel.com with ESMTP; 27 Jul 2018 03:04:51 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>, hminas@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, grigor.tovmasyan@synopsys.com,
        Bruno Herrera <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>, john.stultz@linaro.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REPOST PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
In-Reply-To: <20180726200730.18290-1-dianders@chromium.org>
References: <20180726200730.18290-1-dianders@chromium.org>
Date:   Fri, 27 Jul 2018 13:01:32 +0300
Message-ID: <87zhydxair.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Douglas Anderson <dianders@chromium.org> writes:

> While looking at a dwc2 recently, I noticed that some platforms still
> have the uframe scheduler off.  As far as I know, nothing good can
> come out of having the uframe scheduler off.  Let's turn it on
> everywhere.  Assuming this all works out then some time in the future
> we can gut all the old code that handles the old non-uframe scheduler
> and make everything simpler.
>
> This is a repost of the original "RFT" (request for testing) series I
> posted a few weeks ago but without the "RFT" prefix.  Two of the
> patches in the series now have "Tested-by:" tags.  Since there should
> be nothing platform specific about the uFrame scheduler presumably
> this should mean we're good to go?  Specificaly note that in at least
> one of the "Tested-by" reports this patch caused a notable
> improvement.
>
> In response to the original RFT, some notes about testing this:
> - In general, try to have lots of things plugged in.
> - Plug many different keyboards / mice in.  See if keys are
>   dropped / mouse is jerky.
> - Try USB audio (ideally full speed, not high speed).  How is
>   the audio?
> - If you're brave, try a USB webcam.  How is the video?
>   ...maybe try including patches from crbug.com/820961 too.

Minas??

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlta7XwACgkQzL64meEa
mQaf2A//UINDaDWJgqK0oT0pHv1vAr4Cy5/bwfV3V/TBRIHtx7rv0IPdbWzG/611
Xz9Opx3yJG1cbVIpTnUpumztCpJLgHKr7Tn29fsHVW/HvMx+3pFppt/l2yrhfE49
Y5PPrvhhAbSR+J7uut6b78LQAP1FlrfG5qn6mlN9N4Dpdlgki3QZ0c8qd+XPS1OU
VEAaFYvyaNKvjHefddJZPXvh4A7ezU664Dyzox9/uYEeYVpl9pe/TSBUXC6BW0L9
E2YzqdCjN+B3dRpzAm3gS+wFWn+uIC/FA2RgxdUUjNS6/XB9w77lg+5OrFgQZUbe
DDXl6PKqd9ajzyJIwaIBtTJHMxVbIb8OQaqJxLWfx9NWqj9h+yTTYTZ06hlSgjJa
7+SPY74+TejfZ0lbwbpvI1MbaESWcqMZbY8AdOgkGnj830Aghs+dfXdJ0kvnC98a
d1BfD5InEte83agMsITpmtzq9rugDVV5HTT5z5ojcnXJd3/LgoLokmYss96ChhKR
pcmr0vmlxafq+yN35J28n8k4IAcWVD/kqLwOu70UJvm51h+8jv8A1Ym1N3yQNH70
rK6XZs6Q8CF/wLCY3m7d867y1S31x2Oxj7/3hf+NyyGSf4RrolRIN1n3NchdLRjz
KiIO5y/TqwWzPaUbqcK9RwUGNePrvAzi2lLfYfYC2EUj3ji4Qas=
=voHU
-----END PGP SIGNATURE-----
--=-=-=--
