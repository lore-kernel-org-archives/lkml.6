Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F28C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A42208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="AMKB9/fL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A42208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966336AbeFOQfN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:35:13 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:61369 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965957AbeFOQfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:35:05 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 16 Jun 2018 01:35:03 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id DE05844171;
        Sat, 16 Jun 2018 01:35:03 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,227,1526310000"; 
   d="scan'208";a="282654689"
Received: from mail-pu1apc01lp0023.outbound.protection.outlook.com (HELO APC01-PU1-obe.outbound.protection.outlook.com) ([65.55.88.23])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2018 01:35:03 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOCrS0RubLKrDR7Le4j3cSBO//xJ3smjQFhciupD+kQ=;
 b=AMKB9/fLwFAlp+kfNdEVLSk5gNr2ijltC2kZhdjpyxiS8ZzFWJ4YJMf+LazNuWsQnwu5jCa6YZrAnDR1dII0Su5pjWv32khTBvDdDrg0zoD3AUnr3IQt43339Sf2q6Adsf1I8QOMrSxVfXSYcjKndQa3DyQArC5YaSHhxfr5gB0=
Received: from TY2PR01MB1962.jpnprd01.prod.outlook.com (52.133.182.14) by
 TY2PR01MB2601.jpnprd01.prod.outlook.com (20.177.98.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Fri, 15 Jun 2018 16:35:00 +0000
Received: from TY2PR01MB1962.jpnprd01.prod.outlook.com
 ([fe80::2c22:ea7c:d1cd:f587]) by TY2PR01MB1962.jpnprd01.prod.outlook.com
 ([fe80::2c22:ea7c:d1cd:f587%4]) with mapi id 15.20.0863.016; Fri, 15 Jun 2018
 16:35:00 +0000
From:   Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: RE: [PATCH v4 09/26] media: max2175: fix location of driver's
 companion documentation
Thread-Topic: [PATCH v4 09/26] media: max2175: fix location of driver's
 companion documentation
Thread-Index: AQHUBMZCNSUV+WoUdU+Rku/QIzyBtKRhg6dQ
Date:   Fri, 15 Jun 2018 16:34:59 +0000
Message-ID: <TY2PR01MB19625E3B383DEAB9E66A9D39C37C0@TY2PR01MB1962.jpnprd01.prod.outlook.com>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <83d51717aad227a9cdfc117b1d82cdb3746aee6f.1529079120.git.mchehab+samsung@kernel.org>
In-Reply-To: <83d51717aad227a9cdfc117b1d82cdb3746aee6f.1529079120.git.mchehab+samsung@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ramesh.shanmugasundaram@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2601;7:GB22wMNGu2ExHjZiSzkdup1oLQuwCkQXMmvw3fVy8lNjy70vnFd/ZpyuRBAJ2xtAQecbSNg/QWzSL13Y0MOmUnF2NjTj5STMkbox1a0NID7XK1Zk7Et/b/dTmwk420WyX13yw+jYdTrGk12Sr0mcQ49zsawZaxsg2yvzffC45iKBPOMtlNWOwZkJUFJU/iIPJJRw6T8vVuLh1/kMiefxwVandGHkrfMKSsR1KUF4tymUiwHAOywettdeq+q1Fdqk;20:7nuqTHV7UMG+aTtmWErd4jAAItjKNAVS5epbUW22MhdNkVdTE/Mr24M3G1vAxnDFV49wgffGcYTAfGRGtkeku+rst1cqTYorV/p/Oim8AmV/UO9jKAhJKEvRPvDwdYq7tzRshM2eMtvnDW/G59HJ9Q9++80dCd/UaDeRnxRuzzQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3148b746-f4fc-4e9f-eaa2-08d5d2ddf010
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2601;
x-ms-traffictypediagnostic: TY2PR01MB2601:
x-microsoft-antispam-prvs: <TY2PR01MB2601C08765250D39863384AFC37C0@TY2PR01MB2601.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY2PR01MB2601;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2601;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(189003)(199004)(81156014)(8676002)(81166006)(446003)(6436002)(8936002)(9686003)(7736002)(55016002)(99286004)(305945005)(6506007)(102836004)(74316002)(66066001)(486006)(345774005)(476003)(11346002)(14454004)(44832011)(3846002)(6116002)(86362001)(3280700002)(25786009)(229853002)(4326008)(97736004)(5660300001)(2900100001)(105586002)(106356001)(478600001)(5250100002)(26005)(186003)(76176011)(7696005)(54906003)(316002)(110136005)(33656002)(558084003)(3660700001)(53936002)(68736007)(2906002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2601;H:TY2PR01MB1962.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UTnSCnOXYjEQ6GNEc6LOU83+u4eeGOaxQSbQtVeZpR2Kj46baHkPVkfcA042I4V+Lk4vr2uN8iM/6VYiPiRt2QQfpuwZbPpbFOP7QK7056gx1Fw+IelMd5eH59qIT8goSg0O5QvBcyVxZ2KMnqWp020pJX4yw5IPDYPMnsuq8Qo9T7wDru/c9tB1ia9hGF5q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3148b746-f4fc-4e9f-eaa2-08d5d2ddf010
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 16:34:59.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thank you for fixing this.

> Subject: [PATCH v4 09/26] media: max2175: fix location of driver's
> companion documentation
>=20
> There's a missing ".rst" at the doc's file name.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Ramesh Shanmugasundaram <Ramesh.shanmugasundaram@bp.renesas.com>

Thanks,
Ramesh
