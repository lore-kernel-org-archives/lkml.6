Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4520C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65E121841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qf5xHMsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeLRQUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:20:10 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:21955 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:20:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="25406806"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Dec 2018 09:20:09 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 18 Dec 2018 09:20:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgkGbqMJcIoJgBCQv6z+P/AO5g/hwKtNX1QH1LL07xs=;
 b=qf5xHMsRGCW7dAYEKr9WVEltOxXEhC/V3S3J9Iqsi5ePah+MFKRPWKz4bNnzj45d4JFdesRLDneGEsY+X7yOwSVsT7Oc59b1iNvOhlWD7DvJBzb5x/WxqF5bAajkjGtxYDu+xB7P3LENqNR6UrQ/mXg2xyrHOUy76zhZxKHHe/4=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2146.namprd11.prod.outlook.com (10.174.112.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 16:20:06 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::a087:d8fb:ed76:d9e7]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::a087:d8fb:ed76:d9e7%9]) with mapi id 15.20.1446.018; Tue, 18 Dec 2018
 16:20:06 +0000
From:   <Woojung.Huh@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <jhogan@kernel.org>,
        <paul.burton@mips.com>
CC:     <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Thread-Topic: [PATCH] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Thread-Index: AQHUlt25VieAcpGayUO+iR0K8R9QqKWErU2g
Date:   Tue, 18 Dec 2018 16:20:06 +0000
Message-ID: <BN6PR1101MB213046F10A210D4752EB544EE7BD0@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20181218142636.1134-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20181218142636.1134-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2146;6:Hibieg1HRT6xsFowYatUEVhkhG0zhRV9OXqqfI6QeHsRpvRlZeUHkO06tJIUnd3Nmwm9+EC1uPRM0ENFlU2mBGkHcaU63SK/441fmZ+y4DDBakQtu0x8GbqNJ48o3gcRI84S6p4+OE7D9hvym0ZrLQw+cupfzEG7lqV9zUhjHtQUu8LvqEVZQEG65gBNcL2D9pVNq+5lbwmbxFb5xB6qZsIEqCDxwq4EmTAvccO5lQlnFp1B/yRltV9khARCqtYgQqrAyyJuJdIVzVMtUmkoRd6e9q4LgwZbQfh4l/hJI8Bs4rhERVhC63IlrjTo6FyL51NWUoY7/mkX22Y3SChxEBnYF2WI6YDXiIY5LzwefJpyk6uf6SpOMrAmELSlXKjRofQvMADiXkVETx+kQoftX+C0WSJJEioIVYVW9DK28xWyKTcv4PerPQYsE8kPMLB/BYuh0GkQ4V3trqbdoGc/gw==;5:MKW1HC+n+bYkCetvPtcREJ4JG41mWYecNXd0GlLdr7bmMQhGA5tE2UwHFUTLRpS2r8OdlitU8L9aoBJCYO3gZX15fLiBmYA5ulHLYJaaARR27o+RhZ4qrrRMD9afJuyOSFNb50yADcdAMg4FuFCWXz25PZfJ4bhUWIwaXVK8rEE=;7:CUr1z+IrGCqNEpszrRszot3aCHzel+hJZfSkXXdgeCGyKHyUCL2vcAzUWYkQ9/QTkr++tPOgho5sbjx5XMkux3k03eRFMmXPkOMhNfP9amQqRl1O/ubLNKc1eNboHQCoxgOc7mhpaLTkANMO/xSgOA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd2e20d1-1da0-41e4-4d7e-08d66504ac8a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2146;
x-ms-traffictypediagnostic: BN6PR1101MB2146:
x-microsoft-antispam-prvs: <BN6PR1101MB2146BFB4FAB4EB23C0071D24E7BD0@BN6PR1101MB2146.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2146;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2146;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(39860400002)(346002)(396003)(136003)(376002)(189003)(199004)(13464003)(25786009)(6436002)(305945005)(446003)(74316002)(54906003)(110136005)(316002)(7736002)(478600001)(11346002)(486006)(2906002)(71190400001)(71200400001)(476003)(66066001)(72206003)(229853002)(217873002)(86362001)(99286004)(14454004)(102836004)(7696005)(97736004)(68736007)(8676002)(81156014)(81166006)(8936002)(76176011)(5660300001)(256004)(6116002)(186003)(3846002)(26005)(4326008)(107886003)(6246003)(53936002)(106356001)(14444005)(105586002)(33656002)(55016002)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2146;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g5F0FGljQPeGzVd8n6k8rdmTg+5JSrrbInae0+8byDTG+y/LCDe/DTjwhQ9o1ZWOqa+O92wj+vLTfppbQywNbvbU95w2vMW6oP3YD4lsoMSNQhmSLai+ac5hsuN21RwfZUpLL2n/xSfWqQflBKTafX2MUuM4f1iLNaBwhSBa13ck8zlDQzHoxg/84HqHGeUgAP4UUTPofq/W4kNbyEUy9R8h/gssEVQd1TitEaBzWS2VFACU9hxX5mct7rIkxjZL8+YvRka7L2MJyTFHLBmA0yvybqTgneW1aChq/nJQhai/jErznFLaaiQSiqHvvyBZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2e20d1-1da0-41e4-4d7e-08d66504ac8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 16:20:06.7382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2146
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Tuesday, December 18, 2018 9:27 AM
> To: James Hogan <jhogan@kernel.org>; Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>; linux-kernel@vger.kernel.org; lin=
ux-mips@linux-mips.org;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>
> Subject: [PATCH] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
>=20
> Microsemi has been bought by Microchip and Microchip is supporting those
> SoCs.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f325..50223cba6ddb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9801,8 +9801,9 @@ F:	drivers/dma/at_xdmac.c
>=20
>  MICROSEMI MIPS SOCS
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>  L:	linux-mips@linux-mips.org
> -S:	Maintained
> +S:	Supported
>  F:	arch/mips/generic/board-ocelot.c
>  F:	arch/mips/configs/generic/board-ocelot.config
>  F:	arch/mips/boot/dts/mscc/
> --
> 2.20.0

Acked-by: Woojung Huh <Woojung.Huh@microchip.com>
