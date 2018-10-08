Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1424C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sGQO4j0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8B120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJHRtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:49:47 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:30689
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbeJHRtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvZuuU+b6Fe8TqbAd0Zg8J7n1nC8vAauVy2CROTO6rA=;
 b=sGQO4j0ivHro+O22K6dS+79XsT1eHnQSW3P5USE8f/nxsc2ns5we+NLLHl3EL7251mWXiaoX5ZMTj1tYMuN8R13sUzkGKW8xrOU1ECrZxcY3Vr1Pd8xXh6UdYvv8j75ma3bzGtaGbLos5K4FFbxonmBXiDyEiQB6tuzYGVbNS3I=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 10:38:39 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 10:38:39 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Thread-Topic: [PATCH 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Thread-Index: AQHUXkMvvHcqFpueP0qHSdZ6R8hfv6UU9PgAgAA0hrA=
Date:   Mon, 8 Oct 2018 10:38:39 +0000
Message-ID: <AM0PR04MB421161DEADF1439C2D8BBB7D80E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1538918657-2032-1-git-send-email-aisheng.dong@nxp.com>
 <20181008073010.GO3587@dragon>
In-Reply-To: <20181008073010.GO3587@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4353;6:rX8nxI486rrv1rz/kJ4TmudI/VQ3dxSxAr15krfeRK+9BD0wMFRSkJYgQOiMUMgrmEKfVlb6rJkVN6IisG8KSbM8+EA4Yv1HjkfFLO2Jca2fvOMlI6hQxhSWrzPAYCXdf5mus8l3gx4xHdu7POgcfQJtV+sT7vdReMo3llG0PJjBXo8uC8E4HmdMjsvCdYA5DjgRg9vKFv0+7/oz9HnSrEvwU9F7JTHGqV+pXdl2PuAIGJHZsL8LbTPXPFii9TNPlEd2pDIW7EShGKv9CftH5BD2QJTa55OUyFacDih050Kq5n93Xg0mqw52Oh8x1A6ou8iEDLX0I6zUW+iYJbJaU1fQjNNaZmtr/6NXs3rUx9vlPiB5vWRCIeGU9tDIHaugnfeuuxjir4x9yo5ksBiyV56SUFh14wIPEb5+vEjIY5sWMo3TkNV6t6yiwx1TFM0JPnNee9oJXdlpjDP1T3Riaw==;5:BrV1RcgNgQoCwxR6aisuQPUXli5Wlp3uRpkl9lEuZCv1cJwsAd1gi/DEOxOA/1CwliuHwiTOdvb1Wz8baExtqrZzB75pinusBSpT+qmrAoz6vOtjQznJ/reMk75jA5iry6Qbdyj+XT3cbjnlA77hLFhUsJw7PrcLcuEUYPC4oYI=;7:ysAxzVHJqCIySkSnIgO+m8ll8RPCSVMT/wrrGnhVveIzpEL+YS+4VZGfRrsavYTZsuLYudHiX+gfvYj0/5F91X9zXEibKp5YupWIOy//K5W55IrLkwjPkn+ea8wSBpp0/oDHEVecjZxRRW7rxEht9FS7YUgkq0xCBbTN1QhZTkJt0IFAsdjFLJIlMk/XTYx/BdH++8UVvRTj/jG3X5aoHEf7GNEf1d1fBHpa7DV5Qm04scXn2XNpfQNQ/ISnfo7m
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 087a49ac-8a84-4ebd-dd93-08d62d0a35fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4353;
x-ms-traffictypediagnostic: AM0PR04MB4353:
x-microsoft-antispam-prvs: <AM0PR04MB4353D064EDD54C2E5702329480E60@AM0PR04MB4353.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4353;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4353;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(6506007)(68736007)(6116002)(97736004)(3846002)(99286004)(11346002)(5250100002)(55016002)(9686003)(446003)(7696005)(53936002)(229853002)(2906002)(6436002)(76176011)(2900100001)(33656002)(54906003)(66066001)(71200400001)(5660300001)(71190400001)(102836004)(106356001)(4326008)(486006)(74316002)(186003)(476003)(6246003)(7736002)(316002)(105586002)(478600001)(305945005)(39060400002)(6916009)(256004)(14444005)(8676002)(14454004)(86362001)(8936002)(26005)(81166006)(25786009)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4353;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: raNBvrTcAu8Y1nGKGwuIWRsop2LYssSIRnuLO2bMWuiOgyEI0oV32WbDbDQ76H4nIEl2B45hAGaon+TZiywR1eK855LHkOq0XWQGUzspQSvZkRNN7YxRdZrRCeIPNpPAzp96SpKeWWBifxl8Nhjag8puYAJC4Gk5BFZ8TmmTF+q6Iin/zG6MbKWyzMmp7w/c+Hqk6lun9/Q63715lkISMk/DbVUVzlI9EOaOgM5nomrwKBhTy+cshpbwMCG1xZp84TJV4cshP48Pd83m3/NYmw6TmaEd9eNCUUSCMTNQf4jDyqtakLeu9DEK3rruurTFFaye6/OFWu5+08M0R/6CX9ZPnLAsRXBoNTaaCcXnak4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087a49ac-8a84-4ebd-dd93-08d62d0a35fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 10:38:39.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/MAINTAINERS b/MAINTAINERS index 9ad052a..d1fb824 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1462,6 +1462,7 @@ F:	arch/arm/mach-mxs/
> >  F:	arch/arm/boot/dts/imx*
> >  F:	arch/arm/configs/imx*_defconfig
> >  F:	drivers/clk/imx/
> > +F:	drivers/firmware/imx/
>=20
> Please add include/linux/firmware/imx/ too.
>=20

Sorry for missing it. Will update now.

Regards
Dong Aisheng

> Shawn
>=20
> >  F:	drivers/soc/imx/
> >  F:	include/soc/imx/
> >
> > --
> > 2.7.4
> >
