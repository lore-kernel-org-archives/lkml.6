Return-Path: <felipe.balbi@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoftVKhkJMkprcbH0o3vfWRAzDD45UX5iNIJh22AYSYciJbREix12L6NV0VLEaaXpHoaxoO
ARC-Seal: i=1; a=rsa-sha256; t=1525865685; cv=none;
        d=google.com; s=arc-20160816;
        b=LLieOnbpS8Fcv1xNj9sTaCxu40U0QUS9lXrBjL9MUe9Dgr/ndhm1Xf1xmRzeS+uhmc
         Mlexc70WTVoqE4mRtr4G85FEo5BX1NvB4U98UrYW9vIrjF5T0IUlvJ9gsvjAznBmhfwS
         65f4Tb105cEmpWXSyz+Xs07bBbAoVUX1ynk1GSE8v8jrfjuArczCZz1Y/hJfwRBY0zt7
         +PA6cMA9XjCIGQoepHrhmk/SHnMaEfRwiEs3MooKHb+xm2krNQvb+fgTXKiHpHFw6R+S
         bW09Uc6DzTI0o99fHTizWIXnoAsQKduO540K4NpMPy26Qm1ZwrVbP0n3QozfzR2ls0WF
         6cDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=ulLZSAxHnvooZk1oZB0zHsY+o3fnuFjqoDXisNd+iXo=;
        b=YdTghGhpniKx+juAhE1sJsICUlTD22c13mF26YAzuM7q9Vl1XwOd4+4DvepFfPmHEG
         6vck+yieWCajpMUD0c0ZPrThnrC5TJ5u0uXKQXnnXWkLCBnWvMVpkomkOEmmK5jcspSI
         lKnHIE7IcdjrwSO3U3GPfBstkm3fvJ1E1LklnYzS3I6KjS/n7Fy4Vxg74QHisVHegKhV
         vCDjZGldEdrE0Pqr7l6ldqRCZa490uamyWSHnReJxh2AcVQBOwTQ8WjOnQHTTkzQTlTv
         ZeQv8JOzXRM0t64abbZRo5U38MQN8l8JmaqM6YZ5varkGP+YtuJ5F4RMOvEnyErkpvpc
         USfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="asc'?scan'208";a="227040771"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for SuperSpeed or higher speeds
In-Reply-To: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
References: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
Date: Wed, 09 May 2018 14:33:13 +0300
Message-ID: <8736z1kqrq.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599986136874105880?=
X-GMAIL-MSGID: =?utf-8?q?1599986136874105880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> The USB3CV version 2.1.80 (March 26, 2018) requires all devices
> ( gen1, gen2, single lane, dual lane) to return the value of 0x0320
> in the bcdUSB field

this sounds really odd. What happens when I get a USB 3.1 compliant
device off-the-shelf and run it through USB3CV? will it fail now?

Care to share a screenshot or the raw html of the test result?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlry3HkACgkQzL64meEa
mQZVhw//c8t4VTHKlwox/tPXPbndtR4FkwXphjHcAuuOELFYCjxYaP9aG+7WTqYr
7GdOsC+FkGagg0qJ6XQ1thV1pAZ9y/onGmCYnCpEyOXHFO0UVBz60/ooRt2eeLqc
Akk/Obl92v5vGG2Nh5u3cNOIgMovp6g56K4it2Gu3kTuuORQIqcx6bwNqwahKf4R
7X3gZ+pSVWvq0s0TpYeAYrDIzHKoIuXnCJJlVBaqDpf8gNUbzAg1nw9kKuNkVupy
cGSHfgTDIhnd3/cHwNluHbyGRAwPDMUs1ERqUAyoUVweFoKM1Y8zd0NzXIkhPzgP
J3cXHCIKrtdy4RsbwpVkTZRlFN7UjNaTRCUDQHENfmwzIHR3pn9tOnkLTp6cjClI
Pwj+Ni6G+CWGA6+KCwpI/8aUakyTd2fsue+X64bSslI+mjc24nTtii3rLD+oNevF
MLETaiAlU6Xn4YhCAfv/A/LzxxTUHqQnEJlBlqAnZO+9hVBQ+jL1DuM2BqgrNUoL
mb1m9yLHYasbQ6iJPjDegqO4M+A/nLNS6SY/2e4wc0uwI7CXP5P3eQGp6H57GxF2
XtGUYQhSTjyj6qs89uicNRsy70v52E3BzFBWw2lmVikqrU9HiD3VC7cJCK5/n3ZN
IaxwIsiIpRKpWxoSvl/Vd6B3+FDIeiu6tfJTHcGirDdRFlS1E6M=
=yC5H
-----END PGP SIGNATURE-----
--=-=-=--
