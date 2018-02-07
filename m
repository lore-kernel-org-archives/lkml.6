Return-Path: <parav@mellanox.com>
X-Google-Smtp-Source: AH8x227/oDsG4t7czKXaTwZ5rjaeRlObb9XneeeOSJikjvNWqUl8NjjMCcS08PJV3gL1JSqy7vYc
ARC-Seal: i=1; a=rsa-sha256; t=1518019756; cv=none;
        d=google.com; s=arc-20160816;
        b=JOGutI/6uLfMCGu+qk9tWKK9ZcJrlwEPhgK9fwYye//GQokmIeyfZ39yhQPZYcVuhh
         sbiO7yRVoLb9/2MCQNllmwM+YJ92crcAdFwBJD2D3/0a+VilH6di8K95rjSwvUcKGMzg
         9i7eV0dBLrpJ0ZhL3ndOb5ci95Q/ionZtCWpEEl99J//66Ujyys9DfXgjH0/63PzM4zk
         cej6JF9OC5OQ3qGBUIL+9YGn+5Q4H8TmR1DDY1aa3/4Rh6LEp1EsgbvfNqzH4nqCzXhB
         yRSzkumsisr5Eq10qYFmE2OQZkV7hs9J264KrvcPMX3vE/EU1zvOC7w5Bl2n5N9pJ0CS
         Z8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=8TSmwkm54lTkdfW73W+uwHe4k6ef8nAbQOEESGz8xM4=;
        b=BLFvdZwyHcy+ftOKl7VpFVxC31JQ0V/KIBzKNDMLqzqRqIIw4ux9RWRYMPY9cQW04p
         eGs+A3+FrtbOshYUkdG8VqOH2n3Se64AHt494uRPZIoJwa1lOcORpPZ1hoxAf0nzCSPx
         BqByDrRq0JMKxsUwkGzIg/591Qxg3PpOG+jJqZ4U2WMna6bh41M0klMlaVVk/mhWMjsB
         iw+FHnuaecUf+DWJnru0PYyLqE+C908xqkEoFDDzz3UwFvi8zFaESZhCODmNdOYA/1ia
         pEfkBHb/aeFwoauNuPCBTwnSwojjvCpj32HMGGDCELb5vc4oUl4ieTILcw50UzjZY5cU
         74ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=oyQzxhyB;
       spf=pass (google.com: domain of parav@mellanox.com designates 2a01:111:f400:fe1e::62a as permitted sender) smtp.mailfrom=parav@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=oyQzxhyB;
       spf=pass (google.com: domain of parav@mellanox.com designates 2a01:111:f400:fe1e::62a as permitted sender) smtp.mailfrom=parav@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Parav Pandit <parav@mellanox.com>
