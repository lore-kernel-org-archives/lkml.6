Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeEVWCE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:02:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57650 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeEVWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:02:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="175468514"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAMgRoA=
Date: Tue, 22 May 2018 22:01:54 +0000
Message-ID: <23d179b9a20859fb9dee1a20d59b9c1e6a72a854.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
         <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
         <20180518090636.GA14738@kmo-pixel>
         <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
         <20180520221733.GA11495@kmo-pixel>
In-Reply-To: <20180520221733.GA11495@kmo-pixel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1201;7:Ukim+YwBF8uSA4JsN4MAN9ZBdnz1qo7f1BdV7/aJZIt2G3ku/G+WCqMMN4YwdbU1FLm3fBMtL8Ok38y1NS1usRFQBfa4jqCXe3o2y1xLSKYDNf1nwJgb2+J723TcHUbdnrwPifW0wG/g03toOOL+B3QxH3tovImshXTw+7aJQy7dJUt5wCEVD17s0JTqbdnpfkzZFV3X8zKOzoP8ti2xtZr4jzIYDwCE7nqqIIjPo0kl40aqelVwzpL+QeYRJV7j;20:urLv9p3PZx7fU34BNGZs5CEjtNwfZklOVGNV50GT2w+jwUc7EHk+3v2lE5B5pSO8zBNhdlJnZFkIebqo9U9Gucnfr1kqNoaarAroCYvpnPb8rq74gHBWD1/cZkmnFmROJY37Ihd5KaAS2whD2mrYbC+neafU0nYI4jXkv1/HNxI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1201;
x-ms-traffictypediagnostic: MWHPR04MB1201:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB120111387F38BBCFD25929C498940@MWHPR04MB1201.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1201;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1201;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(39380400002)(377424004)(199004)(189003)(478600001)(6306002)(2351001)(5640700003)(966005)(2906002)(26005)(3280700002)(2501003)(14454004)(118296001)(53936002)(105586002)(106356001)(25786009)(6436002)(3660700001)(5250100002)(6116002)(186003)(6246003)(39060400002)(4326008)(3846002)(6512007)(97736004)(6486002)(72206003)(68736007)(2900100001)(6916009)(66066001)(7736002)(305945005)(316002)(54906003)(36756003)(81156014)(81166006)(486006)(2616005)(446003)(11346002)(476003)(1361003)(86362001)(59450400001)(8676002)(8936002)(76176011)(102836004)(6506007)(5660300001)(93886005)(99286004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1201;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sr45UZsm82RljTUw5yl8E2BbY+D0biZYrYrqK6AnNL57PKSuRbLezKPkXAF2a4QVHcqvxJL+Y13G002w6/vTXiSYubzMF+e6sTvRxthMY/WM6l0S3uG49P4BjNmteSYRJfjMRLDj7H4sG2q96KdVD939KvZ7YNL1mTiLwY7rqtBuemEm/S5JVUV7H8NxVVEW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFF06B372E3DAD4AAED8ACBA0E99FAEE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a4bf3cf7-a437-4bfc-e9aa-08d5c02fa1a8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bf3cf7-a437-4bfc-e9aa-08d5c02fa1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 22:01:55.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4MM29AR006537

On Sun, 2018-05-20 at 18:17 -0400, Kent Overstreet wrote:
> On Fri, May 18, 2018 at 03:12:27PM +0000, Bart Van Assche wrote:
> > On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> > > On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > > > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > > > you have a look?
> > > 
> > > Any hints on how to reproduce it?
> > 
> > Sure. This is how I triggered it:
> > * Clone https://github.com/bvanassche/srp-test.
> > * Follow the instructions in README.md.
> > * Run srp-test/run_tests -c -r 10
> 
> Can you bisect it? I don't have infiniband hardware handy...

Hello Kent,

The bisect I ran reported the following commit as the first faulty commit:

block: Add warning for bi_next not NULL in bio_endio()

Bart.
