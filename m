Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELvBsJ9wGty2ILa79uDGN0LudtKPTkXUVYS6yqDoB8lhTBOYS7ZrFMrXb73u83M+Ot/ZCz4W
ARC-Seal: i=1; a=rsa-sha256; t=1521820764; cv=none;
        d=google.com; s=arc-20160816;
        b=YpXAY0/DiaOI9ufN549eT7iB7Jsl06c+K1yuxBKZcq4te3MwjywNwn9lC9s98r+u0T
         iHZJjnLxDa23eW9j4JehjpXgSsu84Fww9C5Me8KGYTjvurFdBJXWCxAogErWNKYMSKCj
         vDSsKMrAJCVW7kq79JgxQllu1lj8z3RUi8CBfz4AAOpHl8N2SZ1LCuj4smWRWZnRcLvi
         4BswR/lDB9A3gZcpjMy/w5e/QTZMxRwiBkPTrMocJ3HtSfnMBtNv4okcJC+UdZ5mx40W
         mc8EEUXbVZW8/do0j+AAt7r3kAGM3ZMTfGttTESqThEc5RicvewwnLCefDMyhSueQI7a
         W0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=TiIQF5rfzf+9vz3PxxOsF9xhcLk1/1IHxApEiA538h8=;
        b=FT3LYH7h6wqV2y3KOx0InaXY6HTC2Ux+PJX2dhrwHQy+1T0ci5ebDxxHWaSasi50eR
         tTzYijYqkzGWJSA36bw52TBX45RxSFaDrq88NsUp9NDVLIEaoc8MxuMM9fQxsidwMDqT
         t8LurSDFdOVnjb2X4jj8M9tq1y9nmqQnTvF/zoRQsU6F6kPrarzKsrpIVOK6uYqUiG8R
         /+6BbGTxyibdpkhA7pRmP0flahkw6DkTt1XvGSEfyjNI9N/WtJl7yLVKxr/zK8bWDWVS
         emivKHrNCuJrQdP9k4IWuXfVKqIlTMm5ULLYIpnAxSdiGI+XBSEMinFuLhRPBf/iT5Ga
         +zOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=C2FOZHVy;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 104.47.2.69 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=C2FOZHVy;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 104.47.2.69 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
Subject: RE: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and
 auto detection functionalities
Thread-Topic: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and
 auto detection functionalities
Thread-Index: AQHTpQcUrFAgnFkYSEO/kES/qMEdoqPdKIKAgAELmiA=
Date: Fri, 23 Mar 2018 15:59:22 +0000
Message-ID: <HE1PR0502MB37532883C411EA1BA9871443A2A80@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
 <20180322235541.GD24138@fury>
In-Reply-To: <20180322235541.GD24138@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3052;7:9770wmZqFZJ0dDXZBLBYqCviKd5xzRqfpjvownmbByY00rUOKjsSwnAq4CUDzUWpwjtv4DM95kKbcS8RskvIO5JGGTcbkhGcIuUP/LwhFyDIbazRGOAfrm1ohECiU08inF2Rykmj3wl8YK33Im3QM4SUB6YI4FH4CmVlmHqEXxQmlhfHO4LMhB2gDEp9w0quI9Q23d0nMbPCC7qc4QJ7VHGBe0UyEA7YI6gTwaqLZ3fKZLYG7iOtWcjS9nhRcwjW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd78fb9e-0787-4f0f-6784-08d590d70b37
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3052;
x-ms-traffictypediagnostic: HE1PR0502MB3052:
x-microsoft-antispam-prvs: <HE1PR0502MB30520A3891B27DE2F2958ABCA2A80@HE1PR0502MB3052.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0502MB3052;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3052;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(376002)(396003)(39860400002)(346002)(199004)(189003)(13464003)(39060400002)(81156014)(2906002)(25786009)(81166006)(97736004)(106356001)(99286004)(316002)(102836004)(86362001)(54906003)(107886003)(6246003)(3846002)(6506007)(53546011)(76176011)(8676002)(478600001)(7696005)(3660700001)(6116002)(74316002)(3280700002)(6306002)(6916009)(4326008)(66066001)(9686003)(966005)(1720100001)(26005)(33656002)(5250100002)(186003)(68736007)(305945005)(6436002)(105586002)(14454004)(229853002)(446003)(55016002)(2900100001)(91966014)(5660300001)(11346002)(7736002)(8936002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3052;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2ejqIpC0DV+l0XEKyUBfCgfmp40dl6syujdqN0MKHbaJFpUI8C580VgFsWuvujiZ+V1Dzf1lWdiBTLe4olyS1WkmbTFu+aVlOCzeIh7rF/lAZtPuEEx+9JHvrRJdtw/YJlfSLKtbYnOqlPHBW4oknrOVeD01Ghk6Dg2x4R7tO5I5e/6DEa6fVEUaX1AC4DlxJQLdWtGPN3bMrSAUXyCrHz3UdfGollB9sSsf4fBYIbuJTkmicYRMniv67D58UyQXciI8BDjJ7X7/LEAfMU1I3bRLCrTrjGaFBlVhmeGJ/II+GPgq4omLeoVjPTdSwazWWFtkGOCUUaX1pQG+EfnIbw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd78fb9e-0787-4f0f-6784-08d590d70b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:59:22.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3052
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318011865134700?=
X-GMAIL-MSGID: =?utf-8?q?1595744730157901701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, March 23, 2018 1:56 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; platform-
> driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnulli.u=
s;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed =
and
> auto detection functionalities
>=20
> On Tue, Feb 13, 2018 at 10:09:32PM +0000, Vadim Pasternak wrote:
> > This patchset:
> > - Adds define for the channels number for mux device.
> > - Adds differed bus functionality.
> > - Changes input for device create routine in mlxreg-hotplug driver.
> > - Adds physical bus number auto detection.
> >
> > Vadim Pasternak (4):
> >   platform/x86: mlx-platform: Use define for the channel numbers
> >   platform/x86: mlx-platform: Add differed bus functionality
> >   platform/mellanox: mlxreg-hotplug: Change input for device create
> >     routine
> >   platform/x86: mlx-platform: Add physical bus number auto detection
>=20
> Vadim,
>=20
> I have rewritten most of the commit messages after parsing through them a=
nd
> reviewing the code. I believe they are much more concise now, and make th=
e
> intent of the patches much clearer. I have not changed the patch content =
(code).
>=20
> Please review the commit messages for the top 4 commits:
> http://git.infradead.org/linux-platform-drivers-
> x86.git/shortlog/refs/heads/review-dvhart-mellanox
>=20
> Does this still match your intent?
>=20

Hi Darren,
Thank you very much for review.

Looks good.

Thanks,
Vadim.

> --
> Darren Hart
> VMware Open Source Technology Center