To: Aishwarya Pant <aishpant@gmail.com>, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
Subject: RE: [PATCH v3] Documentation/ABI: update infiniband sysfs interfaces
Thread-Topic: [PATCH v3] Documentation/ABI: update infiniband sysfs interfaces
Thread-Index: AQHTn9CN5G17I/dfbEOTrihkVnMDx6OZG9UQ
Date: Wed, 7 Feb 2018 16:09:11 +0000
Message-ID: <VI1PR0502MB3008B3A337DB4DDA140094B9D1FC0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180207045955.GA31749@mordor.localdomain>
In-Reply-To: <20180207045955.GA31749@mordor.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com;
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB2912;7:fw/Fgb+MGL36pqktvtgm+Cpb3I+zQxWlDMHi2bKRJA8gKk6aZuvAWokwCbleyEAaSkV8+0x6kHaIuNkW3z6znQgJaU5N2BbwKyAZXr4LeVhlwtJvBbsBKikqf8EUK1hgBfMJIqon1IxWwelEof/RebP3OcgKBsM3CzkSL1T95eEPX1XQgDbCc//lGRh4m0aXFoZASvkh9WqoKLNDcSNDOEtOUSY52oO/Y87fJ7KBIFdXw5RzCI37r5hh8l83Wk0o
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73f23acc-5d9f-4421-412e-08d56e452057
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0502MB2912;
x-ms-traffictypediagnostic: VI1PR0502MB2912:
x-microsoft-antispam-prvs: <VI1PR0502MB29128C0E7A398EA4D7BAF639D1FC0@VI1PR0502MB2912.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0502MB2912;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB2912;
x-forefront-prvs: 0576145E86
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(50944005)(13464003)(189003)(199004)(14454004)(66066001)(8936002)(81166006)(186003)(39060400002)(25786009)(478600001)(2501003)(2900100001)(97736004)(74316002)(6246003)(8676002)(81156014)(7736002)(305945005)(3660700001)(105586002)(6506007)(86362001)(102836004)(7696005)(59450400001)(53936002)(15650500001)(3280700002)(4326008)(76176011)(2906002)(53546011)(5660300001)(9686003)(316002)(2201001)(5250100002)(26005)(55016002)(33656002)(106356001)(68736007)(99286004)(2950100002)(229853002)(3846002)(6116002)(6436002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2912;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: H3TbTzQYNscP+GgmLreR4LcVMwW/3tlyalx6bMFAroDayXQyptiQj/QaqUNoE1nqtUVz4EwWVT4tpZFtIA1ABA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f23acc-5d9f-4421-412e-08d56e452057
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2018 16:09:11.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2912
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591716983229332974?=
X-GMAIL-MSGID: =?utf-8?q?1591759083924217764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Aishwarya,


> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Aishwarya Pant
> Sent: Tuesday, February 06, 2018 11:00 PM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan Corbet
> <corbet@lwn.net>; Greg KH <gregkh@linuxfoundation.org>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH v3] Documentation/ABI: update infiniband sysfs interfaces
>=20
> Add documentation for core and hardware specific infiniband interfaces.
> The descriptions have been collected from git commit logs, reading throug=
h
> code and data sheets. Some drivers have incomplete doc and are annotated
> with the comment '[to be documented]'.
>=20
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v3:
> -  outbound -> inbound in description of port_rcv_constraint_errors
> v2:
> - Move infiniband interface from testing to stable
> - Fix typos
> - Update description of cap_mask, port_xmit_constraint_errors and
>   port_rcv_constraint_errors
> - Add doc for hw_counters
> - Remove old documentation
>=20
>  Documentation/ABI/stable/sysfs-class-infiniband  | 818
> +++++++++++++++++++++++  Documentation/ABI/testing/sysfs-class-infiniband
> |  16 -
>  Documentation/infiniband/sysfs.txt               | 129 +---
>  3 files changed, 820 insertions(+), 143 deletions(-)  create mode 100644
> Documentation/ABI/stable/sysfs-class-infiniband
>  delete mode 100644 Documentation/ABI/testing/sysfs-class-infiniband
>=20
> diff --git a/Documentation/ABI/stable/sysfs-class-infiniband
> b/Documentation/ABI/stable/sysfs-class-infiniband
> new file mode 100644
> index 000000000000..f3acf3713a91
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> @@ -0,0 +1,818 @@
> +sysfs interface common for all infiniband devices
> +-------------------------------------------------
> +

> +What:		/sys/class/infiniband/<hca>/ports/<port-
> number>/gid_attrs/ndevs/<gid-index>
> +Date:		November 29, 2015
> +KernelVersion:	4.4.0
> +Contact:	linux-rdma@vger.kernel.org
> +Description: 	The net-device's name associated with the GID resides
> +		at index <gid-index>.
> +
> +What:		/sys/class/infiniband/<hca>/ports/<port-
> number>/gid_attrs/types/<gid-index>
> +Date:		November 29, 2015
> +KernelVersion:	4.4.0
> +Contact:	linux-rdma@vger.kernel.org
> +Description: 	The RoCE type of the associated GID resides at index <gid-
> index>.
> +		This could either be "IB/RoCE v1" for IB and RoCE v1 based
> GODs
GIDs.
