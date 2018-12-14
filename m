Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DECFC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB0620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="fNAG/two"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeLNI5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:57:52 -0500
Received: from mail-eopbgr1320127.outbound.protection.outlook.com ([40.107.132.127]:63584
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNI5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQYga9C1rUorODhGk2sb8a+fXQ+QEL2DBPjwddg5Hz4=;
 b=fNAG/twokR2kAljo2GaMogHpNQWp9OALW7LYxrX79gY4symacrKnpqL1xqVQmrp/ijdZnrUt4R08OXusSrtmyNDJdPj0YHD/O/CS/5+2TFQMks85vER5U7ArlEB0eaUJqiCM8OJ3Pi3HO5iG1oumSfg54vg3b5WmIM8ef/4LEvk=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB4603.jpnprd01.prod.outlook.com (20.179.169.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 08:57:44 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::9545:5575:a99a:a145%3]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 08:57:44 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support
Thread-Index: AQHUkyFuATP9RmiPvEWIgxjwjKfkqKV9735w
Date:   Fri, 14 Dec 2018 08:57:43 +0000
Message-ID: <TY2PR01MB22970FDA6CFA1EED3209E51DD8A10@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1544732481-6775-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732481-6775-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB4603;20:oWUyZCsjyirR6r3amU/4NEcavfYHSijBcbovnyJTAeQkfeg7jQhzdrqmCG2tqFLwplG+7FumAekyHHRvkCsJfytPmUgcjqBJNgodpSfu+fyPJLF/VEIvIfUdqU23KOls/0+HfjryVNvpgPtS6Q4YekFpse+VgKQ/HC+322NNFKI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(14454004)(81166006)(8676002)(7736002)(229853002)(8936002)(81156014)(478600001)(6116002)(2906002)(54906003)(55016002)(53936002)(316002)(9686003)(3846002)(5660300001)(110136005)(4326008)(105586002)(345774005)(6436002)(6246003)(99286004)(305945005)(68736007)(25786009)(186003)(26005)(76176011)(74316002)(7696005)(486006)(102836004)(97736004)(66066001)(446003)(6506007)(256004)(11346002)(476003)(71200400001)(106356001)(86362001)(33656002)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB4603;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: c58eaa83-daba-431a-9c59-08d661a23622
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB4603;
x-ms-traffictypediagnostic: TY2PR01MB4603:
x-microsoft-antispam-prvs: <TY2PR01MB46038D5A485455123EBFE802D8A10@TY2PR01MB4603.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB4603;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB4603;
x-forefront-prvs: 08864C38AC
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cNVInfCBd6FBfEa3UIC0CB9BPHNZoQ4sJRnLTMlSfkMFG4lq6tscQufKekE93huX4yaUnBuLUYSe+pQHUS8uItTfOhIHmWy1bS1veoKxveujXnMecH4e+/lFNTPC9ovDUY/QaJor3jcMbf+U91KhbG6zNnl7GZZ0HgE6DNa7IWPXAb5xnP/G6PP+bwfSSVYd2y7xCTkFwkziPU3BZRTCBqfKBMxxHHkmWbLoiKCOv2lpnzw/eSJ0pO5wm3yg2h1qtDgArulEgfCDP4m6YV+23WavmAHrhJcBEEAODXoapF/rJe1GQUEdbLP7GYza9TK7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58eaa83-daba-431a-9c59-08d661a23622
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:57:43.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

> From: Fabrizio Castro, Sent: Friday, December 14, 2018 5:21 AM
>=20
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> index de7b539..ad9c290 100644
> --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> @@ -6,6 +6,8 @@ This file provides information on what the device node fo=
r the R-Car generation
>  Required properties:
>  - compatible: "renesas,usb2-phy-r8a774a1" if the device is a part of an =
R8A774A1
>  	      SoC.
> +	      "renesas,usb2-phy-r8a774c0" if the device is a part of an R8A774C=
0
> +	      SoC.
>  	      "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
>  	      SoC.
>  	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
> --
> 2.7.4

