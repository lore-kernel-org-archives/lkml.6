Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7208C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D620663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DfCazsfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfANJnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:43:31 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43833 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfANJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:43:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="26378825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jan 2019 02:43:28 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 14 Jan 2019 02:43:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6+TKiH8ZpsHrIuc9XKmb2BDKqQvxMFTm1ef39IhQ8U=;
 b=DfCazsfuJImbygpPvrTPKLeBIqGaA15r9Oe7AdCt4jxbUcZVzU1riBRc/FIRPdQPrkyDKHEhdCUZXLoGbZ3jaGQ284k/sZznNFPGMBZYif7/yLQsUWRFBs/uV11DDqLkwewnwVJwrcH3/d/Kskfvcrz6oU4oCD43N38Utd2cD04=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1675.namprd11.prod.outlook.com (10.172.38.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 09:43:26 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::4c19:f788:c2be:5e8f%4]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 09:43:26 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Eugen.Hristev@microchip.com>, <Cristian.Birsan@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design Associates, Inc.
Thread-Topic: [PATCH v2 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design Associates, Inc.
Thread-Index: AQHUq+2ZtC/782pWvUOTJg0HA2cTRQ==
Date:   Mon, 14 Jan 2019 09:43:26 +0000
Message-ID: <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::30) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1675;6:Sa+Pn80zlkP/DvxXcCOdbzAjEClIginhuWH7aAel/IhzPAia7Cy+M1oXdBMo5nwnciSAuNC59QAioav6j8Ha5uYS3vY7qvKs3vacqtDG0O/EH3aTQX3tQjAt4WHurHVq6oYQJNp0ptg0nKqvtIMys849MLlENYJBYNsaQTOyR0NUJ3f5PvtbpSRrP3JJAl2tWAhotQ5eSCkCMnOBqCn+cKDJgmGocoqHpSZltjKrbpWDvb75E6VToYiGCYW2Cl2vA25QwgCxEZ3pIGT/oKKVvotcW8Pe64vjZU3ah4s74V3om8JTHCGKXC+Xn0+tOfyTISRwkt26lS/zWrcAItRUv6N911c5d37ouwdWnF/vIuiPnWprnPzLzPk1b8llvMRfPJKM+EJiCEJ2VzjuBOsuu9yBOQ8ycsMbcoIv16Xcxv9Nq4A5ilU1fpG8+oerRWa9alKOyYFAYphWTUfvR6n5Xg==;5:JtF8LsZpxc80iw7kaoksH45/07I4JG62D6jeO3k2Y8seNPfNrhhawkHOcGbMxllCfwDnA8ECEhmfWyDJrfkxERqBfZhyMWxvaakPcFB0VRf01ecJc5jkijhJGJZ6JDh5IT046wBm7z4ULw0NUyoLqiagPNvwGUrhFRqkLvW3q7EpqNp4WsWXWO0WzUHSEfEt1+M1FoAZWtvfqprnmJbtmw==;7:591WaWE0qJXVuEHoF+39fO8uoJbic1WpZpDrExm2YnHLylFoO8CMh2x1OTBIjkSmBfbwVGRtro9JURP5g45Nv1/igiVaP6PdF7N0tDER1uhfAFD2jotZ5Fy3I/CuLwVxDr/RdZ0mSXHWimqFju9M1w==
x-ms-office365-filtering-correlation-id: c6d83adc-eac7-4273-716d-08d67a04bb61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1675;
x-ms-traffictypediagnostic: DM5PR11MB1675:
x-microsoft-antispam-prvs: <DM5PR11MB16755CB3610844C0905D57E8E8800@DM5PR11MB1675.namprd11.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(6436002)(316002)(2616005)(4744005)(186003)(6306002)(54906003)(6512007)(476003)(6486002)(110136005)(76176011)(2501003)(99286004)(71200400001)(71190400001)(6636002)(6506007)(386003)(102836004)(107886003)(26005)(68736007)(478600001)(446003)(72206003)(966005)(86362001)(66066001)(8676002)(39060400002)(106356001)(36756003)(25786009)(486006)(105586002)(3846002)(2906002)(14454004)(4326008)(53936002)(52116002)(81166006)(2201001)(8936002)(5660300001)(6116002)(7736002)(11346002)(97736004)(81156014)(256004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1675;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yIV60gJ2tCPwgn0yqsxNPErctB7IsTdGc/fSiH+wMXlT5kNQbn82UVGff0LvK56Rb16d93tHJG6EZLe6mc0TqYVprV++J5P52Zhs7tOpIy9iBefcLikl9oHWKF4zV52wQengA50dw5YdGcRem/DtsK7UmpswXPJjpmfSTfWRvUX5v34m3gs7GJcR1lIWfdSoHajshlpmT25hEapo3MSmkf6NdMVirN5qFY/NWzXX8yvgZ7MZWe7Y6Q/IF8PGTM+FCidLEMdwzX/rXfB1n5MnUf3O/JLqPa/sH1c9dX46USVsxYmClJqCJlZvWqMcXWMRCGpiphrJnMuqbgufYxSIUSyAms5kQhs4Vk2jkHFXHMpxnL5q0j2gWhiybQyfrqQDWoCmu0fRp8HVaQKw+MB39RuC4gv513a2BqmCELSbe90=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d83adc-eac7-4273-716d-08d67a04bb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 09:43:26.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1675
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Precision Design Associates, Inc. (PDA) manufactures standard and custom
capacitive touch screens, LCD's embedded controllers and custom embedded
software. They specialize in industrial, rugged and outdoor applications.
Website: http://www.pdaatl.com/

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docume=
ntation/devicetree/bindings/vendor-prefixes.txt
index 3895085..967a670 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -297,6 +297,7 @@ ovti	OmniVision Technologies
 oxsemi	Oxford Semiconductor, Ltd.
 panasonic	Panasonic Corporation
 parade	Parade Technologies Inc.
+pda	Precision Design Associates, Inc.
 pericom	Pericom Technology Inc.
 pervasive	Pervasive Displays, Inc.
 phicomm PHICOMM Co., Ltd.
--=20
2.7.4

