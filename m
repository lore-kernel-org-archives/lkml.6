Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeEUPLV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:11:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46750 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeEUPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:11:11 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520870400";
   d="scan'208";a="175327696"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAAAdgCAAANfAIAAASwAgAAM54CAAAVVAIAABROAgAD+3gA=
Date: Mon, 21 May 2018 15:11:08 +0000
Message-ID: <d3fbfaa667f5ac64c1f230249e3333594cb4a128.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
         <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
         <20180518090636.GA14738@kmo-pixel>
         <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
         <20180520221733.GA11495@kmo-pixel>
         <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
         <20180520223116.GB11495@kmo-pixel>
         <b0aa2a8737b2d826fea58dc0bc113ddce50f018a.camel@wdc.com>
         <20180520232139.GE11495@kmo-pixel>
         <238bacfbc43245159c1586189a436efbb069306b.camel@wdc.com>
         <20180520235853.GF11495@kmo-pixel>
In-Reply-To: <20180520235853.GF11495@kmo-pixel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0527;7:Lf8ad4/LrkwcFMazzI3DeYRcCXj7qQE707ZFuIPOrx7jl91/bTR0DHdLiOmUNKtpEVPRLfcOPt+GfbJIgh0dEb3V3klRy11OIRW4fN5BAI02P5wyuByFfiCQCqi0kM4x2MBj4lPFlccuH611YL1udWaGuS+0IsESA4fxfSvPVL4SrMmufLSTG0Dul3yd/TGKvVgD7rHRS6w4ZrXUIfD2nmNe9mb7hppMDbBRsO34RlWYv3ficZr0Y8MeeGeJqLf6;20:60C3DHNy+cpH4gokETc16OsP5bGpSwXjYE8f0nWQbJdcFeNya2n/IUGZ6JwL/ldm2seGYrivkAkrnNrPio+9JI4r1bpmUbIf9NaHlkz5tz9tJBqn8a9SqqmwPAq+1SwVY12aIR/8qqrVo3cXOFQoKyzVYLa+0Nx2a60Bn+VxKKc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0527;
x-ms-traffictypediagnostic: MWHPR04MB0527:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0527ABBB42D0D4B1E7A801C498950@MWHPR04MB0527.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0527;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0527;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(199004)(189003)(377424004)(14454004)(5660300001)(39060400002)(3846002)(6116002)(8676002)(81166006)(105586002)(81156014)(5250100002)(476003)(486006)(11346002)(2616005)(446003)(68736007)(26005)(2501003)(102836004)(36756003)(6246003)(3280700002)(106356001)(4326008)(7736002)(3660700001)(305945005)(8936002)(2906002)(99286004)(25786009)(2351001)(66066001)(478600001)(6916009)(59450400001)(6506007)(118296001)(6512007)(72206003)(86362001)(53936002)(6436002)(5640700003)(6486002)(316002)(229853002)(76176011)(186003)(54906003)(93886005)(1361003)(97736004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0527;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xLZSVErns8y6dxbDAKgaPPcmFxjLA5UEDJ6glzQlJFg/EjMJ4BvqE+R6VTF8MMT6QdGw0oZltpPFL2byJgq6kBBX/azaByWRnnhFmr3c4hnKQNa12nb/UKlj3k4P9ChnUBEe1ke5tfoLg6llwEqTD5JbUwddFoAcEJ7SIDAzUdB9NTpklUfKEC1zbEWQBHi1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E95219DA71BB46BA28E21F4B376E38@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bf868e4b-92f1-4059-a9bd-08d5bf2d14b7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf868e4b-92f1-4059-a9bd-08d5bf2d14b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 15:11:08.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0527
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LFBSQX015727

On Sun, 2018-05-20 at 19:58 -0400, Kent Overstreet wrote:
> On Sun, May 20, 2018 at 11:40:45PM +0000, Bart Van Assche wrote:
> > On Sun, 2018-05-20 at 19:21 -0400, Kent Overstreet wrote:
> > > I really have better things to do than debug someone else's tests...
> > > [ ... ]
> > > ../run_tests: line 65: cd: /lib/modules/4.16.0+/kernel/block: No such file or directory
> > 
> > Kernel v4.16 is too old to run these tests. The srp-test script needs the
> > following commit that went upstream in kernel v4.17-rc1:
> > 
> > 63cf1a902c9d ("IB/srpt: Add RDMA/CM support")
> 
> Same output on Jens' for-next branch.

Others have been able to run the srp-test software with the instructions
provided earlier in this e-mail thread. Can you share the kernel messages from
around the time the test was run (dmesg, /var/log/messages or /var/log/syslog)?

Thanks,

Bart.
