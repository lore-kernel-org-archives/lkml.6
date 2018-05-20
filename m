Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeETWff (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:35:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10954 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeETWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:35:32 -0400
X-IronPort-AV: E=Sophos;i="5.49,423,1520870400";
   d="scan'208";a="79375006"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAAAdgCAAANfAIAAASwA
Date: Sun, 20 May 2018 22:35:29 +0000
Message-ID: <b0aa2a8737b2d826fea58dc0bc113ddce50f018a.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
         <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
         <20180518090636.GA14738@kmo-pixel>
         <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
         <20180520221733.GA11495@kmo-pixel>
         <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
         <20180520223116.GB11495@kmo-pixel>
In-Reply-To: <20180520223116.GB11495@kmo-pixel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [67.180.189.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0846;7:YoLBHav1N9yXvI9Sdd/tPj/yAYZqa4j7gJqKpLW9jfFfadRDLV/mNs2DOK3qDAMODkle8tefYnCdaBNpeZ+FzN/V+MJlBJ10XGY1aPG/h0INNjzqTEfgVoEFLS5WM6VmGx8CpNEp7yQDdsc3tp6+at9CON7MvT40WYV+Qis9ALCsMDf8w+PbM60YYIr8ruxHfveUzlMI70OmWeuVHviZTmqPVPVcKfI7/vB2x/YyMLQNvGMvaUyTxGSFd132okNY;20:nWslyiBYSrNhEjH0N3/eodlN90fw9+MIIEihj+WFAabM0Wpn59EQCTIavKHP8HWwdv4RtZP1yztPE8iTWE8vSN5jb5awOTWjNgIQHlEPwjnCFTbnF+xHsfAXLwhX5zetdIOVZ5J7B8n0mYQvwkKnTJ5buRiL/HMwQTdbmk5XXtQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0846;
x-ms-traffictypediagnostic: MWHPR04MB0846:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0846BE154E71D802223CD27098960@MWHPR04MB0846.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0846;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0846;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(39380400002)(376002)(377424004)(199004)(189003)(446003)(316002)(229853002)(2351001)(105586002)(6506007)(305945005)(106356001)(97736004)(1361003)(2900100001)(93886005)(11346002)(486006)(476003)(59450400001)(2616005)(86362001)(68736007)(54906003)(36756003)(5640700003)(6306002)(6512007)(14454004)(7736002)(53936002)(6246003)(39060400002)(6916009)(118296001)(76176011)(5250100002)(102836004)(8936002)(3660700001)(4326008)(478600001)(2501003)(26005)(81166006)(99286004)(25786009)(81156014)(3280700002)(8676002)(66066001)(5660300001)(6436002)(6116002)(2906002)(3846002)(6486002)(186003)(72206003)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0846;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n5lsP5uEO1F3SYVkVxMesjdqErJmQNan/gi0Klv4WSWkjkPhE2Ph4y7mPma59kKXEPAFBltfrjaDXyTRCHP27OzOzFcFqvIGwP50gFE2wDqoMwcTS0K6VBJafB5n+V8hosIBeuMxEshf2t2/je/jCjUkOuU+F7z7qsOfz5q25S5F84oLgCgWMbd8qqQlIzVA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF5011A6CF2AF24FBEEEA7D497CE0A1D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d1e84f74-ed20-441c-736a-08d5bea1fdc9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e84f74-ed20-441c-736a-08d5bea1fdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 22:35:29.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0846
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KMZe5K016392

On Sun, 2018-05-20 at 18:31 -0400, Kent Overstreet wrote:
> On Sun, May 20, 2018 at 10:19:13PM +0000, Bart Van Assche wrote:
> > On Sun, 2018-05-20 at 18:17 -0400, Kent Overstreet wrote:
> > > On Fri, May 18, 2018 at 03:12:27PM +0000, Bart Van Assche wrote:
> > > > On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> > > > > On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > > > > > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > > > > > you have a look?
> > > > > 
> > > > > Any hints on how to reproduce it?
> > > > 
> > > > Sure. This is how I triggered it:
> > > > * Clone https://github.com/bvanassche/srp-test.
> > > > * Follow the instructions in README.md.
> > > > * Run srp-test/run_tests -c -r 10
> > > 
> > > Can you bisect it? I don't have infiniband hardware handy...
> > 
> > Hello Kent,
> > 
> > Have you noticed that the test I described uses the rdma_rxe driver and hence that
> > no InfiniBand hardware is needed to run that test?
> 
> No, I'm not terribly familiar with infiniband stuff....
> 
> Do you have some sort of self contained test/qemu recipe? I would really rather
> not have to figure out how to configure multipath, and infiniband, and I'm not
> even sure what else is needed based on that readme...

Hello Kent,

Please have another look at the srp-test README. The instructions in that document
are easy to follow. No multipath nor any InfiniBand knowledge is required. The test
even can be run in a virtual machine in case you would be worried about potential
impact of the test on the rest of the system.

Bart.
