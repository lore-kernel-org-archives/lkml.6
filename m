Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C984C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10C420857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10C420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeG0JYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:24:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:62643 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeG0JYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:24:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 01:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="asc'?scan'208";a="75968297"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2018 01:03:32 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] usb: dwc3: core: Enable AutoRetry feature in the controller
In-Reply-To: <MWHPR02MB281691F0330533A4A90396A7A72A0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532677280-30945-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <87h8klyv94.fsf@linux.intel.com> <MWHPR02MB281691F0330533A4A90396A7A72A0@MWHPR02MB2816.namprd02.prod.outlook.com>
Date:   Fri, 27 Jul 2018 11:00:13 +0300
Message-ID: <87effpyupe.fsf@linux.intel.com>
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

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>> replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
>>> Enabling this Auto Retry feature in controller, on seeing any
>>> transaction errors makes the core to send a non-terminating ACK
>>> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
>>> Doing so will give controller a chance to recover from the error
>>> condition.
>>>
>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>
>>now applied. I've slightly modified commit log to make it read a bit bett=
er.
>>
> Okay. Thanks a million for helping me in correcting the patch.

no problem ;)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlta0Q0ACgkQzL64meEa
mQbeXw//U+4t8BQnv1p3ceItRnKLw8wr42G8uMJCHca5p1En/VrR+/JMxX/LKQsJ
YR7s/o2gnlOpHYjCx3Jj4OdAnTp9hK7fE2/nkkqFP4YiS6Ygbc2tIOa/nUgVT5sg
l/kQdTnQx4yDUFHp6Sq2JnM9PBoFbhMSTqhzUSWR4sxTLV17LhV+JoVsT5rK9rGH
d1ICecwcZtXbZa/yK2hy6fDCQjMDZJvIgeUdTbv7O2w/vfHkrr9e/7tLaCXtLbwQ
vL9B8G8i3P+WERyyvdd4L7MflkFxgdYxwQnPN/Me/WqiJW13/ByQwRdJp+qXXCLb
SP5+IrWOBE2UVTKPr72J35wiT2EQU0ni4c5yWulazgOIhkgjz/bSambpfeJI7kzl
WARnYNsE0SGD37zqySj1SK2mVvILnzHL39oJSli+a9T42zJ2GLb7pO0C08SlP/Ae
GWok9zWEIyfjlBaoWRbCjNkQP+Mv2gPDtEtZxHJGC552i9jmounCMdO7ERpdHkzR
xcUW5vJQ8rmpUq1Ueikaiuwx7Awo8pck+ejUxjheX+QfhKpfcH2gQjINYX4Y9UJz
4XUx6uGfbN1Q4aWEO2+UxYl6///tKQAM7qQJV+sse0aMyzatRDJ2kvnOvdLgZKAJ
TJcaQ+EHGsfPQpOj0VG3NOJH/qNBy+zjmGpgFhq5E2D3ONMuqJU=
=vrOy
-----END PGP SIGNATURE-----
--=-=-=--
