Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E95EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F282086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j9GNg4/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfBTTzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:55:52 -0500
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:6174
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfBTTzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SMzmqe/EHgjfzHQMxA9Wy8TQre3ODvPr0VcJD87KS4=;
 b=j9GNg4/0xr5bsVt7BXLr2Htcdq5+eLqKS6Y+ED1wuqVDMBuOlNhi+AgSanPBoogm0Ae3NCDT6o/tnDakNvjPAwNMrgI9XWQB1paW6J6S+VmHTZpowgx6NdOx/DVGDTmlxm2u1/Q1qRD5Ls5zmaRshNVQy0JIX0C1vzFNcFrLpms=
Received: from BN6PR21MB0114.namprd21.prod.outlook.com (10.173.199.140) by
 BN6PR21MB0817.namprd21.prod.outlook.com (10.173.204.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.1; Wed, 20 Feb 2019 19:55:09 +0000
Received: from BN6PR21MB0114.namprd21.prod.outlook.com
 ([fe80::943d:65ab:dc08:a633]) by BN6PR21MB0114.namprd21.prod.outlook.com
 ([fe80::943d:65ab:dc08:a633%14]) with mapi id 15.20.1665.002; Wed, 20 Feb
 2019 19:55:09 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Add mailing list for Hyper-V CORE AND
 DRIVERS
Thread-Topic: [PATCH] MAINTAINERS: Add mailing list for Hyper-V CORE AND
 DRIVERS
Thread-Index: AQHUyVVx0Ac+cMlXUEGsS9ar034t6aXpGMwAgAAAt+A=
Date:   Wed, 20 Feb 2019 19:55:09 +0000
Message-ID: <BN6PR21MB011412591E7133B7F64008ECCA7D0@BN6PR21MB0114.namprd21.prod.outlook.com>
References: <20190220194823.20298-1-haiyangz@linuxonhyperv.com>
 <20190220195156.GA32021@kroah.com>
In-Reply-To: <20190220195156.GA32021@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-20T19:55:07.8298124Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=660b04b8-8d8b-4514-8a56-46663c807303;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8f2cb5a-90d5-4177-6c19-08d6976d51b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR21MB0817;
x-ms-traffictypediagnostic: BN6PR21MB0817:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BN6PR21MB0817;23:zWEy7mWGvvePRrrZ2H65UrchRCK4aYYf/tJI+6uZB?=
 =?us-ascii?Q?2v+f1qnTwWP3E1QnT1pjCSBNLGYtaGeqy88WvJpIWxdneNHXAXM+Ua2oWj8g?=
 =?us-ascii?Q?FQwryR/6uON1iuI+WphScCZIHl17V2zvzMGU3dANS3P5kD2vtuDODWI1AKCa?=
 =?us-ascii?Q?fNSCvBqECBjXP5L55ARBOlti+YGovLepRdT3k+F1I8Flg0JG8c4r+hxfioPH?=
 =?us-ascii?Q?xrck+m6LsS6EKOiljUwyHWzoj84UKx0QZTcjkWtw/lM+BxCDVNNKInycraJu?=
 =?us-ascii?Q?5PWMNEHn4lqi1whJdqlI2IUHfmt3WROPLKCkJJdojHhAqu4W7jotzytHTFOZ?=
 =?us-ascii?Q?zw0hLZZv8aGCLE1m3GnsWnMRjrmX0JdBuzFALodbuU14q1R52QF/UG7bcVqm?=
 =?us-ascii?Q?+5I8zYTIPGmaGayDnx7go3iCB52nSPuDQWk1jA1i8JgT6ItqYpgGtpC9bGpI?=
 =?us-ascii?Q?DoS/nJU5LFikZ6N/4gqnppTCdIPxvkcvav8Na4q7aNB2ritMni1kcz8Chrkx?=
 =?us-ascii?Q?5d5Opt2qhBYRuHfrk3gf+QBOiW838i3TMmsa3vFa6AgbkYeBxKuBo81h6w1e?=
 =?us-ascii?Q?hwOvdfPXwlAF75L2rx5SnIm2Wbf4ih0b6CxojjycmYhPFFF38EnCeab5D18M?=
 =?us-ascii?Q?ByhmjqgfxT2Cb9H9h1N40fGccdz0MeDhAKq+Lq1eOydAXAY867I8LjOSmVig?=
 =?us-ascii?Q?4VeDLabXXbyvslupExaw4s/JxzXUtXjRG8OYKR2sZDm66KM3/Ne+8/ZcStvB?=
 =?us-ascii?Q?sDVP9fo5lT+pezTT/dSjF50HEkncwH0KypzFOn+OL1QZs3nn6EbznO9VByiN?=
 =?us-ascii?Q?cmohl2wavkzWMciameWKxJrKM8q8QmpNqbRlKmNzappaLRaHkHdgTjE5abmK?=
 =?us-ascii?Q?0/iuUCMKLq9xWvbRls9CdzR8hC/OQpcBWirv21iFz7OAQKcevZkBs4URfP+F?=
 =?us-ascii?Q?STHfVIqCCQSWmSDV6Js7VH7OQ3e2ZwIweVdkiu/gplwh+4I9UxYodtI2z9EH?=
 =?us-ascii?Q?AWMFDpeyoS62EAqVdNREtmKrr8ppJs682vEaV58qxYqMRciJ4tCg+D+TfVR0?=
 =?us-ascii?Q?HFgegJlV4LJS8C2+GGhoGDAVMZQbngIzMc7uZxFzdUCbziFTe5/tnBJSQHrP?=
 =?us-ascii?Q?jf9OoBs2PwSfPmHszMrohdOKciMxsseTewwhQqVuegzH+LNbEFilj1Vg2CYY?=
 =?us-ascii?Q?2aCJEsCYZLfQhvTeaSk/qQeLbI8JAuAjcMxKCSmwKN75esJGawx3SOP/9D/D?=
 =?us-ascii?Q?m29uGmRTdZ/3OH7XzZp7vuxHR8pcq3sbMrqA7H/h6MwgnXoB45xXkwhEl3qc?=
 =?us-ascii?Q?aCgm6QM+sE6Tsi2YXHWIjzfoW6sIXj7DLc/VEM0x3+fHPPtH2uyV27i5hajP?=
 =?us-ascii?Q?1jKIfn7yD3bubUOpMtNpORMssoKlggN3aoHNnvHDWSI3tWI?=
x-microsoft-antispam-prvs: <BN6PR21MB0817BA95F62DB5CC11D369DCCA7D0@BN6PR21MB0817.namprd21.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(86362001)(8676002)(106356001)(7696005)(8990500004)(76176011)(86612001)(74316002)(4326008)(6916009)(305945005)(10090500001)(316002)(81166006)(68736007)(478600001)(105586002)(22452003)(54906003)(81156014)(99286004)(25786009)(14454004)(7736002)(10290500003)(8936002)(26005)(9686003)(11346002)(6246003)(446003)(2906002)(97736004)(6346003)(102836004)(53546011)(186003)(55016002)(66066001)(71200400001)(229853002)(71190400001)(476003)(3846002)(5660300002)(6116002)(486006)(6436002)(33656002)(53936002)(256004)(6506007)(223123001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0817;H:BN6PR21MB0114.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hBGioQaf053j4cm3dwpyNVysPDYv8VYn8blpOcTok9ocmI8bLHofI/rezU+qnjcUGiCCNv5i/9T9sPXxWuTZd7lvQrEqK+8txQfCz5XDtP5BPDQV641nT5LEygqaiVU513yIvdnqz2TH4Drpw6kMntLme8uQ8xbMTIKB7ExYulZ8WkyZ8NtIHF/w2GzzWZRsq0JTu4sT8OnAjFj510VKkcV/+mEShqp15PP47v92Wfn7Y3UEirUhUiQ8w+ubKT0O/rhIHI7q96c9QMJC0z49nTyuVnuSHiop7W8xi1uJ9O1Mawa6B8ddMAZbZG8w9gzAlTtKhgAts0VoHUyqcwajz2MYpQCBpP6Zp8f0ZSaVAL/P+Puyhd7XAqz3lnAKwpAIHDPLUqmn4CefqwT6RIDbhoFdLxkDY0nOOF3Y2q1FWbk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f2cb5a-90d5-4177-6c19-08d6976d51b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 19:55:09.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, February 20, 2019 2:52 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; linux-hyperv@vger.kernel.org;
> devel@linuxdriverproject.org; Stephen Hemminger
> <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] MAINTAINERS: Add mailing list for Hyper-V CORE AND
> DRIVERS
>=20
> On Wed, Feb 20, 2019 at 07:48:23PM +0000, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > The new mailing list is: linux-hyperv@vger.kernel.org
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 86aa227b5782..ef65de3cfe1b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7137,6 +7137,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
> >  M:	Stephen Hemminger <sthemmin@microsoft.com>
> >  M:	Sasha Levin <sashal@kernel.org>
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> > +L:	linux-hyperv@vger.kernel.org
> >  L:	devel@linuxdriverproject.org
>=20
> Why not just drop the linuxdriverproject one when you do this?
>=20
> I for one will not mind :)

I will. Thanks,
- Haiyang
