Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB84C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D39D2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="iEhQIH6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeLWQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:17:11 -0500
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:17680
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729679AbeLWQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5H9ykXOeLskBv8mLQlvzPhnvFyXQcxKLHOAf8RZyf0=;
 b=iEhQIH6jwP6dIKIlXQ4YZaN3IllCikbezpr2WZd6IxFwLAXsMW/7QDjNnnTVy/59iM+iwiIV/XTCxxRq3XM+lZFD8pkIzS+ILwW6brEDMyVpDgfiy/RdVsss5zzVQz7uUTYPN4vbuxWbrtnk8s1KETo7w4sC3kKqkBNFc+AWIuQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:17:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:17:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     James Hogan <jhogan@kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Thread-Topic: [PATCH] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Thread-Index: AQHUlt2xhqFtXawdHkmfsK5u+ipw0aWMiCQA
Date:   Sun, 23 Dec 2018 16:17:07 +0000
Message-ID: <MWHPR2201MB12774E84F9E6683B8066A8DAC1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181218142636.1134-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20181218142636.1134-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::13) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:zsYmE7oiJdwiVTCoh0PEg1L0E+Oq4aiD2pjW395CZi8wmkCaEOSmBomsTC6HwHm30C87Lpvj3rnejZZfQHbYSOudi5xDcLf7tybcF1gn9/tsFg3WZEdZY9k+tvTGe/hSJgW9hu7ZDD8tR7mlpNbmwt9CstrD6hfKTH7DuKSdXL68TTUSqnLXEhV92DvWeycPvoVyARQ8R80WRdVZtwLCWRyB3xyj0/JWmzt5XimIaut1ySyiNKKhFhLTBtY0F+OPAjCRhFYAzpiUGXXD+3TrE4ZubXtXqk4nfLcFPjyVeUmvca68acbl2OYN59trINJznFatc8Cn9Hk8mZTyLRj+sS55VrIrONhhW1OgQ50AYOTh2BHVnZPDfB+8lWQ5auTHAN6Pl9oJXpchBj1yMB2KjuSVN/AykO7d2nC59cqLjEIQKSNL2J5YAGT6H+YjXqgn8bkvWg+Ko3bv89e5hKgMTQ==;5:Cd33m7XQhioQcNz0txrs6I0nnNuTsgIEQsnu9nY4dnTmumkAjt5wlVauSPCNpr60UTg5ommO2D+wirBvB9Bfd4Ek/SRZnHMf9VuQFG/2laNRsUM2NU6S5kcJr31LD2KL4qE0rUzJo60RoZyEr+hvHolCMs8vZ21q3vC/B2DbSQc=;7:vZii0tCQTGk+FzGzEELsjn/QLJZMwMe+cF8yBTwv+mpjIkrVlMr5FjhOiNNyf3ahcxh+0bySQ2wIcPUg7gXiMEAKLUEri8YTqZ0OIdufQafGHyiAJdYMx7MDQmjA/WO/wwtg++QnMNx4/aPROPMAog==
x-ms-office365-filtering-correlation-id: 77f26793-5840-4dd4-3463-08d668f215a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB1102866A6CAB69011006AB0BC1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(8936002)(2906002)(256004)(4326008)(476003)(217873002)(8676002)(81156014)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g/EJmb1cEFkdA7Rj3r3c19iYQQxHomCLyutnPNPg8OlIFwCVWXRVzOTQab5RY820EtEpdrWHhohJk4jkrYPnUu6emNIokvdtVt78YdeoahdDv6LJi6BT1OLAftlBsB/OmM343Cz//yEtSkgo0bvLBjUFjmSlso9LA9O9CydSjL9I5dDY617nCxZC5oabNUqArzro8+vbSB4j2G2FXele44zTveKLH4ednFZXwsOvZgq/FnUlD1HKHNc1GzVRVycGUT3xhF6dMto8PuwYzgVVjqQFFwFm47f1AkdVDxsa08xPem6FS90d272pjbZosC2E
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f26793-5840-4dd4-3463-08d668f215a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:17:07.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alexandre Belloni wrote:
> Microsemi has been bought by Microchip and Microchip is supporting those
> SoCs.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Woojung Huh <Woojung.Huh@microchip.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
