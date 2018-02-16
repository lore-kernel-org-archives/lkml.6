Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966471AbeBPM23 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:28:29 -0500
Received: from mail-he1eur01on0055.outbound.protection.outlook.com ([104.47.0.55]:41876
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966413AbeBPM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:28:26 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mihai.serban@gmail.com" <mihai.serban@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mihai.serban@nxp.com" <mihai.serban@nxp.com>
Subject: Re: [PATCH v4 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Thread-Topic: [PATCH v4 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Thread-Index: AQHTpNchuluSnV45o0Os70Viwq6WnqOm9ciAgAADzIA=
Date: Fri, 16 Feb 2018 12:28:21 +0000
Message-ID: <1518784101.9517.21.camel@nxp.com>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
         <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
         <20180216121445.GH5886@sirena.org.uk>
In-Reply-To: <20180216121445.GH5886@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0712;7:DA3yaR+Hp1Rcu18fINOv6P6BvsHRixce/vSa2aS5ciO4clvZcvz/1dF4WeBTHJL6qQrNYTdpVCqJGBH6tUuzo6PLHh7/j2K5Cfe15R3xsRw27iPx1Ux5Z+13twwrDJlNSenovE3ElawFeSvZQWNsp2kx/cru/y41bb2RKQKNG38iyRK+LP4OR9BFc203Q6RtoxbQGBktf8VgUNe/bownAe2bQ1CRH9zbFAgbyHCTx/L/e6o0JgrALaNuD/O1LaHb
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 725f4f75-5eb2-4b6b-dfbc-08d57538c4b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB0712;
x-ms-traffictypediagnostic: AM3PR04MB0712:
x-microsoft-antispam-prvs: <AM3PR04MB0712EE5B03E31DFF54EA6F65F9CB0@AM3PR04MB0712.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB0712;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0712;
x-forefront-prvs: 0585417D7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(366004)(39860400002)(396003)(199004)(189003)(377424004)(5250100002)(2501003)(3846002)(6116002)(6436002)(14454004)(2950100002)(76176011)(6246003)(66066001)(106356001)(39060400002)(3280700002)(25786009)(86362001)(36756003)(229853002)(68736007)(105586002)(2906002)(4326008)(54906003)(99286004)(7416002)(7736002)(6486002)(305945005)(26005)(3660700001)(110136005)(186003)(97736004)(81166006)(5660300001)(103116003)(53936002)(316002)(8676002)(102836004)(6512007)(81156014)(2900100001)(478600001)(6306002)(6506007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0712;H:AM3PR04MB500.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ad6kAXoUvVqcN2POP64Ofsgk2XsGQ6kLWn9shtOO7//KfwLfa9GJZv0wRTYTmCWR9cQMLeg7zRZ2swcyYasDPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E59F09E99505474789D8B931C8BFEA55@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725f4f75-5eb2-4b6b-dfbc-08d57538c4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2018 12:28:22.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GCSYkW004270

On Vi, 2018-02-16 at 12:14 +0000, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:29:33PM +0200, Daniel Baluta wrote:
> 
> > 
> > +++ b/sound/soc/codecs/ak5558.c
> > @@ -0,0 +1,417 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> Just make this a C++ commment, don't mix C and C++ - it looks neater.
> Otherwise this looks good so I'll apply, please send a followup patch
> for the above.

Hi Mark,

Will send a separate patch to fix this.

Anyhow, lets make sure that I got it right because looking into
sound/soc/codecs I can see a mixes of styles.

So, for ak5558.c the correct code should be:

// SPDX-License-Identifier: GPL-2.0
//
// Audio driver for AK5558 ADC
//
// Copyright (C) 2015 Asahi Kasei Microdevices Corporation
// Copyright 2018 NXP
//

Now, for the .h there is a total different story. As per Philippe's
link to documentation [1]

the .h file should start with:

C header:	/* SPDX-License-Identifier: <SPDX License Expression> */

So, is the header ak5558.h looking like this, all right?


/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Audio driver header for AK5558
 *
 * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
 * Copyright 2018 NXP
 */

Are you willing to take patches fixing the SPDX identifier for the rest of the codecs in sounc/soc/codecs?

I've got a bunch of students looking for cleanup patches in their application for Google Summer of Code :).

thanks,
Daniel.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst#n67
