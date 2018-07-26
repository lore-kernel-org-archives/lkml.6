Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4077BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE46C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE46C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeGZMTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:19:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:59018 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbeGZMTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:19:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 04:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="asc'?scan'208";a="76109553"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2018 04:03:15 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>, hminas@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
In-Reply-To: <20180706162154.196345-1-dianders@chromium.org>
References: <20180706162154.196345-1-dianders@chromium.org>
Date:   Thu, 26 Jul 2018 13:59:58 +0300
Message-ID: <87o9eu1cup.fsf@linux.intel.com>
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
> NOTE: I don't have access to any of the platforms that I'm changing
> here, so I'm hoping to see a Tested-by from those on the list.
>
>
> Douglas Anderson (4):
>   usb: dwc2: Turn on uframe_sched on "bcm" platforms
>   usb: dwc2: Turn on uframe_sched on "his" platforms
>   usb: dwc2: Turn on uframe_sched on "amlogic" platforms
>   usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms

care to resend without RFT prefix and with collected acks, tested-bys, etc?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltZqa4ACgkQzL64meEa
mQa0gg//bbcpCO9hwWkUxJDkr4oKiklNAG9s0eh5CL5jpIKn8UD6WmfhK2jJCqmz
3CMRYzAhtjPvbfEusKqy9cEBa1cTksrrpIrOKy56n77Xu9Ml/6F7jLzfzvG1m60l
gskLhw4FOh4nzh1x5rGNiDaJRQWllYzMIzXlrjQKnqktq1UCfsSmlSfSqbaj9/nJ
h7WRn5ID18EUmwp6pCMQJOKh2mPYTFNB3TiYogHKMjaTwq3yhFNYj4Hv6M7BATVJ
pon8U50JP1uKu+d0n8/CacegIUDyHfajMIE+hfMMFefgIUVL8AHYn4N6r8b+GRHz
CDeuQZ/2W2UiDab/ZNXkx46rAczVm4tTCEij+2+4OUigowgUjMKMwaf7tZSNF7P0
W0FhijYWQPtxezkbqdWqrFpGAnSEXJJEXmtJKbe4GfKpRQ8bzfW1aCFAd65efQqA
7ZBz6ZfsvZOCntCSnVluqDesJouoTD+KujT/EIP8jdqCN/LpuOyL381QejqnP4+/
uuL5iQWgPkMz4p59iQytAkdMQjs7X4HthV54eGFTRbuIg+kODDGffwIUP5pP0AQ1
s2q7ZOP8Bdd85aWGZ5Ctq4YuskQVJEaA1o4PsqpYJj+10qplX5IRq5UfYOY4NEzW
KClqxCdWi2MV4dAH/AiTk52wLW/RNxlwZ5Rq/YLow8XrKa5BIz0=
=Pvj8
-----END PGP SIGNATURE-----
--=-=-=--
