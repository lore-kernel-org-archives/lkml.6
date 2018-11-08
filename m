Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9B2089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yLLAcXik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D9B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeKHVNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:13:19 -0500
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:57601
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbeKHVNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9uZgkiiKBU22lq40Fw2aEFEsWQzpZ8Q/NGQiFFFYzg=;
 b=yLLAcXikV6c4YnTXWf416JUF9ZdJagv9zvyLWJIDJi+CF3cGPWuccjF1uW/rwJurRN2yjc0QosNuYGskqcm0u0NZP0kl7SGJiqTuRHmIUZMHWoA9/QPVHNtePe4ZHf3FHij8oQZroD1deU7phH5tPG0J7r+1VlBO3A2hELklchs=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 HE1SPR01MB09.eurprd04.prod.outlook.com (52.133.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 11:38:10 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3%6]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:38:10 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
Thread-Topic: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
Thread-Index: AQHUdtfqCNpcjJX2bUWA1IsQb0UP1g==
Date:   Thu, 8 Nov 2018 11:38:10 +0000
Message-ID: <VI1PR0402MB348569B15DBAB6503303D41798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
 <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr>
 <VI1PR0402MB3485342DB8A0F5C5791E213798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1SPR01MB09;6:7ZVT43ZFmJ10KymJ3An/GRaULEJL9EIvSovx3QrJ0z5usoE99F/bVVDEdWlgLwPLafrxmmJ+ajBz7AmhZd0hFYNpFmxCpZTCSWm/EC1SHFFcpuFThR4RojEzybZuejmeKsqvH5gwzh+daSwfjEu/EiM10KFS+6PKC+wd95uzFn4EbW3m21zl+GRu9nJI4f5+W07MnKHAZlsSXCyFOAl64OETUhIq2OkDjSS280USCLYLq96d8Z+Blee3jeh5szq4xvlgnLqULGqpN7aKyEKThTm1GZ3mAiGJj4xVCO0bnT9N787aOYttB7/owkEHta6LzwxiGpXdjx+/wPnOcaN21FX5V2J2tmLkSOzDHNJ/ehbpRhx4cHjyxWH1uJb/Gm6yXoflMgUyJfquFlG8OeYmM3z8/gowscIcYDdru4ObRFRMyjo7ZCunGSSNF6LB25/AMvLcbmqHSCHg40RhKcjbPw==;5:fOxesk8rUuy/Eo6UZa3Ck+156GMTwt8ierDiqTotrHKsKFcLnudf6nOvto23Ig1JidOaOTK7ixH894MoUrbK+mpcse2PfOjk8FhUujUMOm7Ug2ZooTKOh+AzJT0pp60xeAGhddttwxc+58v8hMHDsQuMU9L2QvqReaFrOG6NrIE=;7:4zBtXhtWwPyqybaYzeDleFLOoAc4VpnYtDpmt0MVdNSAqD4o8tV3JTAJ6ArU8PGlHYNYMYKN/0OAJPVVvQ7/rcT3UhueBQ9farsBOS+o3zdV3h6rfJEB6XAx3IC6VJ5jFvuvvRn5Bexj1+mTHUjxwg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 08463ba9-191c-4754-eb3b-08d6456ea8df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1SPR01MB09;
