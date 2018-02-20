Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBTVOg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:14:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10792 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:14:33 -0500
X-IronPort-AV: E=Sophos;i="5.46,541,1511798400";
   d="scan'208";a="72312794"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>
CC: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
Thread-Topic: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
Thread-Index: AQHTqo22g3e0rzeB4kWE08COXa55qKOtynkA
Date: Tue, 20 Feb 2018 21:14:29 +0000
Message-ID: <1519161268.3737.12.camel@wdc.com>
References: <20180220205924.2035765-1-arnd@arndb.de>
In-Reply-To: <20180220205924.2035765-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [12.250.207.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1631;7:OCtmtY8y+iL1tQC9aXYAKwW0aaoGa2/0c91c8NaEu/xsWo9AHf3kOE9KllJlJsNf38hmYrndgihp1A4WG+WnqZJqnk6t7tO5raohULUJgxz6Dp/x7TkNbqVvuKCiYVnZpwYC1tu/dVV4h5VwFrfPWCRYh8LYt9kui7rCsYqFgQ3cEL4yOhS3UuRTckgJ9X/zWN4i923vAvsHEUSTnvOR5Hbxixyvj2bi7nNH1rXqPdFwrVeVL4qHKE4fqy3IFgrQ;20:7K68mqKp44GZGU1VM2CdZ12+WSf8lCKzo48DxEmnSvx2IdIMidLZGbLii+FsBoYUZZ/tr4jsNVpP5syTP5TQ4Q5yzuS7afm11n3tUZuH5fdOzaLYYyE960RIdHklmOiX/Eg8V2Ag1LfL3NF5bKuB/a2pHPxHbQCqAXfLN81SYMM=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b50bb5e-bd35-4aef-046e-08d578a6ee57
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1631;
x-ms-traffictypediagnostic: CY1PR0401MB1631:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1631725326FDB5026A451B4B98CF0@CY1PR0401MB1631.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(944501161)(3002001)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR0401MB1631;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1631;
x-forefront-prvs: 05891FB07F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(366004)(396003)(376002)(377424004)(189003)(199004)(8936002)(3280700002)(6436002)(36756003)(103116003)(53936002)(66066001)(6512007)(2906002)(3846002)(6116002)(68736007)(6246003)(6486002)(2900100001)(305945005)(106356001)(4326008)(7736002)(2501003)(81156014)(105586002)(5660300001)(25786009)(97736004)(76176011)(86362001)(8676002)(2201001)(26005)(77096007)(186003)(6506007)(54906003)(3660700001)(110136005)(229853002)(316002)(81166006)(99286004)(478600001)(72206003)(14454004)(2950100002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1631;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: PuuH+Koz7mDf68WDuL2hwIx8QNuUU2OmH4RPTLpHRor14I0ykKU3oFr+0NVVvPKSdyzH5Vmt8tDgfV8Z8Zq4Q5o40f3LErqwHBD5TCArDICCCbvRe09vR48/1EeEbPkvKO+cpLhBOeIPGT2oi3EHaxg4KHis6r2HyTaSk5/p0LM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <427F65363C83344EBF4BA933C493CAE4@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b50bb5e-bd35-4aef-046e-08d578a6ee57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2018 21:14:29.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1631
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1KLEeuJ017608

On Tue, 2018-02-20 at 21:59 +0100, Arnd Bergmann wrote:
>  /* # of WCs to poll for with a single call to ib_poll_cq */
> -#define IB_POLL_BATCH			16
> +#define IB_POLL_BATCH			8

The purpose of batch polling is to minimize contention on the cq spinlock.
Reducing the IB_POLL_BATCH constant may affect performance negatively. Has
the performance impact of this change been verified for all affected drivers
(ib_srp, ib_srpt, ib_iser, ib_isert, NVMeOF, NVMeOF target, SMB Direct, NFS
over RDMA, ...)?

Bart.
