Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbeDMMsG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:48:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbeDMMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:48:04 -0400
X-IronPort-AV: E=Sophos;i="5.48,445,1517846400";
   d="scan'208";a="172554907"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "gthelen@google.com" <gthelen@google.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tarick@google.com" <tarick@google.com>
Subject: Re: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
Thread-Topic: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
Thread-Index: AQHT0vYISo4DKakRgkOBkycUE18PqKP+pVYA
Date: Fri, 13 Apr 2018 12:47:53 +0000
Message-ID: <9ad4563e701a38915d58552f9eee5b3602833ddf.camel@wdc.com>
References: <20180413070644.11974-1-gthelen@google.com>
In-Reply-To: <20180413070644.11974-1-gthelen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [50.225.201.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0911;7:LeIrejjjNT3O2krWeK53hba+w8R2U28QfT5aA7oKrMj5Sz4Ic7+wv8upmXF1LPBU5rD8Qs3ucstyZDDrNNbhTI/1VkUb4QkRnhYXASogizkerY57Bki9BEAE1PEsN//7KtGjPpdRPL0GDyoe07PgaPeGW7DgJPA3J6wxT6KEaxHzCSIR4t6IPWIFuZc8lRUNTTJYinNuqK9cU4g9rpwSVhNYFHOsOAmeJD7whw1z4gFdZ9wBwoqPjjfjWISTGEvD;20:0jgLm/VWE9BU7iU37b5nVthF9TtTYuxpCqC/Gdmmj2vjXszN0qh5ktktetCFzF1cwYbkMEn17c15bFcO8Gy/lDHMsbVvdfWF7++rrnXvSbDiwy+MR6MLYPuehKm+fkM94DXdZAtzrpsq3Oai13nbHvvXxBQyt+gMBdeTXjtpn5M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0911;
x-ms-traffictypediagnostic: MWHPR04MB0911:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB09112F3C4FD0EFB8A75D26E598B30@MWHPR04MB0911.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0911;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0911;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(39380400002)(346002)(377424004)(199004)(189003)(66066001)(2501003)(26005)(5250100002)(186003)(476003)(86362001)(54906003)(6486002)(118296001)(6436002)(72206003)(97736004)(3846002)(6116002)(6506007)(99286004)(59450400001)(2201001)(3280700002)(3660700001)(478600001)(76176011)(229853002)(316002)(25786009)(2906002)(68736007)(7736002)(4326008)(36756003)(8936002)(14454004)(2616005)(6512007)(305945005)(53936002)(6246003)(110136005)(11346002)(446003)(106356001)(105586002)(5660300001)(8676002)(2900100001)(81156014)(486006)(102836004)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0911;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rTOXK1DPTTS4inL/xPasvpN7Yfd0/UKp/3SihsZlkBZb8mkCqYYyqxl4Lm8C0stlSfN0j1tf3ftIeE3h/kSdUNgY7RmIKhO2HoaO/YQQTPScp4aKcsmG3m/nahd6zB+p7bgYjZMJYIlke5Rnh2T15Qy7ICCc1xRKPFC5wuPYT3SqCbgy0t9xOqwkcD48RZPW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC7EF9E12448E438AB79FED8F102327@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d00a89a2-6356-46b7-ad61-08d5a13cc612
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00a89a2-6356-46b7-ad61-08d5a13cc612
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 12:47:53.3828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0911
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3DCmBlN001333

On Fri, 2018-04-13 at 00:06 -0700, Greg Thelen wrote:
> Allow INFINIBAND without INFINIBAND_ADDR_TRANS.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Cc: Tarick Bedeir <tarick@google.com>
> ---
>  drivers/infiniband/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index ee270e065ba9..f20a3977087c 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -61,7 +61,7 @@ config INFINIBAND_ON_DEMAND_PAGING
>  	  pages on demand instead.
>  
>  config INFINIBAND_ADDR_TRANS
> -	bool
> +	bool "InfiniBand address translation"
>  	depends on INFINIBAND
>  	default y

Hello Greg,

Please change the short description from "InfiniBand address translation" (which
is a misleading description) into "RDMA/CM". Please also add a help text that
explains to people who are not RDMA experts what the RDMA/CM is.

Thanks,

Bart.