x-ms-traffictypediagnostic: HE1SPR01MB09:
x-microsoft-antispam-prvs: <HE1SPR01MB095B100578755B2FAE2EA598C50@HE1SPR01MB09.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(191636701735510)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1SPR01MB09;BCL:0;PCL:0;RULEID:;SRVR:HE1SPR01MB09;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(53546011)(478600001)(105586002)(71200400001)(106356001)(54906003)(93886005)(316002)(110136005)(6246003)(66066001)(68736007)(71190400001)(39060400002)(6506007)(486006)(76176011)(93156006)(446003)(44832011)(7696005)(229853002)(186003)(26005)(476003)(86362001)(256004)(102836004)(99286004)(9686003)(2906002)(3846002)(6116002)(55016002)(33656002)(8936002)(6436002)(5660300001)(81166006)(8676002)(53936002)(81156014)(74316002)(2900100001)(7736002)(4326008)(305945005)(25786009)(14454004)(97736004)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1SPR01MB09;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o0m/0j5r0UfHiCmO971jt7JhJ14T0Kelxjk/xiFH6ZGM7yY7xhEAabbGpG8Mwp+ydYsBJPUFPXMAyQcYsuYIcM0gs57bBMlo+ZVI2lh8D2DNb7zws6TY3ZLIJrCJRh0sXiqAWMjLGRMPwaBdwBvXGjhBn05dE2usMLDL+N6gyGoMnafdjquV74OTa7vVEFzMYe02Sde1Fklop/B+CuxU44DdO2efEIUPJOdQKLgtRO5d1Nb63KWGKTy6RAEefMbAmey44oBE8QXyhr4+gP5aj5NWL9eoz1GCImJYGy+Pk1JgyNSJ/b8BN7aPOdjHZ+rM2XdQYrdj9tByW7H8IGMKH9LfejD2E3m1zFRs63t2V80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08463ba9-191c-4754-eb3b-08d6456ea8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:38:10.0339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1SPR01MB09
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 1:23 PM, Horia Geanta wrote:=0A=
> On 11/7/2018 10:49 PM, Marc Gonzalez wrote:=0A=
>> [ Add interested parties ]=0A=
>>=0A=
>> On 07/11/2018 21:18, Marc Gonzalez wrote:=0A=
>>=0A=
>>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")=
=0A=
>>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,=0A=
>>> which is not set.=0A=
>>>=0A=
> Thanks Marc.=0A=
> =0A=
> Though I would prefer enabling the dependencies:=0A=
> dpaa2-caam driver -> dpio driver (FSL_MC_DPIO) -> fsl-mc driver (FSL_MC_B=
US).=0A=
> =0A=
Could you instead incorporate below patch in your series?=0A=
(I am pretty sure it won't apply clean)=0A=
=0A=
Thanks,=0A=
Horia=0A=
=0A=
-- >8 --=0A=
=0A=
Subject: [PATCH] arm64: defconfig: enable DPAA2 fsl-mc bus and DPIO driver=
=0A=
=0A=
Enable fsl-mc bus and DPIO (Datapath I/O) driver, which are needed on=0A=
Layerscape SoCs with QorIQ Data Path Acceleration Architecture (DPAA) v2.=
=0A=
=0A=
Suggested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>=0A=
Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
---=0A=
 arch/arm64/configs/defconfig | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig=0A=
index c9a57d11330b..7c3785e61ef9 100644=0A=
--- a/arch/arm64/configs/defconfig=0A=
+++ b/arch/arm64/configs/defconfig=0A=
@@ -181,6 +181,7 @@ CONFIG_DMA_CMA=3Dy=0A=
 CONFIG_CMA_SIZE_MBYTES=3D32=0A=
 CONFIG_HISILICON_LPC=3Dy=0A=
 CONFIG_SIMPLE_PM_BUS=3Dy=0A=
+CONFIG_FSL_MC_BUS=3Dy=0A=
 CONFIG_MTD=3Dy=0A=
 CONFIG_MTD_BLOCK=3Dy=0A=
 CONFIG_MTD_M25P80=3Dy=0A=
@@ -615,6 +616,7 @@ CONFIG_QCOM_IOMMU=3Dy=0A=
 CONFIG_RPMSG_QCOM_GLINK_RPM=3Dy=0A=
 CONFIG_RPMSG_QCOM_SMD=3Dy=0A=
 CONFIG_RASPBERRYPI_POWER=3Dy=0A=
+CONFIG_FSL_MC_DPIO=3Dy=0A=
 CONFIG_QCOM_SMEM=3Dy=0A=
 CONFIG_QCOM_SMD_RPM=3Dy=0A=
 CONFIG_QCOM_SMP2P=3Dy=0A=
-- =0A=
2.16.2=0A=
