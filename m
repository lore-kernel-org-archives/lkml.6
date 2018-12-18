Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D97C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6F221841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="01kqn8Ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeLRQTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:19:17 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24767 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeLRQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:19:17 -0500
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="24364640"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Dec 2018 09:19:16 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 18 Dec 2018 09:19:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofHpv5UZEWunBIsuZAzB0Ox4MnKwOyDw7AH7ZYfF3Qk=;
 b=01kqn8EiWSDrdDxJ4WDSGWFfVjbc1eQnD9KtTwAwItbO/COUm22h5XHheJ6mLFXqvli9zHkie9uUv51EqqGskjtgJ93Bzw6F6bEBo8oQgynC7Kh19isTp5R2CTfEDla7hNoiDkT3OLbJZb7DcBp/6BhLbjcpdeg7Wqk0mLvVDkg=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2290.namprd11.prod.outlook.com (10.174.113.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 16:19:00 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::a087:d8fb:ed76:d9e7]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::a087:d8fb:ed76:d9e7%9]) with mapi id 15.20.1446.018; Tue, 18 Dec 2018
 16:19:00 +0000
From:   <Woojung.Huh@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <davem@davemloft.net>
CC:     <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] MAINTAINERS: Add a maintainer for Microsemi
 switches
Thread-Topic: [PATCH net-next] MAINTAINERS: Add a maintainer for Microsemi
 switches
Thread-Index: AQHUlt2cplcP68B3K0SN5yolBSRCPKWErL/A
Date:   Tue, 18 Dec 2018 16:19:00 +0000
Message-ID: <BN6PR1101MB21303D009057C460BB999019E7BD0@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20181218142539.996-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20181218142539.996-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2290;6:xfHgwMcFDXTQaX5QRaHR1sUea4O3Ib5HRvqeAA3UO4m/Iwaphj6eJq9tYOxkAqY+8uV1Hr4h4/pBOoSJkS8zKlI5wE8dr5aMcTonsEdznidCjwAXRGf95+6Eh+JpWGarHXnXqzywl3rXw/5bV991lplHdQQtZqd2JoC0pBBxNViylu3VfQ9f6IYRyvtlUCEbb2pkR0mVNpWdoCDxYVnpXFtKOuydyxKvMMRc2ubB41o9UPiOSCpEu1r08UVySQWfccLc5r/gi0y2ewUnqlRjEy2ti4SHqiDGmaAyVbzIe+gQR3Q3tohIOTKpIB3hOjL5XUZeyPZ2Ntjlw519tkuvEY2EUn4mFZdnm0/iT9WSohW2QHS5dKfkYCk2ov/77Oaol35BMBCwMf09LTV9DN4hZnbSBmNmulIs+oQfCJh85tS62FhS1ug4P9onhxRWC5MMgjUrkfVPAYn2gMxo3wk2tw==;5:Dmr3DiKZwrz0pMfCRs7BohNkZrg5aEqLbHzuX6C5IDIcBvniA4T5FHWho8z6oMfbnInPd6e5eUILPHkv3hagUgPoIEh3o//miB757OMWpr1Q1vlgRlcy5PFAVu1t7WQoB72OpSWuXJQkAAXATes6oNxM60aTA2S2BF/blr8dNAk=;7:NQZtXZ5T0hIk6jsLXMrdsQOMWuOfDuaVglEv7PPk4cj5FFGFFGXMXHw4tcxAtjAlMJLNVO78s89moYbPnRxZxhdHoPL1JHGDCUTtUrXhZQkrSXujpUEkQn3nbtADugY2zbjPhEmYtsUhX9kV0dbANQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 729c6587-2086-4984-b103-08d66504853e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2290;
x-ms-traffictypediagnostic: BN6PR1101MB2290:
x-microsoft-antispam-prvs: <BN6PR1101MB22904FB09D6ACBAB1DDE0166E7BD0@BN6PR1101MB2290.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2290;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2290;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(13464003)(199004)(189003)(7696005)(14454004)(8936002)(76176011)(8676002)(81156014)(102836004)(5660300001)(68736007)(81166006)(6116002)(3846002)(74316002)(486006)(476003)(229853002)(11346002)(186003)(2906002)(33656002)(53936002)(7736002)(4326008)(305945005)(55016002)(97736004)(446003)(26005)(53546011)(106356001)(316002)(86362001)(105586002)(72206003)(6506007)(256004)(71190400001)(71200400001)(478600001)(9686003)(6246003)(6436002)(66066001)(25786009)(110136005)(54906003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2290;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ieGnBP+f31anR8Oc3PS5MfyZbElbq6Vxq7RHWbUwN41WG0iEX/x78IkyfdTfgQgJGg58tjcKxS2cbdRl/tVaqKfRdCsfYjycEGOeeRwHInRdDA6rnV/f+JZuYz6VswwbIL5BNsvlZCLnAwfp2mWC3O72tnBj+ckuQru6VCaKpSztpHlo88C42Xcoaz7G3Lv5HpJQiwU3Q9pjO4DC5o9Gfy9Hx+SUycT4uXXFX/AsNDLzACH/RJdfvf1Fsb2aYsxx1fmwHQZQS+TLZk5QqZjmus4LjZbF1+XIId+yruh27e/pFe7xBBSq4b9RmYNFfcQ0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 729c6587-2086-4984-b103-08d66504853e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 16:19:00.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2290
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Tuesday, December 18, 2018 9:26 AM
> To: David S . Miller <davem@davemloft.net>
> Cc: UNGLinuxDriver <UNGLinuxDriver@microchip.com>; netdev@vger.kernel.org=
; linux-
> kernel@vger.kernel.org; Alexandre Belloni <alexandre.belloni@bootlin.com>
> Subject: [PATCH net-next] MAINTAINERS: Add a maintainer for Microsemi swi=
tches
>=20
> Microsemi has been bought by Microchip and Microchip is supporting those
> switches.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50223cba6ddb..48abe982aed6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9823,6 +9823,7 @@ F:	Documentation/scsi/smartpqi.txt
>=20
>  MICROSEMI ETHERNET SWITCH DRIVER
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>  L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	drivers/net/ethernet/mscc/
> --
> 2.20.0

Acked-by: Woojung Huh <Woojung.Huh@microchip.com>


