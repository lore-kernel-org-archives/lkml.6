Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AG47ELuLbq37DWgX8dar4yakuPpUAz6aPCAATJQ/UDJq3vlhuRQkp7q0zY8h3fMvkaIkRuapQ4u4
ARC-Seal: i=1; a=rsa-sha256; t=1521037680; cv=none;
        d=google.com; s=arc-20160816;
        b=u1SY+RgivRfFlIxuFR8e/nHnQPvfW0ZVyDqHnBpxEXGfAMMjtSB/47FcgIV+flXpQZ
         JPJqfyTXJaF1x6NeFPL7qt1DES/gbgqO8YqEkWavU9s565GI6yI57Xc11Cb10Thzfpg7
         PEYH7eJjr8StUDiFurA/9cZLkgKvLlhmn/oihYE50DyaTslfJmg05si4xdduVRR+WDZO
         1p69P8GX9KzE1NV6B7j2rfVyfBSdgz1fExx7Mon7AOwqHNXDgtxdWRtGwK7ZC0YEsxPj
         4u1BnAvv0uvxPuX16Kp2DF510CGHVqtNkv09l8+oM0LJdeux2lGCDoi6EjHRCb2aAyTh
         iuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=9Jb7xedSjJfHMK/FIuQnDhZRMyJI0JcY0BZPJlu+BJw=;
        b=HaH7DcsNxS7UIERWyA20q5a2dcHGSHYUE7QN4VEkJWmvHJe3+7OfDGL0vWXm4AOxgo
         FKNyz0e/V+O9Nb2g5VvkxmTWftQ6d6H8tRkM8NYQD0LtYbm3kIaIgAotiH1bGU7UnOTJ
         E8INF1ZfXbhKEzEjb8bn9ZvYK07aWBpAEqgz9XO+Ih6W6CJQAg9PeipO4A5XCL/m/xWK
         M1M3CnDueLp18q3o9+ZbVEc+SttrCPSqx8aeX3hR4mF7Y/ZI+y5zse8it2uWTE/uMyVe
         6vwhgng5uhP9A3qRX1wv0q5U2aSAx/7CMB4qKHC6SJm7EQUUqYcq125dasTMeNj6aMcG
         JMUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=tOdfZkVa;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 2a01:111:f400:fe1e::60f as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=tOdfZkVa;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 2a01:111:f400:fe1e::60f as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Alexander Graf
	<agraf@suse.de>, "arnd@arndb.de" <arnd@arndb.de>, Alexandru Marginean
	<alexandru.marginean@nxp.com>, Ruxandra Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, "stuyoder@gmail.com"
	<stuyoder@gmail.com>
Subject: RE: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Thread-Topic: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Thread-Index: AQHTutbMhVVZowRKSkyV9LKDFfki76POQC1wgAAJZACAAYHXkA==
Date: Wed, 14 Mar 2018 14:27:55 +0000
Message-ID: <AM3PR04MB07431282E4801B905EAE7AFCE6D10@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
 <20180313135156.3322-3-razvan.stefanescu@nxp.com>
 <20180313142251.GB3814@lunn.ch>
 <AM3PR04MB07438DD330E88830AD714339E6D20@AM3PR04MB0743.eurprd04.prod.outlook.com>
 <20180313152614.GC17895@lunn.ch>
In-Reply-To: <20180313152614.GC17895@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0823;7:upNcplrbimZwDLEBKjia3GjI37GlAzpKY5btjNVt2gVdVQmjFG3a89r+nTr7l7zZ6Y58Ho9ykJ5onwisLutOTtJMbZjoHBiHgCyhZQA90m4xz+auglCC+FwAKrAWQa4+IQU4aOUaoTwjNSdqZAE6KwyRU7q8X9GHclY3upeQQeZfedm4gP+/fPCGFZrmb24+s7/bCsgBuEd42E2h/bEW3v0cvGJJkyAuSZJmJiNYqJvQBlrYLb9O6RQY0lSwKOjz
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92944fc2-469f-4914-7725-08d589b7c6fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0823;
x-ms-traffictypediagnostic: AM3PR04MB0823:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB0823C38F5E5F785F387E694CE6D10@AM3PR04MB0823.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB0823;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0823;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(39380400002)(376002)(366004)(189003)(199004)(13464003)(8676002)(7696005)(5660300001)(81156014)(39060400002)(478600001)(99286004)(53936002)(76176011)(25786009)(3846002)(345774005)(4326008)(97736004)(229853002)(2900100001)(6116002)(14454004)(2906002)(105586002)(81166006)(86362001)(5250100002)(26005)(3280700002)(2950100002)(6916009)(7736002)(6506007)(74316002)(68736007)(6436002)(316002)(102836004)(3660700001)(33656002)(93886005)(9686003)(54906003)(66066001)(186003)(55016002)(6246003)(53546011)(305945005)(8936002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0823;H:AM3PR04MB0743.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: knLmDviP44LezyhNeA7/zEnLppK/v+kW8abfniZa90J4rI6oyNC7GwPakKeh0eBDo/uHhFFDICe+CZQn9JjwQ56EH6zGbgzftYVJCdFm4gHr6jyymybbx2ZoV+PsgQDw9KGnGjHaf5OS8duXhpAIG1tHXyTJ4jDtizrkR09/XgR1FgH6YMjLFQ00KrsHtoPKFWotX4xYHcbR3FOHdsLVDoCsvo8XDmTAW7QOXK2SHUu36xk9gBV6xHe2WK7N0h+M8icwijs+65DK3IBYxDFDXgjROkr8Y8WTyWg08K+YvBbc4PLvIbjtRMx2ynF+YXxmp7jK5DnE+My4DnuJfBZT/g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92944fc2-469f-4914-7725-08d589b7c6fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 14:27:55.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0823
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594721165675630217?=
X-GMAIL-MSGID: =?utf-8?q?1594923607516758239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Tuesday, March 13, 2018 5:26 PM
> To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> Cc: gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Alexander Graf
> <agraf@suse.de>; arnd@arndb.de; Alexandru Marginean
> <alexandru.marginean@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; stuyoder@gmail.com
> Subject: Re: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
> Ethernet Switch driver
>=20
> > Hello Andrew,
> >
> > The current driver implementation uses only a single FDB for the switch=
,
> > so  it is not possible configure multiple flooding domains to accommoda=
te
> > ports partitioning.
>=20
> Ah, O.K. Rather than break somebodies network by wrongly flooding, it
> would be better to return -EOPNOTSUPP when the requirement for the
> second FDB is met. The offload to hardware will then not happen, and
> the software bridge will do all the work.
>=20
Thank you for your suggestion. I will add to the TODO list in v6.

Razvan
>     Andrew
