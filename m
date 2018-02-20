Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBTVOW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:14:22 -0500
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:7797
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750799AbeBTVOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:14:20 -0500
From: Parav Pandit <parav@mellanox.com>
To: Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
Thread-Topic: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
Thread-Index: AQHTqo3B1bGQMHuE2kiqUVdNHhzJiqOtyNbw
Date: Tue, 20 Feb 2018 21:14:15 +0000
Message-ID: <VI1PR0502MB3008B35525901FC935418FB0D1CF0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180220205924.2035765-1-arnd@arndb.de>
In-Reply-To: <20180220205924.2035765-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com;
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3870;7:o8OFsetWRhAV8usW8seQGplOOzIrnX0Cs88fpslMQICwsUw5rmkFUL7t2ynRfwwBnc6akEjULgkJP4Pw47f1YlMRr6aSm1cEjN6oO2L+RMycZRx0NXahkDspaADD739mQHG+QebbGfWRAT3OKblcmqXoEa0/W/maZ+Xi8Ws7MXxGGioFgJVAJEKX3MQEIMCe/QrfL1SQvldGzYcBXmjOYuweUQit8gM3hD7xUbqeXcIPsEVjKVwVXITtG3TuCQSI
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-correlation-id: 845c8eb5-afbd-4c73-724d-08d578a6e5bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0502MB3870;
x-ms-traffictypediagnostic: VI1PR0502MB3870:
x-microsoft-antispam-prvs: <VI1PR0502MB387084ACCABB9AB992F133B7D1CF0@VI1PR0502MB3870.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0502MB3870;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3870;
x-forefront-prvs: 05891FB07F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39380400002)(376002)(39860400002)(199004)(189003)(13464003)(305945005)(25786009)(966005)(55016002)(2906002)(33656002)(186003)(97736004)(54906003)(6306002)(8936002)(53546011)(6506007)(8656006)(6436002)(478600001)(5250100002)(7736002)(5660300001)(2950100002)(26005)(102836004)(4326008)(6116002)(3846002)(76176011)(3280700002)(14454004)(2900100001)(53936002)(105586002)(7696005)(59450400001)(6246003)(3660700001)(68736007)(229853002)(81156014)(8676002)(99286004)(81166006)(106356001)(74316002)(86362001)(9686003)(316002)(110136005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3870;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 69Dpx7gFYt0FuD9xwQ6oJFKyHqPYLYRrttKE3pLBzgDz3rbYamYEB1GcqoVXhHmN5sVknnd3qxqPN84TVFcOpjl+UHU7Y5+O5kGxuiGHSJIrnX8XImYS5EGUOxSvxvPKGDKEi7NSel/rHdaSqGCcceHcfCv2lCq432Ym7izKf3w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845c8eb5-afbd-4c73-724d-08d578a6e5bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2018 21:14:15.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3870
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1KLEQWW017502

Hi Arnd Bergmann,

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: Tuesday, February 20, 2018 2:59 PM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>; Leon Romanovsky
> <leonro@mellanox.com>; Sagi Grimberg <sagi@grimberg.me>; Bart Van Assche
> <bart.vanassche@sandisk.com>; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
> 
> The ib_wc structure has grown to much that putting 16 of them on the stack hits
> the warning limit for dangerous kernel stack consumption:
> 
> drivers/infiniband/core/cq.c: In function 'ib_process_cq_direct':
> drivers/infiniband/core/cq.c:78:1: error: the frame size of 1032 bytes is larger
> than 1024 bytes [-Werror=frame-larger-than=]
> 
> Using half that number brings us comfortably below that limit again.
> 
> Fixes: 02d8883f520e ("RDMA/restrack: Add general infrastructure to track
> RDMA resources")

It is not clear to me how above commit 02d8883f520e introduced this stack issue.

Bodong and I came across ib_wc size increase in [1] and it was fixed in [2].
Did you hit this error after/before applying patch [2]?

[1] https://www.spinics.net/lists/linux-rdma/msg50754.html
[2] https://patchwork.kernel.org/patch/10159623/
