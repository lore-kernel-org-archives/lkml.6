Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDPUt7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:49:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63639 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeDPUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:49:57 -0400
X-IronPort-AV: E=Sophos;i="5.48,460,1517846400";
   d="scan'208";a="76855750"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "beanhuo@micron.com" <beanhuo@micron.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "rajatja@google.com" <rajatja@google.com>
Subject: Re: [RESEND PATCH v1 2/2] trace: events: block: Add tag in block
 trace events
Thread-Topic: [RESEND PATCH v1 2/2] trace: events: block: Add tag in block
 trace events
Thread-Index: AdPVj891kSAdtlOyRKy4BVmHjk9SYAANKeCA
Date: Mon, 16 Apr 2018 20:49:52 +0000
Message-ID: <51266d3243acdf73e800a0d283473cc85a52a388.camel@wdc.com>
References: <64d6073b28b140cda3e5870a54e0a7bc@SIWEX5A.sing.micron.com>
In-Reply-To: <64d6073b28b140cda3e5870a54e0a7bc@SIWEX5A.sing.micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0975;7:hB6ot0mEnfc5YxKrRWCH005r4hTPmN7jvVi3obHVjVgdzL4zhA9Kg3JVI1fNtnaswyWEgNDmqKJ1krOrop3rQzy9uqpCLfkZWYc3ZLaBGPDx5PafYM0jIOwCPVtjIwCFjLu/Q28sH/lnMx9S1lmbpPhEl8ov0YglgEhWl62sjQ4MF9UNO0LkxFmMMM0UmpFg9c4T2bOfCwVR0Rap3dqfYvNlnHjfDTkEow9G3llIopGWDThtNle1Z9smZjhe7Lb6;20:nLSK7Ahs2xzdWcNbTvgduSf/s547uvNpQPPY1tplpVvyxFUtcfF5FhHcbnH1mbcwltZQ8zD7hUiSuDvG5SrImgzZsZbFeFjpDz3vKzxUZqGjqpHG9/YI8+Nq3/7R9ygyDk3BBkDwj9wjornq6GykLLenJIktkrpqixlse5uC4fg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0975;
x-ms-traffictypediagnostic: MWHPR04MB0975:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0975A7E4AD72F1177EC1DE0498B00@MWHPR04MB0975.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0975;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0975;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(199004)(189003)(377424004)(316002)(2616005)(97736004)(99286004)(476003)(2201001)(2501003)(66066001)(72206003)(486006)(11346002)(102836004)(81166006)(2900100001)(81156014)(110136005)(54906003)(68736007)(25786009)(26005)(186003)(8936002)(76176011)(6506007)(478600001)(446003)(86362001)(8676002)(229853002)(6246003)(5250100002)(7416002)(6436002)(53936002)(6512007)(6486002)(118296001)(305945005)(4326008)(7736002)(3846002)(14454004)(105586002)(106356001)(2906002)(3280700002)(3660700001)(6116002)(5660300001)(36756003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0975;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Xg6fBqQfnxvP8GHd6HFaMZIO1qgkFejZyWOyiycABfai+uxMbbFyA04NJbCWkq21xjWTtE7Vq30FVXRj2/+rqp8ICY7qBqXmYMoYohEfYDseWb9yOPV7jKSZRHQ09q8RA90Rd9JVpt+dxif16NAE8xzmtuxlo4tdG9FN6dMt3OYn3+mR3Dd6xffhEitQm17M
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <797E6BBE00F52D4188F997A925CE466A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 33505733-c240-4c81-4ece-08d5a3db9a79
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33505733-c240-4c81-4ece-08d5a3db9a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 20:49:52.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0975
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GKo69W013345

On Mon, 2018-04-16 at 14:33 +0000, Bean Huo (beanhuo) wrote:
> [ ... ]
> -	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +	TP_printk("%d,%d %s (%s) %llu + %u tag=%d [%d]",
> [ ... ]
> -	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> +	TP_printk("%d,%d %s (%s) %llu + %u tag=%d [%d]",
> [ ... ]

Which tools process these strings? Has it been verified whether or not
the tools that process these strings still work fine with this patch
applied?

Thanks,

Bart.
