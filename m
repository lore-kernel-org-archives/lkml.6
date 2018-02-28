Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AH8x2254HqDH90J1ReosnzAejeT6z1O5hMMTBB3WIwXFlZiPEKwuMaxdYeXLcGeEKodhQZX1Kxni
ARC-Seal: i=1; a=rsa-sha256; t=1519811565; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbfksqPv63zOUB6qSjKhI82poR0VC+nb487NRpFz+NDqubhELCo3nV0q8alyaPQtyv
         wVQO/tlwu9JO/t2XOwjY+QwDnVDRFJAdX6DiIW5r/PNaeHzolDULy7vDvuaofTU65XAB
         +D7GbaWWNpzIjjMMguVfp/C3dnI768VwDZzcqh72OjNZgdT9Ieqdd0Fql1ry3ZLq7K/S
         I+bm1yk5wBfNQo977rvPkhAmL3fWrEgdA2gaz9y9JJXhINTUnVGIVa3M9OC+JK48k/gn
         I9jr+UF+FKg6sw2+LIz4HHEG6GdyvrLmEPEos8pbh+sHT79AzqVn4mOf+wZROAnCdBBe
         +onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=yJSG4gtEaKQh79uN0j3Xu5XyvPIIIF855Qi8Tc5QSps=;
        b=MzwTXgvg6uAOxvN2EujlzJMySzDpA2m6h8JLmicEht7YmrSO4bxIPhXatN1lZmT+2B
         C8JBsr4JiR6cgaRCSOe47nXWoeKiozxi4dXQGT6uFrtgLB984Wb0nFUfi3SQLLLbIuBx
         UTErzfMaBFC7pZb1mSOdQgHuhHyaDmdhzNCb1hkw7wAOXKPb6XcIQwgV2E8Y1sOYfZXa
         dnKXlEkpsTXyXPEVLdu/v0cymW4B8w2pjpLNaz62htDypKqFhtT9p7g+xLDPZdymWB2B
         xWT6GaD9Wxvazi1XIyx/jk3NWQqvtnDb8vlhYjNLBEZgNwWM66HQTCVeZUfjvEGmA/dC
         +B3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="34743890"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Topic: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Index: AQHTr+cBWLhVLGez8kOOfhAUJlAh/6O4fpMA///seoCAAFw8UIAAql4AgAAhvmA=
Date: Wed, 28 Feb 2018 09:52:42 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422AF6C@hasmsx108.ger.corp.intel.com>
References: <20180227162105.14113-1-colin.king@canonical.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
 <20180227181005.GA19944@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A72C@hasmsx108.ger.corp.intel.com>
 <20180228094958.GA12946@kroah.com>
In-Reply-To: <20180228094958.GA12946@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzg4MmYxODQtYzdjOS00ODQ5LThlODktODYxZmIxNzc1MGQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJNTXJMb1VjSXJ5OWdzdFlrZnYrVCt3OWphYWlIUVNZVWc3T3VNaHVBelp5M1RZbjAyOUd1RUpTRTV5d09GVERSIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593571772960941030?=
X-GMAIL-MSGID: =?utf-8?q?1593637931913307129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>=20
> On Tue, Feb 27, 2018 at 09:44:41PM +0000, Winkler, Tomas wrote:
> > >
> > > On Tue, Feb 27, 2018 at 05:26:22PM +0000, Winkler, Tomas wrote:
> > > > >
> > > > > From: Colin Ian King <colin.king@canonical.com>
> > > > >
> > > > > Currently the driver spams the kernel log on unsupported ioctls
> > > > > which is unnecessary as the ioctl returns -ENOIOCTLCMD to
> > > > > indicate this
> > > anyway.
> > > > > I suspect this was originally for debugging purposes but it
> > > > > really is not required so remove it.
> > > > >
> > > >
> > > > This is rather strange as most of the legimit applications are
> > > > using one IOCTL from kernel 3.0 Do you have any reference where
> > > > this call is
> > > originated from, frankly this is the first time I got such complain.
> > > >
> > > > In any case it would be maybe better to change it a warn once call.
> > >
> > > Just drop the message, it should not be this easy for userspace to
> > > spam the kernel log.  The patch looks fine to me.
> > >
> > Fair enough, add my ack too.
> >
> > Still I'm curious if this comes from the field.
>=20
> fuzzers are "in the field" :)

It's definitely fuzzers season.

Tomas
