Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeETWTU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:19:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45284 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeETWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:19:17 -0400
X-IronPort-AV: E=Sophos;i="5.49,423,1520870400";
   d="scan'208";a="80091717"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAAAdgA=
Date: Sun, 20 May 2018 22:19:13 +0000
Message-ID: <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
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
x-originating-ip: [67.180.189.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0815;7:08jmT4VmzbGB+XaxNL2miJS7tSYaTtfEjAziIOzdU2LfbwueFuzeoa/bDH9SSdpXiJ/4zw2ZImVhWqoIcbnm3MVWnsOexQZNlyWxjRtiMaMWn2i3zEitSLYChLSBrr9zM3f2WZiolQQIPUdAwK3j+qfadbvI8uItWgCsR/OJZpKTon5+nXBk/iEfh+UACtyjup97XsAi9fjkRIub8ImzSXhefP3qQGBOUvrCJG/PvEc7CvI5zwBf7K/j1KX4ONfa;20:IINyhGKwFqD+mnaO47M66ul4j1Rp8OlT2rDhL9yKvg6e50Ao/c6sb8iAK3lOaKG9XhMRHyvcozXrOjwyKvXBHw/pim/K04Lmll7A6XpcXIOGRkAGxTGC7wGghLHrFXnNyvU3caM53XDPx95kjMOUPUSqb/OkdlFKNO2yWJ8caGo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0815;
x-ms-traffictypediagnostic: MWHPR04MB0815:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0815C69E6C178241A496BE2898960@MWHPR04MB0815.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0815;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0815;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(39380400002)(346002)(376002)(396003)(377424004)(189003)(199004)(2906002)(6306002)(36756003)(6916009)(6512007)(6246003)(3660700001)(54906003)(26005)(7736002)(186003)(72206003)(68736007)(97736004)(53936002)(118296001)(39060400002)(4326008)(6506007)(5250100002)(25786009)(66066001)(6436002)(59450400001)(229853002)(102836004)(2501003)(6486002)(3280700002)(3846002)(6116002)(81166006)(478600001)(81156014)(966005)(5640700003)(86362001)(76176011)(8676002)(99286004)(305945005)(2351001)(316002)(476003)(446003)(105586002)(486006)(8936002)(106356001)(93886005)(11346002)(1361003)(2900100001)(5660300001)(2616005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0815;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +9O4d3i0MX6TWaZJG4JVlZWttOpy8gtp94ICe0ac3ZMlNueDwAYfIiZPAtFtCNe3dbY20/M0geiPGDVDQoRmSkRA/KYWZVkmRvi9nRoCLSpPW6MKvljOv685hWfgdl0LP/oHddAGeEN38RC0BLLEprRGg7D0VUp5phTc5Br4k5Fp3j7JdYlH9wBZTycrVL4Z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0083DEEA2BC16C4BA75BBB80A2A4FB3A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3012546a-4de7-4ced-1f05-08d5be9fb791
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3012546a-4de7-4ced-1f05-08d5be9fb791
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 22:19:13.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0815
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KMJNs5016283

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

Have you noticed that the test I described uses the rdma_rxe driver and hence that
no InfiniBand hardware is needed to run that test?

Thanks,

Bart.
