Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AIpwx4/boCdB9CblZ2HC7I5SDaoHAL3MKb71I0XD2zGw8jAr30JwP2hg/m4sR7skoc98fTbPkOK7
ARC-Seal: i=1; a=rsa-sha256; t=1524469789; cv=none;
        d=google.com; s=arc-20160816;
        b=SfIR4LxwKjSn3t0gMiOKgNOJEpQew5aX1j+9/0GqchbkMqc7Nj5QlO4kr+A4o5yxtd
         lVaIIT5z5Sa8RbWDS6dQoC0z3AHhIYvaGmwVP7DzDUIn7MmkX1E/y5G4IdCLezLQfa7Q
         3Ti81WrOFish9CVNigsp53qmRMoPGhOgHoORuNuPO9N1SwREKuBcKNmHl4AK4wmt2yFa
         MljtIWpJ4mePH1/Z3LzwBxNlqVTSV/rU/9ebdcXgEqu43cX9v/TmohxczHID6BDzmIM/
         e6lgThSCxrFGeRZVQIc8HbqiaDeAhSglLYoFbvf8nTFuGjzLWUdnHPwaXFaBlGnmVvUx
         14ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=Wv6Uy6sLZ55uqhlMu+PwgKlP/gyabW9igAggAQ6xwfg=;
        b=lCQYueQELP+4NngYFtpL0+vOuAYP/rZOUHE0K771suZDEnb8sVvTxCgdpCyckyx69/
         Gt6Z8GUX1kDL9AGsAVcJzdp8qtHw7xWa4hbdMBxUqSB8570P4xzp/rxPY4Bb+dFOIz9W
         Wl+uNv01AFKqDIVsNgoilJtL81Rr1d2E2VqmzIqh/Zd0CF0/KarhLksrQiSVmw5K1l83
         ozszyYcfBHA8Krj2+dTQXeY8+RCmrFnzVPXzhTisIlRcJXiihHlHyba5dc2kTbhK/oKY
         CVqhqayvIZqFomOWm9vmcFnZMg1McKIjnPy8w9EH3kcvhksR9jGdUXEm+uzYQ2Kk0Pdh
         0lnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.115 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.115 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRWlGSWpSXmKPExsUSt3Opsa70hLt
  RBs3fNSyaF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjAkzPzEWnOGs2
  Pr7F2sD41P2LkYuDiGBpYwS55a2MHUxcnKwCVhITD7xgA3EFhHIkFjRP5kVpIhZYCmzxP1lf5
  hBEsIC3hJbf85ihyjykTj05h8jhO0k8frtTLA4i4CqxISNd1hAbF6BAImTK/aygthCAv1MEot
  vxIHYnAKBEpee/wOrYRSQlfjSuBpsPrOAuMStJ/PBDpIQEJBYsuc8M4QtKvHy8T9WCFteYvu3
  3+wQtr3E63vvgOZwANn6En2NxRBhQ4lV0w6wQNjmEpcvf2WBGK8jsWD3JzYIW1ti2cLXzBBnC
  kqcnPmEZQKj+CwkV8xC0jILScssJC0LGFlWMVomFWWmZ5TkJmbm6BoaGOgaGhrrmusaGVnoJV
  bpJumlluomp+aVFCUCZfUSy4v1iitzk3NS9PJSSzYxAtMAAxDsYHx8LPkQoyQHk5Io7+Xau1F
  CfEn5KZUZicUZ8UWlOanFhxhlODiUJHj9+oFygkWp6akVaZk5wIQEk5bg4FES4Y0ESfMWFyTm
  FmemQ6ROMSpKifPqgiQEQBIZpXlwbbAkeIlRVkqYlxHoECGegtSi3MwSVPlXjOIcjErCvO/7g
  KbwZOaVwE1/BbSYCWhxh+QdkMUliQgpqQbGo/yBi5u2m4hu3p0mbB938tP3OueLs09EO+tOds
  wTusQpmTWF+/p9s0UpMzcf4v7+Jm1P95+LMw4l6u+vm/Hg9DWhNTdXm/j0+6313rJFO1GuM5b
  HcgLfKp3KXxEJ3y/vPRp2yfTrj5UrOMxXLnB9ELa0xXI6//wmzmO3pJ4yNsn68u22Pfk+V4ml
  OCPRUIu5qDgRAM6mxY99AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-36.tower-246.messagelabs.com!1524469787!1302892!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede
	<hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Topic: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Index: AQHTwo9uuL+EwiEdW0SU7JmHmFIfzqQM7/QAgACCyOCAALalgA==
Date: Mon, 23 Apr 2018 07:49:38 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E6B41@SW-EX-MBX01.diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 23/04/2018 04:32:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722898650865988?=
X-GMAIL-MSGID: =?utf-8?q?1598522434092245236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 April 2018 21:58, Adam Thomson wrote:

> On 22 April 2018 15:05, Greg Kroah-Hartman wrote:
>=20
> > On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > > This commit adds code to handle requesting of PPS APDOs. Switching
> > > between standard PDOs and APDOs, and re-requesting an APDO to
> > > modify operating voltage/current will be triggered by an
> > > external call into TCPM.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/usb/typec/tcpm.c | 517
> > ++++++++++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/usb/pd.h   |   4 +-
> > >  include/linux/usb/tcpm.h |   1 +
> > >  3 files changed, 509 insertions(+), 13 deletions(-)
> >
> > This patch adds build warnings to the tree, so I can't take it, sorry.
> > Please fix up and resend.
>=20
> No problem. Sorry for that. Will take a look and resolve the warnings.

Sadly this is going to be a bit more than 'resolve the warnings' task now a=
s Jun
Li's patch set has now made it in before me which means I need to rebase PD=
O
Selection because of his changes. :(
