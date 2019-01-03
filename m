Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7732C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9B621479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ohlZY/Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfACTtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:49:32 -0500
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:43776
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbfACTtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlLWOr5HpV/QNtjbRgnLyTJhkh0cUGgUxox7+ZhJHD0=;
 b=ohlZY/SqgnmRDTxhETSOAuEG/pVVBjAHAAEI0+Xng44KjJDUPN+h0QouN4bFxttVEgZBCGyNqENuIy7t6JBiosk7IAa74FBGPG8t9aH0LBhtQXFtBo7XGkVmTxI0WUHj5XKK4UuBh3kqe4oQ+ldBXZdZbaQfRrSCidmDnPTzJpM=
Received: from BN6PR21MB0114.namprd21.prod.outlook.com (10.173.199.140) by
 BN6PR21MB0177.namprd21.prod.outlook.com (10.173.200.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.1; Thu, 3 Jan 2019 19:49:27 +0000
Received: from BN6PR21MB0114.namprd21.prod.outlook.com
 ([fe80::2da9:4f3e:398e:e7e7]) by BN6PR21MB0114.namprd21.prod.outlook.com
 ([fe80::2da9:4f3e:398e:e7e7%4]) with mapi id 15.20.1516.000; Thu, 3 Jan 2019
 19:49:18 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        apilotti <apilotti@cloudbasesolutions.com>
Subject: RE: [PATCH] hv_netvsc: fix typos in code comments
Thread-Topic: [PATCH] hv_netvsc: fix typos in code comments
Thread-Index: AQHUo5ydRZ/sZu8fPU+iMYazO9utyqWd8xYg
Date:   Thu, 3 Jan 2019 19:49:17 +0000
Message-ID: <BN6PR21MB011407C0A4C2EC0BE7A3DB41CA8D0@BN6PR21MB0114.namprd21.prod.outlook.com>
References: <20190103194308.4217-1-avladu@cloudbasesolutions.com>
In-Reply-To: <20190103194308.4217-1-avladu@cloudbasesolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-03T19:49:15.5907437Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0177;6:6gqSLPvfKeosGYqXc9terOFjkE4g3Au+GadWt/c1R/ymjYcdMdOCIUCbI2pQQzRro64Ab07Ley1ZUMqrWoV1Ph44WRNGPvFLaplTccfwPakOlEcbwoUa0Ogm3g32IvIhCNXF8DGbK/A3piSENcUaQNTBPUIpyhhlVCE4SngDPw9mDw/L5QtJYEEJTE8NA027erbZQEphD+pzajSXOwndUStByvGs2eSNXJoxSGFdiwAMX9lm991WkLIjLYimNF4M27oBUjOnwLGG9x19mq3Fv8XAPvgGiJLRA4wKipfCBCsDioKuFmwPG2jbI72IFtosKm8b9ApLTpcHcyPx1OSHloiJ8jW43lWKEe0CDl0QlhxJ5+zhBGErLHhUOd167TuJGlGhbwtm8bDdT24l5CR59DabwS8RukYbqPVn4146ygKk1Yf6cNyB2gjWUBSWbKkdv5BrbycTxd4aIJw6Urla0w==;5:+ITi+hBjy53Q9ceGjNqVzdG21aOTFPJPzWDA0T0AdCFj3KNQ8dmZTMkFlrHA3wB8oeZEkaMFYH/nNVsMvpaoXnxLBNU8EpZyu/IeoAaWXdb61Y/Z2uwWKhH1bShTAkInXAN4CukVOpsq+riq9DNSxKRUYiCK7Uo/7UT3GC3s0JR+7iVYjFa6Wj82KI0sH2JdovzXikel1kiE01KjlpQnqg==;7:nO9ECXu+eukWy2B7epVs0KtT000Fo++Lf9TTFHcnB5zClzYPikgDT/BhN5WEVWtzQOE+ynSDECNR8peUFp/RFWiDzuRvbh4ZweA8IZHPb39FIyNOhyfB0OUG9YC22xX3sYaoVT+JnHgNo+7+kt+h6w==
x-ms-office365-filtering-correlation-id: 576e9b4a-01b3-446e-54b4-08d671b48c42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0177;
x-ms-traffictypediagnostic: BN6PR21MB0177:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB0177DF78A289CD685ECC18E4CA8D0@BN6PR21MB0177.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR21MB0177;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0177;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(396003)(366004)(346002)(13464003)(189003)(199004)(4326008)(86612001)(305945005)(25786009)(2501003)(2906002)(97736004)(11346002)(476003)(8990500004)(486006)(33656002)(74316002)(186003)(446003)(10090500001)(10290500003)(478600001)(68736007)(14454004)(7736002)(9686003)(53546011)(6506007)(256004)(316002)(66066001)(54906003)(106356001)(22452003)(110136005)(3846002)(76176011)(8676002)(81156014)(81166006)(8936002)(55016002)(26005)(7696005)(99286004)(53936002)(6246003)(102836004)(105586002)(5660300001)(229853002)(6346003)(6116002)(71200400001)(71190400001)(86362001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0177;H:BN6PR21MB0114.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /JnkNmLmob6rp6+UVSQaNQfuw7ffF00XDV18NiAFMZcq/0R+L9Mf6NfyZ1gdinkwyT/laiJ/tP1Zx5m0gfdoiPvP6fD3pHnFGP2Vn5ojiZuwZXteOLkLdWhrUx0OntJgP+1sc7USPFjTGBF/tnDkimm2CdhTUAaUhAjcaP2eU/7CnFafXWqI0SnaLmfazW0we3CjXwa61yw9jGqHYbcz5E+mkrMh5SYObFrhbzrifDAvEAQauqVCXkNQA8J758PudszbIe+wx9MslxD4Hy1bpQgZ0a9A8GUNdjhHtYZ4HaaKgcOnfiOb6rh8rsZGdZpf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576e9b4a-01b3-446e-54b4-08d671b48c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 19:49:17.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Adrian Vladu <avladu@cloudbasesolutions.com>
> Sent: Thursday, January 3, 2019 2:43 PM
> To: linux-kernel@vger.kernel.org
> Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
> David S. Miller <davem@davemloft.net>; apilotti
> <apilotti@cloudbasesolutions.com>
> Subject: [PATCH] hv_netvsc: fix typos in code comments
>=20
> Fix all typos from hyperv netvsc code comments.
>=20
> Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "Alessandro Pilotti" <apilotti@cloudbasesolutions.com>
> ---

Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
