Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA668C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E30020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j3o57IRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfAUT5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:57:24 -0500
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:50176
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728245AbfAUT5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5npQ+qOO9Lfd701ciRodMbUhzbb2Z5tw4HJKtsT9/U=;
 b=j3o57IRuDy0yXxMc3y8TgtXJo9bbU/fWh8GDnRqtlKpPST8AajzoWL1KtK6UHbt5PUKbpI8mjqq2dAU6bSMDt5hCymw8fONX2fqf3QUVCgTBF3VXNvzc0W4DLiSFmbJQz2CQupwWXEUXYvY+6SXl2NXQLLWlX+DGdz4TGUmtFo8=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB5014.eurprd04.prod.outlook.com (20.177.34.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Mon, 21 Jan 2019 19:57:20 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::b800:e18:108b:416d]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::b800:e18:108b:416d%4]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 19:57:20 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.tropschug@ebs-systart.com" <a.tropschug@ebs-systart.com>,
        "m.bittner@ebs-systart.com" <m.bittner@ebs-systart.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Thread-Topic: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Thread-Index: AQHUq/Lk15my91rUHUKDVZZyCZSL36WvDtCAgAIdiYCAAB2rAIAAZq+AgAeXPACAAOZ8UA==
Date:   Mon, 21 Jan 2019 19:57:20 +0000
Message-ID: <AM6PR04MB5863AE2A3DD74882BEC680CA8F9F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
 <20190116101441.GH15808@dragon> <20190121060950.GA8713@Mani-XPS-13-9360>
