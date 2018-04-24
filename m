Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AIpwx49c4lCzn1x6Q4f8STkiNnB/WCnNau5JvpSvUDznmpoeag3PlFRqfFjfOFKduW0Pq4cbf5T2
ARC-Seal: i=1; a=rsa-sha256; t=1524569044; cv=none;
        d=google.com; s=arc-20160816;
        b=N54wjvLZtUyFYqxAbXlCoqOc/x7suT5DUjYJXM3qEnMKKQUmbI09z62Mx1Z43FUqjN
         QckmfaMaTPqHSJ7NFf1sd/Fu/VneMwOX0mu7tJFnm8KnMxIGKJ4MO9W3mDtksxFFPQ6q
         LaFPErCCTfT2op0ea13iwf/qweaf/NFucrQ0Ziv/fVJyDaGdppP/TyFSexNxnaxaNqkc
         30/KmThOoh6LQTkPt8tNPg1ajQoKjF4eQpegvnxZnlVDz0uebxa3qxAhcZEkM618CavN
         gYHoIEeCGxlkSuiO4BDWwP+iAuwYi0/KXEhNn6wIcDSW5eLcHSsSyTO6uADR4paZ59ZC
         9iZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=HZjejLutyhm9j85vr9T9lt79GkNfjJeeB55b0dtTlh0=;
        b=VLZX1kOZ7p48ktXjrBON0CVvzXFBWrKZ08hJoyK73+Kc7RiZVvvNvUqe3VbXiTp0Q2
         dtwRPqNDlDgpSwKO4NWleTA0OC2ZhZN/aOwsOtHNzBYDElQR7oWjiNb+oyj3hzjQvIlL
         6yYldPPTYvgEeRkJJ0oE8N8R4ISx1MyOdctYTH29e9ctN42g1GSKHR83jchcS6AItV1D
         WoAmvXqGXNKIhJPDlInbeNJDli5wXMFpK1e41EJHDazqrUGZfKVOnordttEaH+C12jNe
         rxKPz3K4CKCjQEJoxUL3GrzzRD2CfcpDHf+AW6+y/O+U95pSUvWuF8tTjv1Ljf9yuAET
         WDMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.216.183 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.216.183 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Greg KH' <gregkh@linuxfoundation.org>, "richard.gong@linux.intel.com"
	<richard.gong@linux.intel.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "atull@kernel.org" <atull@kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "yves.vandervennet@linux.intel.com"
	<yves.vandervennet@linux.intel.com>, "richard.gong@intel.com"
	<richard.gong@intel.com>
Subject: RE: [PATCHv3 3/7] driver, misc: add Intel Stratix10 service layer
 driver
Thread-Topic: [PATCHv3 3/7] driver, misc: add Intel Stratix10 service layer
 driver
Thread-Index: AQHT2vs1AB82BfsnT0OWFRPGgC8BI6QPx4Og
Date: Tue, 24 Apr 2018 11:24:52 +0000
Message-ID: <9498165854b84321801d8186d3040b1e@AcuMS.aculab.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-4-git-send-email-richard.gong@linux.intel.com>
 <20180423120300.GC7951@kroah.com>
In-Reply-To: <20180423120300.GC7951@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123751673278426?=
X-GMAIL-MSGID: =?utf-8?q?1598626510434889322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Greg KH
> Sent: 23 April 2018 13:03
> On Tue, Mar 27, 2018 at 03:20:10PM -0500, richard.gong@linux.intel.com wr=
ote:
> > +config INTEL_SERVICE
>=20
> Naming is hard, but this is a _very_ generic name, don't you agree?
>=20
> > +	tristate "Intel Service Layer"
>=20
> As is this.  Can you make this a bit more specific to what hardware is
> being controlled here?
>=20
> > +++ b/drivers/misc/intel-service.c
>=20
> Same for the file name, why not stratix10.c?
>=20
> or intel_svc.c?  That makes it a _bit_ more generic.  Well, not really,
> but it does hide the "genericness" a bit more, right?

It'll all be even worse if (when) Intel decide to sell Altera to
someone else.

	David
