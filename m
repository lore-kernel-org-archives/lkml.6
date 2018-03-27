Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbeC0Eh0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:37:26 -0400
Received: from mail-ty1jpn01on0043.outbound.protection.outlook.com ([104.47.93.43]:54624
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750878AbeC0EhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:37:24 -0400
From: Masaki Ota <masaki.ota@jp.alps.com>
To: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aaron Ma <aaron.ma@canonical.com>
Subject: RE: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
Thread-Topic: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
Thread-Index: AQHTXdvFtDMVrRdEUkOSpRi4TAA+pKMVHaqAgAF7ZxCAdVKoAIBOUFcAgAgH34CAAgDKgA==
Date: Tue, 27 Mar 2018 04:37:19 +0000
Message-ID: <TYXPR01MB0719F95C7B4E9FD0FF313BEFC7AC0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
References: <20171115063404.10066-1-aaron.ma@canonical.com>
 <20171115083529.jmlpcj4td4evj3xl@pali>
 <TYXPR01MB07195A0116F835764DE99882C72E0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180129225138.voujq54itw7yblbi@dtor-ws>
 <CAKdAkRRjMrpdjuaivh-5bKCCgYpcySqDCKzbuvso1_x_+Qkp1w@mail.gmail.com>
 <20180325212541.5wzpvlkcbayfktrz@pali>
In-Reply-To: <20180325212541.5wzpvlkcbayfktrz@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masaki.ota@jp.alps.com;
x-originating-ip: [106.184.109.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB0685;7:pjBEf3aTWMipESVPJgMKtxobsl4X3DFkGE6scQQR93lOk1V+k/E/2zBvN29eg8pmQpDNVvp2+uVcc0q8o8SwnofxQF0LfmeHkyGV4n5CwXwQSvxYbIRCACHh6OUEmom2M+HgSXNEyyGTMzqBora1Y+jec6dUOHIqcF7aPjh9jFsq+jzwl/p6tJFYahthBuwIyA1RlftFiVEPucPbz4LJb/9X3NFta8jwotPxFk5fNx7B8/VKb7ewVcwCpJFMjcnQ;20:wDuiPHKU4oNas1HQBAPjiNYwCcrKt7PcnTjPgwaHkGtnqcv4ojfbwWDGde/KcaRFvKxokwU+6kzl2ch1ozwxY03Az+qBmdzwmk6wPR7pbnSOP6DapIPiHT7T1jQYAbl9it4ouwqWk2asT8cWvEiLkjksAfEaWifqgmEawsQ6d8Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da4dd466-ee0e-487e-f4f4-08d5939c6d15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB0685;
x-ms-traffictypediagnostic: TYXPR01MB0685:
x-microsoft-antispam-prvs: <TYXPR01MB06855A103578B2586C505D3DC7AC0@TYXPR01MB0685.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(9452136761055)(85827821059158)(198206253151910)(9931346810618);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:TYXPR01MB0685;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB0685;
x-forefront-prvs: 0624A2429E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(346002)(376002)(366004)(189003)(199004)(13464003)(6436002)(4326008)(33656002)(102836004)(3846002)(6116002)(2900100001)(81156014)(66066001)(3660700001)(81166006)(25786009)(68736007)(3280700002)(8936002)(97736004)(2906002)(478600001)(8676002)(76176011)(5660300001)(106356001)(85182001)(6916009)(86362001)(53936002)(7696005)(74316002)(39060400002)(53546011)(99286004)(6246003)(305945005)(446003)(11346002)(7736002)(59450400001)(14454004)(229853002)(55016002)(93886005)(77096007)(105586002)(6506007)(26005)(486005)(486005)(54906003)(186003)(9686003)(476003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:TYXPR01MB0685;H:TYXPR01MB0719.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: FmJRs++QUqMAvtAQXES2lB0u9a79xcv70MTW9F9QzAialw94DenfLsJ8yz7bEjftOv16iMiBfEB1pvU34G/VmC7SdIRXi75pPq81Kio98Wgngh2yUGWlbpVJSPf1jV8KPlhGn+F4P5iNjxjpyhCmXecYL2jld8kJxSVjFYc/eu1CN/ntoQijkgipP5p5VVRmtI+Q4E4e4V1TAGuwV6AWPmhB7sQKATDSU0hH/Xo2axU7pmtJhH1GdzeUm07e6uzpSyHjCH7zKXJNkEJE0yO/8kPz3s9s6HACTx9OiSeWBZUe8u319WW/fasu/xfQZfYXfJ+G9r01txF75SnP4vlQMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: jp.alps.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4dd466-ee0e-487e-f4f4-08d5939c6d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 04:37:19.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB0685
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2R4bX6M027211

Hi, 

We can get OTP page 0 value by EA EA E9 commands, but we cannot get it by EA EA EA E9.
As far as I remember, Device initialization finish at EA command, then sends EA EA E9 commands.
In this case we cannot get correct OTP page 0 value.
So I changed this order. (We can get OTP page 1 value by both of EA F0 F0 E9 and F0 F0 E9.)

Best Regards,
Masaki Ota
-----Original Message-----
From: Pali Rohár [mailto:pali.rohar@gmail.com] 
Sent: Monday, March 26, 2018 6:26 AM
To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices

On Tuesday 20 March 2018 11:47:26 Dmitry Torokhov wrote:
> On Mon, Jan 29, 2018 at 2:51 PM, dmitry.torokhov@gmail.com 
> <dmitry.torokhov@gmail.com> wrote:
> > Hi,
> >
> > On Thu, Nov 16, 2017 at 07:27:02AM +0000, Masaki Ota wrote:
> >> Hi, Pali, Aaron,
> >>
> >> Current code is correct device setting, previous code is wrong.
> >> If the trackstick does not work(DUALPOINT flag disable), Device Firmware setting is wrong.
> >>
> >> But recently I received the same report from Thinkpad L570 user, and I checked this device and found this device Firmware setting is wrong. Sorry for our mistake.
> >> Is your laptop L570 ?
> >>
> >> I will add code that supports the trackstick for this device.
> >
> > Sorry for resurrecting this old thread, I am just trying to 
> > understand what went wrong here. Is the sequence of "f0 f0 e9" and 
> > "ea ea e9" is important in getting the correct OTP data and we 
> > originally got this order wrong? It is not clear from the original 
> > patch and discussion that this change was intentional.
> 
> Could I please get an answer to my question?
> 
> Thanks!

Masaki, this question is for you ↑↑↑

> >
> > Thanks.
> >
> >>
> >> Best Regards,
> >> Masaki Ota
> >> -----Original Message-----
> >> From: Pali Rohár [mailto:pali.rohar@gmail.com]
> >> Sent: Wednesday, November 15, 2017 5:35 PM
> >> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> >> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; 
> >> dmitry.torokhov@gmail.com; Aaron Ma <aaron.ma@canonical.com>
> >> Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 
> >> devices
> >>
> >> On Wednesday 15 November 2017 14:34:04 Aaron Ma wrote:
> >> > There is a regression of commit 4a646580f793 ("Input: ALPS - fix 
> >> > two-finger scroll breakage"), ALPS device fails with log:
> >> >
> >> > psmouse serio1: alps: Rejected trackstick packet from non 
> >> > DualPoint device
> >> >
> >> > ALPS device with id "74 03 28" report OTP[0] data 0xCE after 
> >> > commit 4a646580f793, after restore the OTP reading order, it 
> >> > becomes to 0x10 as before and reports the right flag.
> >> >
> >> > Fixes: 4a646580f793 ("Input: ALPS - fix two-finger scroll 
> >> > breakage")
> >> > Cc: <stable@vger.kernel.org>
> >> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> >> > ---
> >> >  drivers/input/mouse/alps.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/input/mouse/alps.c 
> >> > b/drivers/input/mouse/alps.c index 579b899add26..c59b8f7ca2fc 
> >> > 100644
> >> > --- a/drivers/input/mouse/alps.c
> >> > +++ b/drivers/input/mouse/alps.c
> >> > @@ -2562,8 +2562,8 @@ static int alps_set_defaults_ss4_v2(struct 
> >> > psmouse *psmouse,
> >> >
> >> >     memset(otp, 0, sizeof(otp));
> >> >
> >> > -   if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
> >> > -       alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
> >> > +   if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
> >> > +       alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
> >> >             return -1;
> >> >
> >> >     alps_update_device_area_ss4_v2(otp, priv);
> >>
> >> Masaki Ota, please look at this patch as it partially revert your 
> >> commit
> >> 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage"). Something smells here.
> >>
> >> --
> >> Pali Rohár
> >> pali.rohar@gmail.com
> >
> > --
> > Dmitry
> 
> 
> 

--
Pali Rohár
pali.rohar@gmail.com
