Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D768C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC5E218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="r8GEZLDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeLSJq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:46:29 -0500
Received: from mail-eopbgr1410099.outbound.protection.outlook.com ([40.107.141.99]:11776
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeLSJq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAr9CB8G0cX9z1XMRD0+GVgCsOymgxq5etqW5vb8PWM=;
 b=r8GEZLDGr3jprESQZwCJz80aEYBM5yec1oVgpF9fGSuBQFydkucj30RMUpcCi3ZQkIQ5O1zRLqUvGPZj89snKGiXF8+077JMiMvMElBDEA6vep9xiEsuA6nUqiHNK2+MRYzGHQX6yVNYALGoNVL44Ki3uKTFD4Zs/ZNcOp4gUuY=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1482.jpnprd01.prod.outlook.com (52.133.161.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 09:46:22 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48%5]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 09:46:22 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: serial: sh-sci: Document r8a774c0
 bindings
Thread-Topic: [PATCH v2] dt-bindings: serial: sh-sci: Document r8a774c0
 bindings
Thread-Index: AQHUlsmq1c6NjCUnlUGXwmEYGyJnw6WFqn2AgAAlHEA=
Date:   Wed, 19 Dec 2018 09:46:21 +0000
Message-ID: <TY1PR01MB1770FBD1239180359B0C09F3C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1545134590-22510-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20181219072535.GA28473@kroah.com>
In-Reply-To: <20181219072535.GA28473@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1482;20:Suv4t19stbMFIOTn4aIREp8S4La0OC+ZeA0wyxtkp/MrSoVV9cOe6JMUcTJkIoc/JhodjA4mnsM2MmxFE5aH2d81nVQRejYazjnN0Bp/vQyISHMGKhej74fZg0Sm0a3Un0WJJ87MvehqeJL16DvNPVMAx/3tjvQId9Vwzw/qUX4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 2b930838-0ab1-45bd-627f-08d66596d587
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1482;
x-ms-traffictypediagnostic: TY1PR01MB1482:
x-microsoft-antispam-prvs: <TY1PR01MB148214CCCBC57F9B1F3D7813C0BE0@TY1PR01MB1482.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1482;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1482;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(256004)(486006)(3846002)(14444005)(6116002)(7736002)(305945005)(106356001)(44832011)(81156014)(81166006)(99286004)(8676002)(25786009)(86362001)(4326008)(10126004)(97736004)(6436002)(74316002)(7696005)(6246003)(14454004)(2906002)(316002)(6306002)(966005)(54906003)(11346002)(76176011)(102836004)(478600001)(53546011)(5660300001)(229853002)(33656002)(6506007)(9686003)(8936002)(6916009)(26005)(71200400001)(71190400001)(66066001)(105586002)(446003)(53936002)(68736007)(55016002)(186003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1482;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5jB6iHv5XsKDdT5R7dw4xOAF3ipxR3WWLagmQcIATF5ML1cR3KcIa8GF3ovsEkAwo4IKuoDZj+Ma/VR0x/pE64hnvWMj2dGu9wHLlQwvP58oGmc6YwCrAEb/Dik+MAI0KDRZMBtlBcVwWWyfwIIqypVAbCDXNpT7VFaREAZvzcFM7ZQHfEagjxpvONUvO0s48vcxlbos5uJq+y1KbNlnjBjKfjOx8Bm1euLm/pqZRs6bVFwmKFlbIxvhe09IqKIk+8G9E7BIMiYmVxoybq/o2xARDUIus1I3WujwwpIjdLd6O9rHsdbnJMpSTeJlsRrK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b930838-0ab1-45bd-627f-08d66596d587
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 09:46:21.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: 19 December 2018 07:26
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH v2] dt-bindings: serial: sh-sci: Document r8a774c0 bi=
ndings
>
> On Tue, Dec 18, 2018 at 12:03:10PM +0000, Fabrizio Castro wrote:
> > RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
> > HSCIF ports, so document the SoC specific bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > v1->v2:
> > * Fixed title according to Geert's comment
> >
> > This patch depends on:
> > https://patchwork.kernel.org/patch/10565543/
>
> I don't have that patch in my tree, so can you please resend all of the
> pending patches that you need applied so that I can?  Including this one
> too.

No problems, I'll resend both, and I'll prepend "dt-bindings:" to the title=
 of the other patch as well.

Thanks,
Fab

>
> thanks,
>
> greg k-h


[https://www2.renesas.eu/media/email/unicef.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
