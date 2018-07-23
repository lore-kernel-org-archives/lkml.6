Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91432ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4943B20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4943B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbeGWLIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:08:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:16315 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbeGWLH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:07:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 03:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="asc'?scan'208";a="73683831"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2018 03:06:56 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>, kbuild test robot <lkp@intel.com>
Cc:     "kbuild-all\@01.org" <kbuild-all@01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [PATCH] usb: dwc3: call set incr burst type func()
In-Reply-To: <AM0PR0402MB37475F43B0F16F462F8CD623F4560@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com> <201807231412.97HYMoRm%fengguang.wu@intel.com> <AM0PR0402MB37475F43B0F16F462F8CD623F4560@AM0PR0402MB3747.eurprd04.prod.outlook.com>
Date:   Mon, 23 Jul 2018 13:03:43 +0300
Message-ID: <87muui46bk.fsf@linux.intel.com>
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


Hi,

(no top-posting)

Pengbo Mu <pengbo.mu@nxp.com> writes:
> Hi,
>
> The following is my compile result:
>   ...
>   LD [M]  sound/soc/codecs/snd-soc-ak4613.ko
>   LD [M]  sound/soc/generic/snd-soc-audio-graph-card.ko
>   LD [M]  sound/soc/generic/snd-soc-simple-card-utils.ko
>   LD [M]  sound/soc/generic/snd-soc-simple-card.ko
>   LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
> ret:0
> These patches are based on mainline , and my version is linux-4.18-rc5. L=
ast week , I pulled my upstream branch to the latest.
> I didn't see error log in this version.
> By the way , this is my git tree --- git://git.kernel.org/pub/scm/linux/k=
ernel/git/gregkh/usb.git .
> Please tell me which tree could suitably develop patch for upstream.

this is a result of you sending this patch outside of the series it
belongs to. Just resend the full series and things should be okay. Also,
as Greg already mentioned, please write changelogs that explain WHY the
change was made.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltVp/8ACgkQzL64meEa
mQZ2VxAAv7V3woXkA7lNKO53IPGRqTjD7IiF5mM/vkfL9W71VSX5GqWBw/qKMYO3
2nVnzdmRi0XGQ0pswT8y1vmTPNGarTcup13JLPAxkxyqGvcfEgrE+RRfxMlLvpou
Tdq0FKQCYw42Jx1OM8YS6DgDr3mvebnhIbDOdjUYwE2mHXu1omT3kXJos+X9LGMi
pgL6DaGxqAWwPvHuCsrxzzsrS4sSY+o08ptBPqgo9NAUPwqpku7t9X+6EfiA2Hry
2Gbl9fLlxY74Z/Pn8o2GfeVyDxZxjFl5BueY92vSiv1JH8Fz3NmAp6vHMD6xJhfb
Umr8Yet+VLhhl8I1pqIEDFynGs0GuQ4LBnnOJZuAxjrS47kdZ6WRFbwAO+GLLZcp
/SXffD88pyKOcVN4fLWP7bzZFqSq5ndhHVL0Nv2zdCNB0T/d7v3RYLArbpRCphkH
LbuR/ZLzkDLOPgSOwJ9SxR0uD6qboIcRsAjk/SKwScSMCfKdnYW+Cq3FQAGjq1xw
zAqmNiT0J/1I8WmKJ8YnZ7FSPYqdDOSFjdQmUFRab5pOFQLy7NYmQMBcg2uikW8Z
mYm7zYe+okI9NoEXTz65OyRYx+aSIydK0Al6jLwK5fYQfKgfi3Nuveskx+AvXE+T
PXkFfxP1sl8frTzanOa48n+ROlATM8VBJntEqr4WgWNlZrd9pw4=
=rxoQ
-----END PGP SIGNATURE-----
--=-=-=--
