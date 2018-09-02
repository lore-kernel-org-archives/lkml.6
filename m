Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA920C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE8C2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cyO9m9Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE8C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeIBRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:16 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728528AbeIBRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrCBY1g5hYmjhiNjKUdZb+eUtDVLmJso3rcHNhfcui0=;
 b=cyO9m9XooyFsN/TlePfTKHp0wdmoQZURa1qTGedUtoykZhRyhpTnhPepLiRr0+X4iKPum4K6X16pTDaUDIs6X/oFs02fEjJaD72gR1zwL2Y7PidzIjoSYypqG3SvjiTLH6ZGh2emvMTCOVfmLhHtSamrTu1maR+SmQS81+V3Y7Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/89] ethtool: Remove trailing semicolon for
 static inline
Thread-Topic: [PATCH AUTOSEL 4.14 03/89] ethtool: Remove trailing semicolon
 for static inline
Thread-Index: AQHUQr25A8F2BYDA9UOqpvcFBm9Njw==
Date:   Sun, 2 Sep 2018 13:06:13 +0000
Message-ID: <20180902064918.183387-3-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:yvkMQvkUMQ0A8k2GlwD2VVSFHle3o9u6cwWLzky3U4VAyFWe3C3ifZ+pYSXlbqJwFhSof8CCfhjVgdoiJ5ygvZhP6+n/sugZbNl4AwbU8ZP80iN3+RvYGBUe4r1gb0tVYrrR5noLLl7Caju3uQN9bMlaAf2GrSSOvvubSP6YATGaqTyTdBsPHr7NyfkzUSS5mL6UcvPu/+HM5GTkRg0nJh3xoGzcFZe3yEE/DX1SiOY64VZLfgO+wh4/SZoTgDY5WudCf7Jr5NZqqXuMXXoqGETHp/1H46nICEdv2hJZberYrfk5BK+oeZDW7e/wCRT8VYv/NEhRekVvR2lEDw6uMQuFyo3vlmBA6717NP8ie4yY+wa2m4Am56jUpiDfVXstTtdKaZ1TD30xOneFILyEQmA2nQwEYheMpQfnmJpoEDMpx1uofFOsBZhqxQmiXnuADxBsEDgILLkUrraBJay+gQ==;5:B21GbRymQbnzxtyk9hwfwWtuPJD/+s+Dkrvl5tppkQUTnlejjog6Pg1r3g5YI8b1CXC9CIkxCrEUtTfVvHs3ffWSxlqD7CbMwJmM4XJTj2nxxdQ+xD2n46amvA4fRWx1hgnUi+a5lcRUlbSXqv2mS5xNxzDVP3gmb9dOhwH9Tvc=;7:rfu77SWLrLELUrU4y/oCkwu5jcsXjMKDi28egzmmJpQGiUcSJIiWxFwiDGlWOX8cYjAiDwE9qFfPjWEnTamSk12EJIF+C/By2jAXDsdM/pmgOYmgrIt4jNn9mD7B8eXIfjpoPXIdcgc2NpO7lDhdxDn8cES/0dHVwP4K3ZP5wy5n8po5TrOEiJanlABmj16ObmKiKgeGpa237pbB9Z0Kjk095OrDm4FBO2KTM/cRaOTz6RTNe4SFuePJOgiMS0jA
x-ms-office365-filtering-correlation-id: 938ce137-c7c3-4240-3425-08d610d4e0dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08222F64E1BEC329741E32C1FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(39060400002)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MxfGesbbX9XlJZeKK2IiNj0C882zRy+rYgg2g7gUZBYkPLwgjmyXj03UO0III4O+uRofjOHw4wJC29IZBB7FZe79hdrXyCKS4eIyGApZcsmsh53sUb7gmP/3nfcpiW5rhyrfZ7YwZLkV3YkJxr7ltGaaYLQCqMFBpCl4IK1xAzwEnrQrHn/GvRXyXWApc3xNfGDERX4V79FEAuOvjQ7Rasi3AxmGPPdjcOwfYPkeCRPfh99Rj2f5n8PPmTmJkutXqjVOS2Ni5RPNO2A4W/W2lPndxi2hfsXoTUC4at48DhVCW4GANHjZn7ZngRF+Lea4UXzVQad9dp8A6nZXv7vdqvGsFSSOAcVkVvJbPyGIh84=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938ce137-c7c3-4240-3425-08d610d4e0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:13.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit d89d41556141a527030a15233135ba622ba3350d ]

Android's header sanitization tool chokes on static inline functions having=
 a
trailing semicolon, leading to an incorrectly parsed header file. While the
tool should obviously be fixed, also fix the header files for the two affec=
ted
functions: ethtool_get_flow_spec_ring() and ethtool_get_flow_spec_ring_vf()=
.

Fixes: 8cf6f497de40 ("ethtool: Add helper routines to pass vf to rx_flow_sp=
ec")
Reporetd-by: Blair Prescott <blair.prescott@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/uapi/linux/ethtool.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index ac71559314e7..9eae13eefc49 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -898,13 +898,13 @@ struct ethtool_rx_flow_spec {
 static inline __u64 ethtool_get_flow_spec_ring(__u64 ring_cookie)
 {
 	return ETHTOOL_RX_FLOW_SPEC_RING & ring_cookie;
-};
+}
=20
 static inline __u64 ethtool_get_flow_spec_ring_vf(__u64 ring_cookie)
 {
 	return (ETHTOOL_RX_FLOW_SPEC_RING_VF & ring_cookie) >>
 				ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
-};
+}
=20
 /**
  * struct ethtool_rxnfc - command to get or set RX flow classification rul=
es
--=20
2.17.1
