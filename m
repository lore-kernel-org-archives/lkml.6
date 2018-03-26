Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELsP+DGtANziv5PCn25zaH9qjEJcrFhjqbNQB/lYsWDpYsHqCV05HdHu9PT5CM1AbeOwJkpt
ARC-Seal: i=1; a=rsa-sha256; t=1522068010; cv=none;
        d=google.com; s=arc-20160816;
        b=E2WlFaobzWNVWj3uMiUgGTY6q/tCdRfQwZpSmCm1ceccYs+KuhDsKx6Mz8wS0nzjMZ
         32IlizrnnVmWV4g1k3rxZyTthlq89N6BI0HxyMakh8uiMaHyggAsBuS7H57It/0iN/M4
         AS/yGbv2lSGa/M0DPXsTpGy4m/LXPsWj6GUL/yIj5ABrQczL/m+x4jLLx1VkEfUZSihV
         FqRo6rDfS7xRvffLEdGtO39q+83qLN4i48lcfAHbABGec8a5yPCwdbPBFoJCMV4NcdIt
         FceL3pKA8QjWCBng+oNTAP8helels9Gt5gVis+Z5+HUG3A2NJHbwz4IYeIeg8jWDYzbF
         RW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=Sj/CMZqhu2wi7/MiZl1QHlRG254V+Sk7C0UQsiR5Tos=;
        b=fWJVYhaElXB2TUdvuXfxm7xYOeOkLHhQvQzAUTmziVFl3FGHJCN5PRCLXdlqBT4bDa
         egNnkofrw4mgMC2ypbOgAh27e52Rpk7fgRefiAVIezCPNrhskngIiTyARGfVchZXPOCC
         2m/ctwyjune4YYimyUCyQwI8iKuHgmKa5U7+Pc08REZmfc4S1mLHzo0x+wSDSAvOxBvD
         8dqwP6UP5OvvxPZPmTKRaUu2De2lpieqXR2Cl5Hzdwm2/Kl7fBL9K/b/vSrMOgf1dd0M
         wvk74/HNpfli7y0Vy9zdBt5oQGzDrkUwFTMvx/SapoGqGbCJCXCiUUG+Q6YZbFCMOqea
         VSUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.5 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.5 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSW0gUYRiG+3dmZ2fFjXFV/BMtXAjJ3NV1wUa
  7KKyLpZusiFJCHXXcXVpHmxlxlS48oOCSJwIrybMrpUK0ZHnCapFyzRDtoIiZoFAesEjNSjvM
  7KTZf/Xwv+/7fe/FhyPqdXkgTtt4mmUoqwbzQpN6HAZt6GJ3YqTrg4EsbrmHkcvPb8hIe0cPS
  r59Vi4jX/XexsjV8kFANreVIOR804iMfNHHH1cane1lmLHefcb4uK5TYby/0i0zfhp4gxl7Ng
  oUxlXn/nhFotzCpGbZUuTm+dItNHsKt7WNTcsKwE/MDrxwNeEAsH+gSGYHShwjSHh9aFYQcNy
  PMMMuFyl6EMKBwPdtW4jo8SWS4LfBAkxkPyIZVpauAYljYY3L7mGUOAh771ajIquIeDjhGEak
  ZW4Am0c2PGElEQFnrjkUIgMiGK4VdngWIEQAnJpv8BSCBAFb+0cRif3hwtwvucQH4KOvmwqJj
  8GlmRVULA2FmRWFnPSth+01T/5+H4Et01ek6eGwse8LJvFh2Na0hEg1faD71jxaBQJqd5Wo3R
  Wp3RWp3RVpBGg7iEllLSYzn0lZrFp9ZKRWrzdoDdqoyBgdla+ldHSONo1meJYSVB2Vy+m4vMw
  0a7qOoXknEE5gj/C6QZWLcoF9uEzjr4p+2p2o3pualZ5npjhzMptjpTkXCMJxDVTFLgiaD0ub
  aFuGxSrc0bYMcW+NnypBlFVcNpXJWUySNAy0+OTHpVJEjTJZDB0YoPIRTYRoMucwOyO2r3EcB
  Af6qoBQSu2dTbOZFv5/fREE4EDjq7ooTvG2MPzOpkWhhEwo8bDIU4Kn/kmBBaA5znb+AVLCV+
  S+zj/HR1UPqy9MhdSN4cXhuPpsSoLps/vQ4kw8e3mmtFzfZZga981FO68GKU/al/kf9adNcVh
  Yo3sz4qY7NS4oo8kZFbEeNkdO2iZOpU04qaEUZqxs/FLlnZch6ncRfb/l1Amf0dkVNtpapwht
  qG/9nnxUqUE5M6UPQ1iO+gNaoXgniAMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-32.tower-223.messagelabs.com!1522068007!785450!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede
	<hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [PATCH v7 2/6] Documentation: power: Initial effort to document
 power_supply ABI
Thread-Topic: [PATCH v7 2/6] Documentation: power: Initial effort to
 document power_supply ABI
Thread-Index: AQHTwo9vfVrSvQ2h+Uy/Nu8Q4qCVuKPiO7KAgAA+E1A=
Date: Mon, 26 Mar 2018 12:40:06 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E2EFD@SW-EX-MBX01.diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <0a26f379c29d65b6e0fa416a4b73aea010b9f718.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180326095703.GA26466@kroah.com>
In-Reply-To: <20180326095703.GA26466@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 26/03/2018 09:43:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722898272542995?=
X-GMAIL-MSGID: =?utf-8?q?1596003985705421601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 March 2018 10:57, Greg Kroah-Hartman wrote:

> On Fri, Mar 23, 2018 at 10:12:21AM +0000, Adam Thomson wrote:
> > This commit adds generic ABI information regarding power_supply
> > properties. This is an initial attempt to try and align the usage
> > of these properties between drivers. As part of this commit,
> > common Battery and USB related properties have been listed.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 443
> ++++++++++++++++++++++++++++
> >  MAINTAINERS                                 |   1 +
> >  2 files changed, 444 insertions(+)
>
> How was this not documented before?

As an FYI, there is some overall documentation under:

 Documentation/power/power_supply_class.txt

However, after discussions with Heikki, it was determined something more
detailed would be useful to help clarify usage.

> Anyway, any objection to me taking this through the USB tree, as the
> typec patches depend on the 3/6 patch here.  If so, can I get an ack
> from the power supply maintainers?
>
> thanks,
>
> greg k-h
