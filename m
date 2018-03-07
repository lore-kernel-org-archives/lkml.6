Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933988AbeCGQXs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:23:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31180 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeCGQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:23:43 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515427200";
   d="scan'208";a="73668586"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: Re: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
Thread-Topic: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
Thread-Index: AQHTthJ6KXzzpEGpZE+JXaJ5GDOoGKPE9SWA
Date: Wed, 7 Mar 2018 16:23:39 +0000
Message-ID: <1520439817.2890.21.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
         <20180307124712.14963-7-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20180307124712.14963-7-tvrtko.ursulin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0449;7:H8Uxxa7N+Bx+wL7Rju1994bDps9YEUITW80xBYvoz2I4CIBPMe8Rh3Jya4V8boIwXlzNNbaxrNTwBtivX3O/NsO5tcVBkxCaYmRKFCDtPw5QG1BjzLNwa8bKW+vxvljQo4GkH8gCDAJ/Pw0FsDWf7hcRI887VpFninXVcprvdQie2I6WRT6sjZBFUOQ4cftyfD1zoeRw6wlSPdTYphlQ/q46I6KZSw7OzVkqj8JV/iA4ibEUSUl+9rHhbnjbeQsO;20:aPMDv3q7BnVbDiw2eWH2jl2DGd+iwxqbFdDGEP65Tn+amwyfI7vU9eGINUCMwqirxtO83blBGJWw6w7JopWMH9BZEPMdGp22uUexSu67C05nIjwn9xV6iunZZEWiMZIF3yfjPyew6Wo5QTdf0asvmWP0ZB0xyciSqQuGQnsoj8Y=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5ef8b82-5a89-4f74-d4e7-08d58447c909
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0449;
x-ms-traffictypediagnostic: MWHPR04MB0449:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB04494ECC2D6B129FA6E1F55F98D80@MWHPR04MB0449.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0449;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0449;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(366004)(39380400002)(377424004)(199004)(189003)(3846002)(478600001)(72206003)(229853002)(4326008)(3280700002)(5660300001)(6116002)(106356001)(25786009)(110136005)(66066001)(54906003)(81166006)(81156014)(2906002)(86362001)(8676002)(8936002)(3660700001)(2501003)(68736007)(99286004)(186003)(97736004)(6436002)(6246003)(59450400001)(53936002)(6506007)(5250100002)(105586002)(6486002)(103116003)(7736002)(305945005)(14454004)(26005)(102836004)(2950100002)(2900100001)(36756003)(316002)(76176011)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0449;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MIVkcbHi96l/gZtThxMo6LrbM8kr/Z/+jtOKoPvKDx1H8kOjQ1lq4xHnzArZHW0a28UmuGbq2T8UBOcoUyXi6h0tWCXWKAygmDppYl6aX2PfhaiBBbDsbSC7br4Q0a9CRoSe+EWfESErCeoBfF0Hs7jTkQxxSBeJX/vhlDw+RGsD2p2UgcVl07esbf13P4XhyZArK5X4O86HWa7StMYdga7ZId6agVq+ePV9+O+QWJIGyEqhKjUjwFXh5H5dnTCMUlP0G++FNcBBSm9pXlXtWpFTBvXt1us5qQSV8f5q45vLhMORafMFSxgTRcznra2ZdTaLKQ9m7ueXwM/zhyjbEA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8378F058459A554C97E140037FFFA647@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef8b82-5a89-4f74-d4e7-08d58447c909
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 16:23:39.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27GNsXf007541

On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
> We can derive the order from sg->length and so do not need to pass it in
> explicitly. Rename the function to sgl_free_n.

Using get_order() to compute the order looks fine to me but this patch will
have to rebased in order to address the comments on the previous patches.

Thanks,

Bart.
