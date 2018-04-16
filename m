Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeDPUtS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:49:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34688 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:49:15 -0400
X-IronPort-AV: E=Sophos;i="5.48,460,1517846400";
   d="scan'208";a="172735057"
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
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVj5Jy/9Ew2ExTSbalJ+RQV0SXDQANMyuA
Date: Mon, 16 Apr 2018 20:49:12 +0000
Message-ID: <bee7c8b15b7cec3d4b1442f414e766539fac2491.camel@wdc.com>
References: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
In-Reply-To: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0863;7:K3b+JoMLfLRIDETBExkrus9bGMZU/L1EVqWSJMFaXQT71rAZ/mA4BEjniB1r4juPAJc7ByYhZpS4aR6vdakD0huizOJV3yxeqyPCZj5b32toORYImZKVtxd5fUmw62qG8C+Isdmp99PhJ9sD+im03xvvQHOIVdX7DHsBDSalBLnvTO2Qas52NQ3ys12CdtBeMHzZF2ggYwiwNELrkotydYNzez5Gwlwpg1/YGkk5l8ruL4uU9zyoDHatN2jb9Zaq;20:zMECFYyVe7bfpxAnjA0abn2y7fLccvodqLN0s+DaqIuu3th/SRo6rzexL5zt8Ko1TrYhmWx7zOTixv3CyoazShqp8rgqgsL3zQMllgAGK+SUxxnSpR3HzV8h6OlEjBhFlmdekNJ0KDMSU2CIvrhr9/pz/tMA1/oPFW2yslWWwDE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0863;
x-ms-traffictypediagnostic: MWHPR04MB0863:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB08636609314E7325ED42CC5198B00@MWHPR04MB0863.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0863;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0863;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(189003)(199004)(377424004)(186003)(25786009)(8676002)(5250100002)(2900100001)(478600001)(11346002)(446003)(486006)(2616005)(81166006)(81156014)(72206003)(14454004)(476003)(6486002)(102836004)(6436002)(4326008)(229853002)(2201001)(99286004)(76176011)(6506007)(6246003)(53936002)(8936002)(2501003)(6512007)(5660300001)(26005)(6116002)(3846002)(86362001)(110136005)(97736004)(54906003)(3280700002)(36756003)(68736007)(305945005)(118296001)(7416002)(2906002)(7736002)(106356001)(105586002)(316002)(66066001)(3660700001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0863;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7B5QNJkiCn4k0qf2AcaFIKQBKcgP1igwM5wHBbDZHDta2qLToyth6wLYuL4vpGpqj5XipNIAe7SWpef2yq4ZqYCdgWmAK+33B19iObjWz3VvAQgj0VZl+Ad1nHdsxlHvB72HUeXJNwH6D/E1gZd7WdLzHuYdI32IbYuXctghjDDEp/aZNpgSkGtNyaqkYwH5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2883E180E93B6D459AFF8B0B94C306C8@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fc8f0bce-7795-4407-1fcb-08d5a3db82c3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8f0bce-7795-4407-1fcb-08d5a3db82c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 20:49:12.7752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0863
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GKnMLx013340

On Mon, 2018-04-16 at 14:31 +0000, Bean Huo (beanhuo) wrote:
>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u prot_sgl=%u" \
> -		  " prot_op=%s cmnd=(%s %s raw=%s)",
> +		  " prot_op=%s tag=%d cmnd=(%s %s raw=%s)",
> 
> [ ... ]
>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u prot_sgl=%u" \
> -		  " prot_op=%s cmnd=(%s %s raw=%s) rtn=%d",
> +		  " prot_op=%s tag=%d cmnd=(%s %s raw=%s) rtn=%d",
> [ ... ]
>  	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u " \
> -		  "prot_sgl=%u prot_op=%s cmnd=(%s %s raw=%s) result=(driver=" \
> -		  "%s host=%s message=%s status=%s)",
> +		  "prot_sgl=%u prot_op=%s tag=%d cmnd=(%s %s raw=%s) " \
> +		  "result=(driver=%s host=%s message=%s status=%s)",

Which tools process these strings? Has it been verified whether or not
the tools that process these strings still work fine with this patch
applied?

Thanks,

Bart.
