Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeB0WRG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:17:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39906 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeB0WRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:17:04 -0500
X-IronPort-AV: E=Sophos;i="5.47,402,1515427200";
   d="scan'208";a="175455900"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hernan@vanguardiasur.com.ar" <hernan@vanguardiasur.com.ar>
Subject: Re: [PATCH] IB/rxe: Remove unused variable (char
 *rxe_qp_state_name[])
Thread-Topic: [PATCH] IB/rxe: Remove unused variable (char
 *rxe_qp_state_name[])
Thread-Index: AQHTsBeAtP7YRFhC3EubT+yqZfz4TaO40S+A
Date: Tue, 27 Feb 2018 22:17:00 +0000
Message-ID: <1519769819.23791.19.camel@wdc.com>
References: <1519769278-20094-1-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1519769278-20094-1-git-send-email-hernan@vanguardiasur.com.ar>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1504;7:u78JoEQNfh5AqW/G+V9qy+o5N2BG7YiOMma1nX3W2tFgg7pIOjaC2rd6+5f2qu1e63ahTktEC+E+CJWbdImuYP2e7s8UXyZLPMWDu5arvldqgt9uqY4Nhb6TXZdlLbTp0lWgPX033S4ExXc2ruOAJxG9SjnLBmCp4YzDuXbDC3yfzBZYSRKNVkbUUjJtF4beLo+8dEAroqm/Xcu3bhTDKUFNaTLG+9lvG1w4jact9KNiz8mz62lWSDeeElCLuARq;20:Den9LQIAZooqVt8BAYx2J/yV5y1Vor4DvYNyxCjju2INhltRad2fZ3Gxzz20V9y0l1g8R1Goqf6s3sg90aN25J+ZM6u/86HU6eC2zYAOtBdNitBgpkTOd2YTnij0F2+plFfHA2u7blOHXhuV/f9Jso33qGnJydV1Lu/r9xwq3mg=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fff4ca1-9fd2-4302-eba3-08d57e2fd2cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1504;
x-ms-traffictypediagnostic: CY1PR0401MB1504:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB15043390762A73C95E921D3398C00@CY1PR0401MB1504.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR0401MB1504;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1504;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(39380400002)(396003)(377424004)(189003)(199004)(6246003)(106356001)(2906002)(5660300001)(8936002)(97736004)(110136005)(3280700002)(2950100002)(6512007)(6116002)(2900100001)(3846002)(6486002)(3660700001)(99286004)(68736007)(186003)(26005)(2501003)(103116003)(558084003)(478600001)(76176011)(66066001)(102836004)(36756003)(77096007)(229853002)(2201001)(81156014)(81166006)(25786009)(8676002)(53936002)(6436002)(6506007)(59450400001)(316002)(7736002)(72206003)(14454004)(305945005)(105586002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1504;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Dt9ifWjBrUwGYx7rv2ldApxKg9gFT0u7TiakX9A+vKSrATI/GxEum+m0USXy0sj5GrVRF7YL+3LJkQFr8wHwVVKDfHHuUFgHtmHzTFgTWIGX/QDeVkKOsNqZ+XZfyRXe8Cuk/t6RpfTqPakmz11TIqjPlYL13YRjtG0RNbJDd7A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F98FF252D527224FA99B57CD7F7EB931@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff4ca1-9fd2-4302-eba3-08d57e2fd2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 22:17:00.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1504
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RMHEkh007024

On Tue, 2018-02-27 at 19:07 -0300, Hernán Gonzalez wrote:
> Note: This is compile only tested as I have no access to the hw.

Hello Hernán,

Are you aware that the only hardware that is needed to test this driver is
an Ethernet interface, and that this driver even supports the loopback
interface?

Bart.
