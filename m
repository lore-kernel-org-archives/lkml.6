Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D82C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2393A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpByWobk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfBTJuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:50:01 -0500
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:6720
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfBTJuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLas/hhrP6/0NoV2Iff/PEbEvC7D3l5anfyxtPkuOvI=;
 b=PpByWobkdh1DY7FAUpGuB6Zj8TiL7me1HPfaS33skoACyKrFhsEwVPF89hjY1K0OkxHe1Gh0jNjN/k5Ek4iHICq5DFQ30ZXxfjPKDpsBDeQapx4cNxk01dtwUlV5Kja65TBFYV69Fk+RBHZ1S/cNcVKzpQ0C3nHwK8Y2NLqx+t4=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4582.eurprd04.prod.outlook.com (20.176.243.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 09:49:54 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 09:49:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XnE3iAgAAGyxCAABmaAIAABhpAgADPbuCAAE95AIAAFTeQ
Date:   Wed, 20 Feb 2019 09:49:54 +0000
Message-ID: <AM6PR04MB4215014B734F71D409D617A5807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
 <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
 <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220081650.cu3yzausx55jefb6@pengutronix.de>
In-Reply-To: <20190220081650.cu3yzausx55jefb6@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e18a42f-9796-4ad9-6250-08d69718c443
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4582;
x-ms-traffictypediagnostic: AM6PR04MB4582:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB4582;23:kqetdpu6F7V5TF5k8zBYYdv0RFz8T0Wt8bJn55nai?=
 =?us-ascii?Q?zSxAPMsCees43hvstUaUEQ4xzwt1ckbBHUIgP2BGmGqxc2vlhlcD73M2NFPp?=
 =?us-ascii?Q?WlrZxvkLmG9tCWF9E34trYDvVL9uqPBjOFu1GPINwmYdH5ND3/rCTThoCHEQ?=
 =?us-ascii?Q?ahTkYp2qNcuokjQ5g8uaIqKvcWjwXYYm2QjZeMZ61fAS8+eeveSdj2bhSV+/?=
 =?us-ascii?Q?PvDkZUXMnHnt47RlkgdnwvOswPRSZPWI+SETJ+lR/R/RX+sE++x8EDUd1AWF?=
 =?us-ascii?Q?elj2QaePzdbzd+/X/c5oBHlG5xMcz0q0NvEvS9J65MrBCwNZg8tCN5W9T5xi?=
 =?us-ascii?Q?uOImiOU/cc3NSajsbLd6qOZ9NckipFxnkqlPv7R+led/rfgSNz3do/5jPmaj?=
 =?us-ascii?Q?u7SfS8Q1GouELtj81YCJ6rdfWJGNx0/Tf/K+FQ+eSwtem3u9YccGTuYmaEl8?=
 =?us-ascii?Q?PH/ex23cd7ElILQA4fXa7tgRnBATnrNvzvOO0yqY5fMKz7GLzoE6/vg9lqBa?=
 =?us-ascii?Q?XcfHrZRVKQf8XxYKGNXZQFq1DkCQ1KwRqOFf5SVC3gNzcuaoFGU/Si1PKg+A?=
 =?us-ascii?Q?JnF0+GncZSwGpy59Bop3bYze5946iu/FIrJ8b9mRAsyk6Y3o2CSYohPgLlbI?=
 =?us-ascii?Q?oxs2ljywgEAvqFZypY0Ck+k88O+02eH0Sn3U+HwAG+FC6vH5+kwv9B7QOUZF?=
 =?us-ascii?Q?n9lEqWDFZ0+O0mA91uN5ceQZ70DChuB3a93XktqJuVUOFLlFbZFm1g7RpcV7?=
 =?us-ascii?Q?yP01hpzr6a4aXp6qPKEMXQNBHatUZd8K3HG5cFmhrWUH9NSaft378uMN3n1g?=
 =?us-ascii?Q?ih9TGdFgCCBx/QCx2G3mFoGSnL/sn4IZ6bz/WhH2YXGyEwHfOosNPTAaZWSt?=
 =?us-ascii?Q?eusK9ZX+AQe4HErvCFL649Ww9I88zpBVzApblTEs0Ev0hsrlzPNYwdOxOccV?=
 =?us-ascii?Q?/aW8dg+pZXJc3CAPyZV+Tmo2XoEgz9LmG9LnwuShhB6x+fwW9/uaIiiz1GGN?=
 =?us-ascii?Q?njA5YLoHBCKk3cKVW0kCi5tu+ImIfNxXs/zOG6hQoCWrcfxLZ1NqJpFAwea3?=
 =?us-ascii?Q?IpNwNJyb/vQZDnP1+vkMBLoEHkGnL1qo5QMFFN9IhgksRxGgzGYxjVEM34sr?=
 =?us-ascii?Q?suN1Um0ncKGBeoLbvw2cZwpX0wvuGFDUmL5TStDlOHWTU8C3En3/5SrALHnI?=
 =?us-ascii?Q?bxBm2vt+VxI9aG47r08FG9NfwkXILQTSC/HCkaHIxHbM75DCeiCzDJiiqyR1?=
 =?us-ascii?Q?uhWRtbbGZtiZfuoA5KUxs2lQiQDYLHzHQHP78mPBvHth/VTA5W+jnZEhJcpX?=
 =?us-ascii?Q?ojHvmGqQV3NgycYccyX8HLpKApAMcWBJoVjymEyq14p?=
x-microsoft-antispam-prvs: <AM6PR04MB4582423C45DE2E080F136DFF807D0@AM6PR04MB4582.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(52314003)(199004)(189003)(86362001)(486006)(476003)(11346002)(186003)(55016002)(6436002)(44832011)(446003)(9686003)(25786009)(4326008)(74316002)(5660300002)(105586002)(26005)(14454004)(478600001)(2906002)(106356001)(6246003)(33656002)(53936002)(256004)(15650500001)(8936002)(81156014)(71190400001)(71200400001)(305945005)(8676002)(6116002)(7736002)(3846002)(97736004)(7416002)(7696005)(102836004)(93886005)(53546011)(6506007)(54906003)(316002)(68736007)(99286004)(6916009)(229853002)(76176011)(66066001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4582;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: euXjtf4FHgWtQKL+QBwXb1MWpTPAmtphHcyYlRvK6TPcnIi8nPiuZ7X56HIHd/6+UyOW1gfh7HpxwSdCC/BVAmlclJhzOreoB0sGI9qWvnPkoGMzLNoTr0ny4ZmdSyg1hapFf5z8BYIQl69zc21PIrPlz437pazNknPHb7/Yhe3ppus/KgYKESJn+X9aNSp31fOMfppSbdNy29WFOm3zbl8oUsC7kafoXuvBtPXr8Ur/DczqjmdQDXpPlcPc3hQNw5+UM834zZxWezwpzPokoO9PUFAnaPrXv9uNEjh1Vz4TEfwJOQnqNzxN2Y3FwYHGI6p1xgdsCxfE0yiE2rSsPwmRu0znjQTol2emzXoISBxbcFqjMb/S4JJbZRRnWjNfLA/C0Cbn02ufE1Zmq7y2dwV19Ev2/da91ljM/oSxYWg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e18a42f-9796-4ad9-6250-08d69718c443
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 09:49:54.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> Sent: Wednesday, February 20, 2019 4:17 PM
> On 19-02-20 03:38, Aisheng Dong wrote:
> > [...]
> >
> > > > I don't like droping some ID's (e.g. IMX_SC_R_DC_0_CAPTURE0) by
> > > > mark them as unused or even worse give them a other meaning. IMHO
> > > > the scu-api should be stable since day 1 and the ID's should only b=
e
> extended.
> > > > Marking ID's as deprecated is much better than moving them around.
> > >
> > > I agree the SCU APIs should be stable since day 1 and the ID should
> > > ONLY be extended, but that is the best cases, the reality is, there
> > > are different SoCs/Revision, some revisions may remove the resources
> > > ID defined in pre-coded SCU firmware, like the
> > > IMX_SC_R_DC_0_CAPTURE0 etc., so SCU APIs removes them after real
> > > silicon arrived, now latest SCU firmware marks them as UNUSED, they
> > > could be replaced by some other new resources in later new SoC, I am
> > > NOT sure, but if it happens, this resource ID table should be
> > > updated anyway, leaving the out-of-date resource ID table there will =
have
> issues, since it is NOT sync with SCU firmware.
> > >
> > > So how to resolve such issue? We hope the SCU firmware should be
> > > stable since day 1, but the truth is NOT, could be still some
> > > updates but NOT very often. And I believe the updates will NOT break =
old
> kernel version.
>=20
> Hi Anson,
>=20
> Please don't mix the dt-bindings and the kernel related stuff.
> Unfortunately the bindings are within the kernel repo which in fact is gr=
eat for
> us kernel developer but the bindings are also used in other projects such=
 as
> barebox or other kernels (don't know the BSD guys). So you can't ensure t=
hat
> your change will break something. Please keep that in mind.
>=20
> IMHO solving that issue should be done by the scu firmware. I tought the =
scu is
> a cortex-m4 with a bunch of embedded flash and ram (I don't know that muc=
h
> about the scu since it is closed/black-boxed). Why do you don't use a
> translation table within the scu? As I said earlier I don't like the rede=
finition of
> ID's since they are now part of the dt-bindings.
> The bindings can store up to 32bit values which is a large number ;) IMHO
> wasting some ID's in favour of stability is a better solution.
>=20

As far as I know, those remove resource IDs are pre-defined and has never b=
een used
and won't be used anymore by SC firmware. (Anson can double check it)
So I think it's safe to remove them or mark them as deprecated.

Personally I may prefer to remove them as they never worked to avoid confus=
ing,
especially at this early stage for mx8.

Regards
Dong Aisheng
