Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbeDZCNU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:13:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56203 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeDZCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:13:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,328,1520870400";
   d="scan'208";a="76612056"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "gthelen@google.com" <gthelen@google.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tarick@google.com" <tarick@google.com>
Subject: Re: [PATCH 5/5] IB: make INFINIBAND_ADDR_TRANS configurable
Thread-Topic: [PATCH 5/5] IB: make INFINIBAND_ADDR_TRANS configurable
Thread-Index: AQHT3OWZUB7GUKN9ZUizPDM2xvqyYqQSTmwA
Date: Thu, 26 Apr 2018 02:13:12 +0000
Message-ID: <14810de7b209468bc36fdb696db639242bbad9f9.camel@wdc.com>
References: <20180425223424.207228-1-gthelen@google.com>
In-Reply-To: <20180425223424.207228-1-gthelen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [67.142.235.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0352;7:c7VW6P2lYsu+jNHBGhUKB7ogWduTuaZxqcZkoGPzQiZPRa321gsw+0KqJROSq8i4QjCoI3fLVs8Q3BCmsq8yJsdAE9a9YMKfUIMOX/AVWuRjTuk4D9FrV9gGo42as6qBel/P51xFtZoYONMz11Cp4C29H1Y/+k9AA2HfBwDAUD8py5lNOZoFWELzpwXo8U/cYazmGxx2xZmfzTLojWnNpDoWJCwqgVmcHn4m6kbJGEnIjPgxXKyrACpGXoA0nvmI;20:MfIbw6Ro55gpuyPd0aC9unu5lQv1VYbm0KHOMiVND6SLcPSeFCkd00e2P8CwXekxftO4rM5Tr+4MBVReLghLrh8CZV3usvPGCJ4dFaZm/KexfGCsuzvtHDC7ek+XX4wugAaVV4MG9YMvycrEblPxQDlKISghJ5vRad1Kd0ra03o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0352;
x-ms-traffictypediagnostic: MWHPR04MB0352:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB03526485AD634909D9F60FD9988E0@MWHPR04MB0352.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0352;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0352;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(377424004)(199004)(189003)(99286004)(2501003)(66066001)(68736007)(316002)(106356001)(54906003)(5250100002)(110136005)(2900100001)(105586002)(229853002)(6486002)(5660300001)(118296001)(14454004)(305945005)(3280700002)(59450400001)(6116002)(2616005)(7736002)(478600001)(2906002)(97736004)(81156014)(8676002)(3660700001)(3846002)(186003)(2201001)(6246003)(26005)(36756003)(86362001)(72206003)(53936002)(25786009)(8936002)(486006)(4326008)(446003)(6506007)(81166006)(11346002)(6512007)(476003)(76176011)(102836004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0352;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /n439ngpqydoQbpzuH9ag5VE+OFcQx6JNqM645SfvSV4OtBqslvugu1hPibwmC55jVHmLOaHQN7axvMhA3stJwyg+eNbptBnhLxH3lPUpVWNzq2wnLm/iqZ1zyMvhgJLXG432J/0LfYJuRn2mCmT/W4ud8uKhKv1ziQJXKCjJluyelUgGr4nFJUrS1zlfJNJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCEA09BAC798A74E8FB18C48E276D301@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ca4eb043-ea79-4f9e-aa9e-08d5ab1b4344
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4eb043-ea79-4f9e-aa9e-08d5ab1b4344
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 02:13:12.2896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0352
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3Q2DQZS016635

On Wed, 2018-04-25 at 15:34 -0700, Greg Thelen wrote:
> Allow INFINIBAND without INFINIBAND_ADDR_TRANS because fuzzing has been
> finding fair number of CM bugs.  So provide option to disable it.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Cc: Tarick Bedeir <tarick@google.com>
> ---
>  drivers/infiniband/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index ee270e065ba9..2a972ed6851b 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -61,9 +61,12 @@ config INFINIBAND_ON_DEMAND_PAGING
>  	  pages on demand instead.
>  
>  config INFINIBAND_ADDR_TRANS
> -	bool
> +	bool "RDMA/CM"
>  	depends on INFINIBAND
>  	default y
> +	---help---
> +	  Support for RDMA communication manager (CM).
> +	  This allows for a generic connection abstraction over RDMA.

Hello Greg,

Please provide a cover letter when posting a patch series. Such a cover
letter is not only informative but also makes it easy for people who want
to comment on a patch series as a whole. I have a question that applies
to the entire patch series. The RDMA/CM code defines functions like
rdma_create_id() and rdma_create_qp(). If I search through the kernel tree
for callers of these functions then I find several more kernel modules than
the ones that are modified by this patch series:

$ git grep -lE '[[:blank:]](rdma_create_id|rdma_create_qp)\('
drivers/infiniband/core/cma.c
drivers/infiniband/ulp/iser/iser_verbs.c
drivers/infiniband/ulp/isert/ib_isert.c
drivers/infiniband/ulp/srp/ib_srp.c
drivers/infiniband/ulp/srpt/ib_srpt.c
drivers/nvme/host/rdma.c
drivers/nvme/target/rdma.c
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
fs/cifs/smbdirect.c
include/rdma/rdma_cm.h
net/9p/trans_rdma.c
net/rds/ib.c
net/rds/ib_cm.c
net/rds/rdma_transport.c
net/sunrpc/xprtrdma/svc_rdma_transport.c
net/sunrpc/xprtrdma/verbs.c

Are you sure that this patch series is complete?

Thanks,

Bart.
