Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AG47ELuHKkzq6GG/SUTrafvCb3xh6pxa0gBBHHjSK0SvK5MRb9ohek5163BU9G5nJw5FOIlsKtej
ARC-Seal: i=1; a=rsa-sha256; t=1521200209; cv=none;
        d=google.com; s=arc-20160816;
        b=Li90UuuC/Z5e1H4N28z3djMoLgAB5qg577kGbj5cu+dDjsq8KLQhlCmLUR+BMeH2Dv
         F6FGiyKMDbR6LNGeSiZLQ1oM/P+s8ZoKsTwxtTK/uVSNyzzfRNbLnpTDFpR7SabM0uru
         erIL+RqAflERGVDdK61d4TtW6SK7AE9/3ECt+fAFgk2X3o7Qw00Kv7dytiuNpQzd2Alh
         h6f2I+tjtmgxzauzI2ZS3gxF86JQ0SyR64suTgxZcwUEJxxiJEA1qo1VGo87gmgJsiNr
         8mYvjLx6YqoBWGdpfTc0SrMjWy7Dd5tyZJHIT+QinNFCgscdeGE5fI1qhAlzdeaxu9B+
         c28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=HxS0z+LWyVuIYUcN3z371qBT6RNugDys/zmpdlZTQwk=;
        b=tWULonIy+7UKO7fOGcBxQhJzIeAa5jLWXkxYWohVFlM/Fp4/hoqgyTENKvWBsPrr2s
         RDs5d6Dnp07escgeOAgRAjzG8UNEC9SUEAGrwoZuO3GKp1T6NY8k/eCcEqxnTZCg6jFO
         Kc7C7s60alcp5488y6UZ/uPFJg9MLdA7l1fSH9JaHsWlQXP/tAyPpaMQJfGBauP2FaWx
         Hvo4vyhohXsa/X01798mcXXvMoVoDTNhoWC41h64eVgbO2yO1YvVS4BtxO14PvYVyKti
         97Z7h26A7SWqXE0yrpqEgQZkoJasxRt5h55zKzASCUYWI06O5YOWjBKiyFXd8Am/UdW0
         NA0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=OSS5oW6s;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 104.47.1.76 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=OSS5oW6s;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 104.47.1.76 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Andrew Lunn <andrew@lunn.ch>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, "stuyoder@gmail.com"
	<stuyoder@gmail.com>
CC: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Alexandru Marginean
	<alexandru.marginean@nxp.com>, Alexander Graf <agraf@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Thread-Topic: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Thread-Index: AQHTu60J51iI9pyLCEeISdmD4LrnPKPQZXiAgAC7yACAAZyx0A==
Date: Fri, 16 Mar 2018 11:36:46 +0000
Message-ID: <AM3PR04MB0743212F2EEE1699E0743B25E6D70@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
 <20180314234437.GD16379@lunn.ch> <20180315105642.szn2zhrsgwsv35yf@mwanda>
In-Reply-To: <20180315105642.szn2zhrsgwsv35yf@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1362;7:wJGUHmvpboAVDDQ4ZO7Yl/YMfos5wklSB9uIn5WlkZi1Yrdrb+OIPGi1otryEY7JspDnQHJPQPmCFbe9u4qsa/+q9pXg7SXGva8jvvdofws6ZdlNDcPkAvr6rewBU8/7HtUI5AWsGSmgCNzcOwbony80qegZHm5VOe9bOOx4pyfmGkGIMn5F0HUBaNt9+N+wOJsqeH4yxBZkpdE3RRL+tYpq0a8x5q3vlpeMnGXvbSUkJimV2mItiROkMcOOVO5a
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90fa6504-e8f1-4c74-d5d7-08d58b323326
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1362;
x-ms-traffictypediagnostic: AM3PR04MB1362:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB13628D0E96B22BC2F6AB2400E6D70@AM3PR04MB1362.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1362;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1362;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(13464003)(199004)(189003)(74316002)(86362001)(305945005)(7736002)(33656002)(2900100001)(66066001)(110136005)(54906003)(316002)(229853002)(76176011)(478600001)(99286004)(3846002)(5660300001)(7696005)(345774005)(55016002)(6116002)(97736004)(5250100002)(6246003)(2501003)(8676002)(81156014)(81166006)(105586002)(8936002)(3660700001)(53936002)(186003)(9686003)(14454004)(4326008)(3280700002)(106356001)(26005)(2950100002)(53546011)(68736007)(6506007)(25786009)(6436002)(2906002)(39060400002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1362;H:AM3PR04MB0743.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: e5py/5L3+6KdXLYJOXvhX2qQtiaFNCHEMr7XqhAifRQLjWtzlM/cPXgUieiWIPgknCG2gVccwaUbkflN3txXQh0delFxlio96j85TrPUfAbmhrNWBbOnYY+hJZIFLG6tGj2O3FYYcKD1xV3rfvWtDHoowULs4WViztNAuQAqgfeihJQHxbyRXp7hhG+MXAXIeMEp2lv/WGx+K/s7qei6fh5y2lfJirGpy8dDAcnqUoJZEcTmOkX6/Kcs6ez3u8bhIb2nNO8qxbReDQzWADZVEhGm1CE0Ie1x4dWcfPN9mBQ37VUxlY2m2/yUXs/H2nJz58I4acDt2eHWE70FagjtHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fa6504-e8f1-4c74-d5d7-08d58b323326
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 11:36:46.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1362
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594929162997388326?=
X-GMAIL-MSGID: =?utf-8?q?1595094030812757818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Thursday, March 15, 2018 12:57 PM
> To: Andrew Lunn <andrew@lunn.ch>; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; stuyoder@gmail.com
> Cc: Razvan Stefanescu <razvan.stefanescu@nxp.com>;
> devel@driverdev.osuosl.org; arnd@arndb.de; gregkh@linuxfoundation.org;
> Ioana Ciornei <ioana.ciornei@nxp.com>; Alexandru Marginean
> <alexandru.marginean@nxp.com>; Alexander Graf <agraf@suse.de>; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org
> Subject: Re: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driv=
er
>=20
> On Thu, Mar 15, 2018 at 12:44:37AM +0100, Andrew Lunn wrote:
> > On Wed, Mar 14, 2018 at 10:55:52AM -0500, Razvan Stefanescu wrote:
> > > This patchset introduces the Ethernet Switch Driver for Freescale/NXP
> SoCs
> > > with DPAA2 (DataPath Acceleration Architecture v2). The driver manage=
s
> > > switch objects discovered on the fsl-mc bus. A description of the dri=
ver
> > > can be found in the associated README file.
> >
> > Hi Greg
> >
> > This code has much better quality than the usual stuff in staging. I
> > see no reason not to merge it.
>=20
> Yeah.  It seems pretty decent.  Stuart, Laurentiu, care to comment?
>=20
> Meanwhile, netdev and DaveM aren't even on the CC list and they're the
> ones to ultimately decide.

I'll keep in mind to add Dave M and netdev list on CC for the next contribu=
tions.
Thank you for the suggestion.

Regards,
Razvan
>=20
> regards,
> dan carpenter
