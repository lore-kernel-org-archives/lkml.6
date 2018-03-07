Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbeCGQTK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:19:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14085 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGQTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:19:05 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515427200";
   d="scan'208";a="72960732"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] lib/scatterlist: Unexport some trivial wrappers
Thread-Topic: [PATCH 4/6] lib/scatterlist: Unexport some trivial wrappers
Thread-Index: AQHTthJ7zkRjw7nDv0qSDdGT/47QzKPE89sA
Date: Wed, 7 Mar 2018 16:19:01 +0000
Message-ID: <1520439540.2890.19.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
         <20180307124712.14963-5-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20180307124712.14963-5-tvrtko.ursulin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0305;7:n3uxq9Zxg25U9U6/F2OVebCBsRaDpO8MK300CO0aGMlDd0ndAz6Ra0MJCqbmZ4agP6yd+q/PHvkWoI36t+cBRd4s8Xrz8Suy8scxshod48VL56s/OnavAZRCUoh1CN9C1N5SbDrU9+2HQjTSLr8vvsE6BPOdC5c+QH2ZL9VJzZXaiji2p8xywT6nBpo+SShCdJ+ooOSacQvt8QkJdVC/3DdSbkarD1Bv8ZwCMhdow+nyGBAErLggXA6iew/Q3Yzq;20:OE052saYUiA0p5jd0jJG3CABXZ4jN7//ipYc0ehIYZtjcOUCZe1+/pBkpin8Ky8ZnYV2OYe7TkTqzubZZ80/GrtZPxzl0482eDwlu+AKum7nVo7mISvq5VZJjt8m1TNUeUa+fIpDD3sIxAK5YRDbMV7CSLWEklIWFmVXRokbmqA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f03d9f25-2402-4b7a-ce5e-08d5844723b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0305;
x-ms-traffictypediagnostic: MWHPR04MB0305:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB030524C30C2365AAFA82D09098D80@MWHPR04MB0305.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0305;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0305;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(377424004)(199004)(189003)(14454004)(3660700001)(7736002)(3846002)(6116002)(6506007)(106356001)(2900100001)(76176011)(105586002)(229853002)(5660300001)(8936002)(8676002)(81156014)(72206003)(81166006)(305945005)(478600001)(2906002)(86362001)(2950100002)(3280700002)(186003)(25786009)(4326008)(6512007)(6486002)(68736007)(6246003)(316002)(6436002)(102836004)(36756003)(26005)(110136005)(5250100002)(66066001)(2501003)(99286004)(97736004)(54906003)(103116003)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0305;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fXXqI0PcOWBcvZjPQnsgwAzOMngtHO93x/QRuUJxKSfTlVfaCDXgAaFtD8f1HJB5L8iy1ulhLvamlonsOekmWF2Z8/m+JFb/nTURToFdP4QD2zSu1WmGqFi5YQoiUMwExCydhnNmsnUl1YOHhPYwX5H3kBU9aKBDBmd28Ylszz5VJtmqmfKx6OdzA5gLuFWAM3TaMqoPPpYkdKKSAohEnNvUBVMSBTc0lI/86O4ekoVD2AvS7WHU/W0eRQt3h1X05U+SArEFxgvBZTpAWASps+G8omq0c9b/mtPuQLir9knawLsnqJGPDYzCxx1lIKeUsmwwHMkLY9V09iooNDZIdg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <08D6B93AC667B641BB23C40A520F7E76@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d9f25-2402-4b7a-ce5e-08d5844723b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 16:19:01.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0305
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27GJGNk007064

On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
> Save some kernel size by moving trivial wrappers to header as static
> inline instead of exporting symbols for them.

Something that you may be unaware of is that the introduction of the sgl
helper functions is only a first step. The next step will be to introduce
a caching allocator for sg-lists. So for small sg-lists inlining won't
help performance. But moving these definitions from a .c file into a .h
file will (slightly) slow down kernel compilation. So I'd prefer that you
drop this patch.

Thanks,

Bart.
