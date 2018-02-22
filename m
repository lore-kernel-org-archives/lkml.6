Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeBVHxj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:53:39 -0500
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:63216
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751657AbeBVHxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:53:37 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Thread-Topic: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Thread-Index: AQHTq0oe1egyu3UtxUeuw62kdr00GKOvV84AgACzOQCAAALdgA==
Date: Thu, 22 Feb 2018 07:53:33 +0000
Message-ID: <1519286013.13463.59.camel@nxp.com>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
         <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
         <20180222074318.qsf7x4jnyhvasq5u@mwanda>
In-Reply-To: <20180222074318.qsf7x4jnyhvasq5u@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3742;7:cCdkzDt+szPALy1Vrz/8qEsow4i+CfmSbkKfw0aYsTyl3xO/kSsWVM/7GtRPMSZcCXuxlVsemDyfQ8UjqWdy47GnAvwc0zrs/BRewQdN1RmEm1uat5QHXpyPNseKQbLOrMB/n10rZFhX6qMNgQxyfFcfNnKq0mJbmfSxOFe7w3IiPHgQPZlWpIesN3C75m8E5zn0J2hOXB12n3eYPDxEnY4wxV7Uix9Hq1g5z9m+JelFhwK38sKCpOC1FSnonS1J
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 21c95ed8-9806-4fe0-abf7-08d579c95f89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3742;
x-ms-traffictypediagnostic: VI1PR0402MB3742:
x-microsoft-antispam-prvs: <VI1PR0402MB3742323E31D763A7F4374005F9CD0@VI1PR0402MB3742.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001077)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0402MB3742;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3742;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(39380400002)(366004)(346002)(377424004)(189003)(199004)(2501003)(68736007)(3660700001)(305945005)(7736002)(110136005)(97736004)(2900100001)(3280700002)(316002)(25786009)(99286004)(86362001)(5660300001)(6486002)(6506007)(39060400002)(2950100002)(14454004)(54906003)(4326008)(229853002)(478600001)(53546011)(66066001)(76176011)(186003)(6436002)(6512007)(106356001)(6246003)(103116003)(8936002)(8676002)(81166006)(36756003)(102836004)(26005)(2906002)(59450400001)(105586002)(5250100002)(8666007)(53936002)(7416002)(81156014)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3742;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: urd7qimdN5OesPT/kkaIIzl5CdI/G+NTLHP+v5DNBNDoSNkplNAqylmtzNe9siV7oDxG1jEPgtcLqBO3MdniWF1ggh0daDE+TEnBEbddUxMOyFfsmKSBdLzlB6O49Hlr3iQGxP8oioShJ2S2SNYZcg55K49Qjmo1TkioNo0BPWc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F84F53A36B52D43B546DC8610CA52FA@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c95ed8-9806-4fe0-abf7-08d579c95f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 07:53:33.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3742
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1M7riUN009345

Hi Dan,

On Jo, 2018-02-22 at 10:43 +0300, Dan Carpenter wrote:
> On Wed, Feb 21, 2018 at 11:01:50PM +0200, Daniel Baluta wrote:
> > 
> > On Wed, Feb 21, 2018 at 9:28 PM, Rodrigo Siqueira
> > <rodrigosiqueiramelo@gmail.com> wrote:
> > > 
> > > This patch fixes the checkpatch.pl warning:
> > > 
> > > drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
> > > 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> > > 
> > > ... Why this "..." :)?
> > Commit subject could be done better. It is pretty obvious from the code that
> > we change S_IWUSR with 0200.
> > 
> > Better message:
> > 
> > iio:dummy: Fix poke_evN file permissions
> Please stop telling people to say "Fix" when it's not a bug fix...
> 

I agree with you that here "Fix" is an overstatement.

> Also who cares?  The commit message is perfectly clear.

I do care about newcomers really learning on how to write a proper
commit message.

The commit messsage should really say why the patch is needed, no what the patch does.

After several trivial patches newcomers will get into more serious stuff and I wouldn't
want to see a patch with commit message like this:

iio: Change bit 1 of status register

but one that looks like this:

iio: Set power up on chip probe

thanks,
Daniel.
