Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBVVWw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:22:52 -0500
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:52544
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751424AbeBVVWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:22:50 -0500
From: York Sun <york.sun@nxp.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
CC: Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, layerscape: allow building for LS1021A
Thread-Topic: [PATCH] EDAC, layerscape: allow building for LS1021A
Thread-Index: AQHTqlzMp+s6+nVFsUO1f+4zS65Fo6OtxyaNgAK6XQCAAHBTZg==
Date: Thu, 22 Feb 2018 21:22:46 +0000
Message-ID: <536737FA-AFEC-487A-ACD3-6F02128061A4@nxp.com>
References: <20180220150912.2954-1-rasmus.villemoes@prevas.dk>
 <BCC182D6-3CC0-40F1-B17A-0E410A20ACC4@nxp.com>,<2d3abe84-e305-1823-5cdf-b6210342224b@prevas.dk>
In-Reply-To: <2d3abe84-e305-1823-5cdf-b6210342224b@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
x-originating-ip: [61.186.39.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1536;7:jzbqfqshYObh21Eo+89WTjbtraXt+rZrSkPlDldjTEs0Y+l2lpCEFLcnqVcVntmWFB2Xnjf5qlhXS2ho65Bwj+P51orG/vhPjJDn0Uh1SodI8REpHSW9vTd5NHqdENFjS2EDfixC31JEnUtk5zDxtUDN1cGy4aAltym9LcNyNl1eencHM6MHDkhte4Dsb6APzaG+a3exey3B0X+cdV+BZKX7rQydyvQ5cypn8gk0Dc/4/2wCuodQl4xBMPNRMlHj
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2588b061-aec3-4d5d-0fab-08d57a3a6b3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB1536;
x-ms-traffictypediagnostic: VI1PR04MB1536:
x-microsoft-antispam-prvs: <VI1PR04MB15368CC97F44D8A830178D629ACD0@VI1PR04MB1536.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR04MB1536;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1536;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(377424004)(199004)(189003)(6116002)(3846002)(25786009)(26005)(36756003)(6436002)(86362001)(6506007)(6512007)(106356001)(9886003)(2900100001)(2950100002)(5003630100001)(83716003)(53546011)(81166006)(81156014)(82746002)(54906003)(6246003)(6486002)(53936002)(99286004)(316002)(5660300001)(8676002)(105586002)(7736002)(186003)(33656002)(2906002)(66066001)(14454004)(305945005)(6916009)(5250100002)(478600001)(68736007)(8936002)(97736004)(229853002)(4326008)(102836004)(3280700002)(3660700001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1536;H:VI1PR04MB2078.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Gk/qcA0nNJJ8UgS2788uG+wkh7g2TVMq1ztP4OjluXdLyfMLjQwmVb+fQ1SLySyp25gQ/vJiHDcHDUHOrfinWZpxldl/sVhJk9xcWelwSgW4A/F5U9BoyhdVhP///hzlEPbIbZ1uDBnNH7G5YWuvbl7dAkByITtnn+kLqJhMNe4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2588b061-aec3-4d5d-0fab-08d57a3a6b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 21:22:46.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1536
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MLMu53018899

Then you are good to go.

York

Sent from my iPhone

> On Feb 22, 2018, at 22:40, Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
>> On 2018-02-20 22:01, York Sun wrote:
>> Sorry for top posting. I am on vacation and replying from my phone.
>> 
>> The controller is compatible and the driver should work. Please double check to make sure you can inject errors and receive interrupt. After that you are good to go.
> 
> I can indeed inject errors and get the interrupt.
> 
> Thanks,
> Rasmus
