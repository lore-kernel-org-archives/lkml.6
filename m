Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AG47ELuv77BO1yOrhqAP+71s5w+a4XQzJ6nUOU5Bf/N9bFzq3c8HbG5OJvsh+uwmjplfnWMxL3wp
ARC-Seal: i=1; a=rsa-sha256; t=1519767885; cv=none;
        d=google.com; s=arc-20160816;
        b=RKsiHdyUoUbip6wfTA1kdMWIVtLHSsAb675KKnXXFtm00Ky+NzD6vhUt1y7AaejTrx
         zIQs9dKGDLVNmG0Jvz8qTs3xeOdCxSrL5S1q5BXkmqTdhdXQ42MpnjKjiGq4di/dpEnV
         JaD0MFJGs2Ayo1So0Zu1fRP9ptDb2WaajEKdIZ9+D7qABVRikoofxgmIlv+rdshAPIrO
         GmUAN+TccYS/TMPuojNPeihD7+Icha6vsFQyNcmNx5f7/u4dsW8BHMOOQ46+Z8oCh3gI
         P8g4bIyAHYbMhlO24mbRyuLLxyF9WIjkvDCZgirBUPUFJEQW80Rd6eiNjvoWNGXIMRqc
         kEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=aQiD0ozR4F/Xavo5BWFEFh1fXIEdAZmVpuyNsts48zg=;
        b=xlpth+kwHZOym2K+7HC95L2L+r3WBqpdxnCamrCgKGsdbtUSQEj27HZuA60s22xxEF
         3uAru1AY/w5QLpieT2Wy06DTeu0dNAX5LnBboSotXTISE1kB5eaqvkcj2MT/3JdruPet
         LFZNcLho8Vf1SugXXWzLpQMlUoSOP5GWzN/zBuk5PAXDvsR+29iiHcc04GRouT5/VJ7M
         qYwPHFoH3L12FLjh6jmkciZzHU8W0EY6nrq70OqvKq2C/h18XXpR19ygi8wWBsm+thIO
         o8zFOpfhZssXQ6/jSBr5n9sr7Fk+Oh1F4RTllQAfRhBriHgc7DHHTD5PxQbN5h3gaSdk
         NWlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,402,1515484800";
   d="scan'208";a="21529374"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Topic: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Index: AQHTr+cBWLhVLGez8kOOfhAUJlAh/6O4fpMA///seoCAAFw8UA==
Date: Tue, 27 Feb 2018 21:44:41 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422A72C@hasmsx108.ger.corp.intel.com>
References: <20180227162105.14113-1-colin.king@canonical.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
 <20180227181005.GA19944@kroah.com>
In-Reply-To: <20180227181005.GA19944@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGEzNWRmM2MtMjBiNC00NmQzLTkxNjktNjczMGExMTViMDRhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJRdk5tcHJvclVzZlVVbXVvcE5vZWJlbHJrV3pDcERVczB4eDFsOG9rXC9tQTFWTUJwZDdpcndHRUpQeFJGbFRHWCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.4.156]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593571772960941030?=
X-GMAIL-MSGID: =?utf-8?q?1593592130432085606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>=20
> On Tue, Feb 27, 2018 at 05:26:22PM +0000, Winkler, Tomas wrote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Currently the driver spams the kernel log on unsupported ioctls
> > > which is unnecessary as the ioctl returns -ENOIOCTLCMD to indicate th=
is
> anyway.
> > > I suspect this was originally for debugging purposes but it really
> > > is not required so remove it.
> > >
> >
> > This is rather strange as most of the legimit applications are using
> > one IOCTL from kernel 3.0 Do you have any reference where this call is
> originated from, frankly this is the first time I got such complain.
> >
> > In any case it would be maybe better to change it a warn once call.
>=20
> Just drop the message, it should not be this easy for userspace to spam t=
he
> kernel log.  The patch looks fine to me.
>=20
Fair enough, add my ack too.

Still I'm curious if this comes from the field.

Thanks
Tomas
