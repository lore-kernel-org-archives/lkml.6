Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AH8x225ZK5HAnXs5ZCyBJndvgIri0jxCA12+0jPOHwZHOKkwDoGjg2m76oKZHitYRhEHNAAkpm+c
ARC-Seal: i=1; a=rsa-sha256; t=1518844095; cv=none;
        d=google.com; s=arc-20160816;
        b=gxE6eZAhF+omb+TOOYtjpCVCSDZtFqqwsD32ASzA4CciYCq2zg2TrbAHXr7jSMz8jV
         15pEyHpoFAzl+fyXodlB+BUkH1BSgS0KKeSPfaRAGJLgCtzl9e+GRlwF+nHY5A8ZFOzC
         HRmhGzDPJCNA7LKTq/tXw7579No5LFtb0jzKtwivyiQ921OHOU/JSYuhD4fAwhR/Sux3
         vKxawFM5vdmvMKWtmwkunsMSwXllTPyEaQaqXvaskK9t1NespusQMRVAnJzygSQohOeq
         CxruYVZylq87Kdq+4OEqOGTWODLMfBF36tXSuuzre2rXKBBi0ydWd/Wc0gM9FJXaZfay
         C+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=aj89vzjxn+OGtChMm4sL4NyxIiRCjnBQGHtCPMUkmTE=;
        b=rEBti0FxnZpYt6unTP+04mOL6kOG8UxQVPJ8HGeFAz9i4Uk4T+PNKitaSRhGJOuCVd
         AmVnWlv7jFdhVA+JZhA2XyxwWSO1++KwuUn8MrfjDx+q6D8F+IL/fIJnEaQPVXhDNwei
         ozAPbed6wN6O/4M+ZNnCf50C/tTKGjS77Dyq+a+eHaJLYpRtHJLlEqa0Wc68kIJSv2SB
         a0yBYy9vgQfKx+Mxbej9/KUd7fAawpSCw1Qgcgw3dSrby9RUJfGHqo4/dkKEBgyeaOe1
         0HJd6D6oBVH5sWVIYuXA6PJO0s65/QMtmokaEHM3kDs1a5zedHKEJKgNE3jXBxy4Ltii
         iuSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=bc/1CtPW;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 40.107.5.65 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=bc/1CtPW;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 40.107.5.65 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
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
Thread-Index: AQHTpQcUrFAgnFkYSEO/kES/qMEdoqOmQf+AgAHG/GA=
Date: Sat, 17 Feb 2018 05:08:12 +0000
Message-ID: <AM4PR05MB33305DC442CCB25AF280F0B5A2CA0@AM4PR05MB3330.eurprd05.prod.outlook.com>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
 <20180216013237.GC5786@fury>
In-Reply-To: <20180216013237.GC5786@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR05MB3172;7:d1UttkjgFKfu0T5+GfCNsR2hUv7RD//ZyBBGntIv7xvpM3oktwTCXaTieGu+iEmWdjmbaXQxx6GM2SHatpyreF5jGlD10fbO0YL4+9OrgGR41whCSF6Z1LuROsXVX7XoJLkBVz+2cUm829nNFIbA9Z+Tf1NzKnKhxqPCh2j8CFzaJh5r9hBSMDpXSSYRzjgYdVUMqDUnJhX4/EKjP1bF441drJGeekMCnj/XNYEVRC+hpvWH5h45SBscI6MeFxr4
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f246dab5-5519-4cc1-ae89-08d575c471b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM4PR05MB3172;
x-ms-traffictypediagnostic: AM4PR05MB3172:
x-microsoft-antispam-prvs: <AM4PR05MB31723BA2D2ECF9D91A6D8BC6A2CA0@AM4PR05MB3172.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR05MB3172;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB3172;
x-forefront-prvs: 058637CA05
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(13464003)(199004)(189003)(7736002)(102836004)(229853002)(81166006)(106356001)(81156014)(6436002)(86362001)(76176011)(55016002)(53546011)(8936002)(97736004)(14454004)(6506007)(53936002)(9686003)(316002)(99286004)(305945005)(3280700002)(2906002)(186003)(5250100002)(3660700001)(54906003)(74316002)(2900100001)(6116002)(25786009)(6246003)(26005)(39060400002)(107886003)(68736007)(3846002)(6916009)(2950100002)(5660300001)(478600001)(8676002)(105586002)(66066001)(33656002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3172;H:AM4PR05MB3330.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: T6e0dOJ+z2l0PgrNgeiiMXAPV4GRQSnDhdj/PZSBj7/VSf6HGr4X9Bhe+NXVHHOJFR4O+62QUFbdy7AVNzpbpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f246dab5-5519-4cc1-ae89-08d575c471b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2018 05:08:12.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3172
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318011865134700?=
X-GMAIL-MSGID: =?utf-8?q?1592623466243298252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, February 16, 2018 3:33 AM
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
>=20
> Hi Vadim,

Hi Darren,

>=20
> We are now in the RC cycle for 4.16. Do you consider these changes to be
> "fixes" that need to be included in 4.16? It was difficult to tell from t=
he commit
> messages how severe some of the possible issues were.

I actually considered these patches for the next, having in mind that 4.16 =
is
already closed.

>=20
> I'm concerned about the level of testing seen by the previous patch serie=
s if we
> are getting these changes so soon after they were merged.
> Can you comment on why these are being discovered now - and how confident
> are we in the drivers with these changes applied?

These patches has been tested on the all relevant platforms.
It has been discovered some time ago and it was in my plans to submit these
patches after the previous series.

Do you think it's better to consider this series as a bug fix, and target i=
t to
4.16?

Thanks,
Vadim.

>=20
> >
> > Vadim Pasternak (4):
> >   platform/x86: mlx-platform: Use define for the channel numbers
> >   platform/x86: mlx-platform: Add differed bus functionality
> >   platform/mellanox: mlxreg-hotplug: Change input for device create
> >     routine
> >   platform/x86: mlx-platform: Add physical bus number auto detection
> >
> >  drivers/platform/mellanox/mlxreg-hotplug.c | 31 +++++++++-----
> >  drivers/platform/x86/mlx-platform.c        | 68
> ++++++++++++++++++++++++++++--
> >  include/linux/platform_data/mlxreg.h       |  4 ++
> >  3 files changed, 90 insertions(+), 13 deletions(-)
> >
> > --
> > 2.1.4
> >
> >
>=20
> --
> Darren Hart
> VMware Open Source Technology Center