In-Reply-To: <20190121060950.GA8713@Mani-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5014;6:iNxkU7ZTMFOs2g45j8Rmq+rvCu45N0QxbNlnAYGHOkH/ROaIvsIlmsGPtyMtz78+/wCsUSM4PnDEhv/gvW5LrRJCVwj/jLuBpK/Q3poyxri2xZCjHyyx4I/BhxL/3n9lWxAvWLmw8ITGex0UkJNFTBBPATyQMqI4pL7teant83QqhqeWlkKk+NBU9bXr1iW/Wv7veat1J5DjuMqmdxqUpEpo/ZdAchdLvLgsauHf/kJVRTqA5z1U8FjOwA+iEZ5B9St2L4ngTtPPSBAStOT+cBOLKg5yl3hrWnOWwvXr8q6qlT5MHowvyGKdgC5lfAZNxM7vB237hYSwGELMxlXZRWbLLsZEvycKqU/PKjBpLQIS0w0BjRr7L/AfCfQ1nSqltwQhn5hUh0Pi1rrQHK07FNdphfnDxm80fYspuclIOcoedURWcun6OG5sxRuaXgGrZVdgpF7b7BVAqFNICu/P3Q==;5:S7/p1BA+jkm0pxcdXxp7g8TRq1MVKP7PjgYiDWcxdRY8nxs7Wd3egHLUWn/T5sBMxlpsjJEc5sG4nbj97VxrzXQ9Tb4WC0WV7JxfyVX8fS8Wlsr4ITLxCROIZGKR0YqYWBrMHYIbzQNAW8LpMm60qOm7s47WGc2xiaZ8JLbDAQFVfT1/9nxvi6y4xkWqH9+MBJg4LAnibgGisjwfaZobOA==;7:ouyjTg41x/GPOpNFPcK2xYHJhub6GI13RRkXSWhwJZip0+ti/rwGCFv4H7W1Dd9LlIeP+Fpg1F7p44t1pnTXWnHAnKTiYqA2uJCwvIIfQpHzDY0d6D6T1eH3TviPf8+YR2Hlh0jQ8GG89XHLV8uYBQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 250f64fa-99c8-46e0-4bfd-08d67fdaa762
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5014;
x-ms-traffictypediagnostic: AM6PR04MB5014:
x-microsoft-antispam-prvs: <AM6PR04MB5014D1C4F3DE6CF1D007339D8F9F0@AM6PR04MB5014.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(13464003)(199004)(189003)(102836004)(81166006)(97736004)(6506007)(74316002)(53546011)(26005)(7736002)(66066001)(3846002)(6116002)(71200400001)(71190400001)(186003)(4326008)(99286004)(8676002)(305945005)(81156014)(2906002)(6436002)(105586002)(486006)(14444005)(256004)(476003)(93886005)(25786009)(446003)(33656002)(229853002)(6246003)(7696005)(316002)(11346002)(106356001)(8936002)(76176011)(478600001)(53936002)(54906003)(110136005)(55016002)(14454004)(9686003)(68736007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5014;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j4TeJPYXoLuYcuASVQnzkfDTlc33CplNbSAoTF1qcffsA8MZpfOTJIhFQkpKbyA+/iZywdsm1Hg7iYkjQIvOCoPhB5Ujgkfz7Fgp+tofa2AduSL80o4DCWgwADoraB07Yq6bDGjMytEpSVjh0M5zDUxwzp085VTlq0HfN0TlaTL7CMZiSM+zupRqeH9ts3o3/aRy8uzFT3iGzHaJI0a1Cw5xpBkOU4kBBgqCkwnbk9gmwj2IP+EYOSgwnusVZt1IKj/p6hMEoabM3cTj3YnF8fW1b0OKe4N4pNHZnO1obKib8nYHXnwHTepal0Uay+MuLsXr23Yx7i3qOJNQx/wdFeqBUwCvY2oTuYMLKE19eZL9RVSGag2uA7grqFlPA24earyRMD7IAyq5ufuoPHrTHmJ3K1fPpiZFrDi7FYmL764=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f64fa-99c8-46e0-4bfd-08d67fdaa762
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 19:57:20.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Sent: Monday, January 21, 2019 12:10 AM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>
> Cc: Leo Li <leoyang.li@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> a.tropschug@ebs-systart.com; m.bittner@ebs-systart.com; Amit Kucheria
> <amit.kucheria@linaro.org>
> Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding=
 for
> Oxalis
>=20
> On Wed, Jan 16, 2019 at 06:14:43PM +0800, Shawn Guo wrote:
> > On Tue, Jan 15, 2019 at 10:07:12PM -0600, Rob Herring wrote:
> > > On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org>
> wrote:
> > > >
> > > > On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > > > > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > >
> > > > > > Add devicetree binding for Oxalis board in JSON format. While
> > > > > > adding that, let's fix the description for LS1012A also.
> > > > > >
> > > > > > Signed-off-by: Manivannan Sadhasivam
> > > > > > <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > index d34fe0749199..0f30142fe316 100644
> > > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > @@ -173,12 +173,13 @@ properties:
> > > > > >                - fsl,vf610
> > > > > >                - fsl,vf610m4
> > > > > >
> > > > > > -      - description: LS1021A based Boards
> > > > > > +      - description: LS1012A based Boards
> > > > >
> > > > > Well, yes that was wrong...
> > > > >
> > > > > >          items:
> > > > > >            - enum:
> > > > > >                - fsl,ls1012a-rdb
> > > > > >                - fsl,ls1012a-frdm
> > > > > >                - fsl,ls1012a-qds
> > > > > > +              - ebs-systart,oxalis
> > > > >
> > > > > Sort alphabetically.
> > > > >
> > > > > >            - const: fsl,ls1021a
> > > > >
> > > > > And this is wrong too.
> > > > >
> > > > > I you just change it, then we will be missing an entry for LS1021=
A.
> > > > > What's the status of that SoC because there is no board dts
> > > > > file? We should not have .dtsi files in the kernel which don't ge=
t built.
> > > >
> > > > Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect
> > > > it's just a typo of LS1012A.
> > > >
> > > > @Leo, do we have a LS1021A SoC?
> > >
> > > arch/arm/boot/dts/ls1021a.dtsi
> >
> > Oops, I only searched arm64 folder.
> >
> > So it seems the compatible of the boards below are missing there.
> >
> >   ls1021a-moxa-uc-8410a.dts
> >   ls1021a-qds.dts
> >   ls1021a-twr.dts
>=20
> So how should we proceed here? The above mentioned boards are lacking
> compatible in dts files and I guess that's the reason they didn't get
> mentioned in "fsl" binding file.
>=20
> Should I just go ahead and add the compatibles for these boards and list
> them in binding file?

Please go ahead and do that.  One thing is that the moxa-uc-8410a board is =
a 3rd-party board, not sure if it should belong to the fsl binding file.

Regards,
Leo
