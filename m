Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeDBNre (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:47:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23370 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbeDBNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:47:31 -0400
X-IronPort-AV: E=Sophos;i="5.48,395,1517846400";
   d="scan'208";a="75738905"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "sitsofe@gmail.com" <sitsofe@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sth@linux.vnet.ibm.com" <sth@linux.vnet.ibm.com>,
        "hoeppner@linux.vnet.ibm.com" <hoeppner@linux.vnet.ibm.com>,
        "asamymuthupa@micron.com" <asamymuthupa@micron.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [BISECTED][REGRESSION] Hang while booting EeePC 900
Thread-Topic: [BISECTED][REGRESSION] Hang while booting EeePC 900
Thread-Index: AQHTycbIOuXv+Ex8OEyo5H1SV9+T7aPtfriA
Date: Mon, 2 Apr 2018 13:47:28 +0000
Message-ID: <f40e3f7bf4b4305f73bab6eec83eab20b5d8a167.camel@wdc.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
In-Reply-To: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0751;7:4UzdiMknLYalEIjU8m/Cn7EhCF7GvzxgApsiR3yHmA/LNaib6C2Ql28BAKgaE0C9mDkzjO8B9OCbKotjrkXfXHpa6yP+KLmmakOLMa3t+cmiRt9V9QmM16VgcqGgv9TubgDu15NFrQxuEoV1iOuGnL11asazdkPPfYyHlApZqNoVjVg2G61Npf7AUfENcFuApEJVEjRD/bmTPsrUfy641oHrWZgEQx7v31RKpS95iWi+lQURsmtFi7XHvdj051WB;20:ky2wkHkZ7ijhhTR+DnC0IyZm4c8yLXkmc2zUMDChkajxm9OgjdYEj7XTi6mWX2+eSwtEf05Y9SCow9aennt78y0cJULNfEAnWsalEXDMpvs63aaCMJ2G/BaeoqEGYuwoEp4cGWZ/QnPK3ZAIKyZKP6o3WnDN8LYBHszFa1ES++g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa13b158-2442-4ae8-3be5-08d598a04646
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0751;
x-ms-traffictypediagnostic: MWHPR04MB0751:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB075121F69F3802869B2D593498A60@MWHPR04MB0751.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0751;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0751;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(51444003)(189003)(377424004)(199004)(478600001)(8676002)(2501003)(81156014)(6506007)(5660300001)(6512007)(81166006)(2616005)(476003)(86362001)(5250100002)(486005)(6246003)(11346002)(486005)(3280700002)(26005)(66066001)(25786009)(72206003)(68736007)(53936002)(97736004)(186003)(106356001)(39060400002)(3660700001)(102836004)(99286004)(3846002)(305945005)(6116002)(14454004)(446003)(2900100001)(316002)(8936002)(105586002)(118296001)(6436002)(7736002)(4326008)(6486002)(54906003)(110136005)(36756003)(2906002)(76176011)(59450400001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0751;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rDFHUu+GDfaejYkPBaELln2VGRjOvowi6/za2pBpP2WSBno+EZaC/bbwkhLAy1f7f9VIXWEPFI7PTUEO6srLBW62cl/pZ+QkXhNIlO6uVlYo4L6pjItFrO3/PvNNJ+8zFdvkbpRfl2nxwhL6VoC1M3NkE80PEs7lzvJ2d7nG+QcgvOclmOvwOuh8FUQ+v8uHwR4Fuv6ronfgpF5+f73qIi80GuJJSzGBW6574DVf6BxMLXMdjbq7F6Skie3fQ+AUHwnGgZ6HQlpc+oC27TwnHvxyjhZPYKjn1nnHKqNGQWil2rDkiMCM6K1j7ngXOEnWUUyRhHTlrKjgJ1ZFse5u+F3NH/1lF4+TAXzsTJgDLJ0rsyiwMXqLSN9lek69xtzkoXTymupIF/rN/NV6HLtJUhQgZfLsc4xhCKenQ01JXXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5E4CBF626D30A4FBEFD658C48D1BFD8@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa13b158-2442-4ae8-3be5-08d598a04646
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 13:47:28.2740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0751
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32Dlf2F007339

On Sun, 2018-04-01 at 15:35 +0100, Sitsofe Wheeler wrote:
> While trying to boot an EeePC 900 on the latest git mainline kernel a
> hang is encountered while systemd is starting services but this did
> not happen with 4.15. A bisection narrowed it down to the commit
> 358f70da49d77c43f2ca11b5da584213b2add29c ("blk-mq: make
> blk_abort_request() trigger timeout path"). Here's the bisection log:

Please repost on the linux-block mailing list. I think that mailing list is
more appropriate for this bug report.

Thanks,

Bart.
