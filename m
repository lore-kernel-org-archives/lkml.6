Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B8BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6320652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K5BqcSkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B6320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbeIBRbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:45 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729427AbeIBRbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k032tAV/sSQJ2hOhk9lPyAJy9gX7W2qN7DTGUtab08=;
 b=K5BqcSkUxUgxMaT/1HnxcVh3rIir+Kx6GRBOr1jK6MpiRFcQSfjpAw2cxp9l42ZJIbvbiNIUeK3xtr4U7lRl7pV6Ke5HIsB+SxyGS/4Du35SZ/ugDx1tdu7q+Sd9HS4C2it8xRFDsagOjrig2Xj+lkwpTdnb8BZOEb8whiDfCzE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 02/47] ethtool: Remove trailing semicolon for
 static inline
Thread-Topic: [PATCH AUTOSEL 4.4 02/47] ethtool: Remove trailing semicolon for
 static inline
Thread-Index: AQHUQr8LRBWvSV1dJkSOuh79Kallgw==
Date:   Sun, 2 Sep 2018 13:15:40 +0000
Message-ID: <20180902131533.184092-2-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:jjb7HP76xEPXUZ+q0VoxWGP13Av27Eypqfss50HALteebqkfeBCUvPiIsfVcfwyOzB1MuMltSwrLVYhsiEBh700zEyB6dRHUFc8KGR3q/xVyUubPGsNBSO6W6lNUG9ggYHU/8Sq9WHc3UNMn9YVd25v2RwOID7pfu5KST+eFnZ/cmuwIYkej1ItPhxlEPjKi9IbCTYQiBz+oAwORkiOXL2UpdFWy7vLgRWypFQqOAXOz7wEGwz7JzoHDCDcENCFqbuUcyPZvxKNnfvwz9DfFMnxm5SUPqqs8Ais9y3WFxCd/ctcdBVX+OUekifsc0YuZqVywjho7UNzxAOBA7zP/woD6O/CIhX2pXILeUZ2PaZrZmbrUpX6A0HNItBNMaWEXZDQFGyaT6pFS7RMY8Al7vdqZshVUTjC7JSRvqIDClUehFpov5zdgPMTv+dPYk/+fWe08nhQmCUbrFrPdxPaTQg==;5:O3zUMx8deR2/fqbjgp7Xrodw3okTugzvP6WO0UlOI13unCYG57r79sZmkbnzEIEQF/6hvvV1Rk0lJ6Y62hl1GCx2AjeoZnm0NP953FV9wHHdlrM+mqSTOZIrMVJq0UAiZAVXFp4l93vIy1BgVSsReMonaHQIwixI3/ex+uwU9M8=;7:5kwPouTYx8jDRFsSMsbprC/aO0okah4dTIx5/svGBWHRJ4kpEgkPPuRf+qEiRh53iHcApHrfBJlV13JUfWi6wO2sZ7GL7P46Pcxe4Tp8+fTmrsm1l4SosfqEW2JXKmfxFWHJJ6+SAADimAAlFZHibPW5L250G4/plPrqzQBvxO/IgPrXmbrSXv/PJa3wFQXWK6nhOXNB0TaMcJOdqSAbQ0ry9GI9xpHUw9gomNIFB9/9UaqisWs5NZKk9G8vF9rv
x-ms-office365-filtering-correlation-id: 2878ea49-6ad5-43a5-dfbd-08d610d62e16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184FA8BF2C961697DBB6491FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(39060400002)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Oel01bEl2FDfbqpeokY1MZ4OLa9iBMlU7lPrJ7s3+y+zqzXpqs4UaOCmn29DRbQNoLMmCTUwLtlJWxvnGbS89to1fYMmD/3z0OswW5Mc3oB+VWTxV/shvbWjqjZBzqEa0YOjOIM15diULlFlyPJnMzO8h5jTU3Nt/0vvPQTH0taRNJxJk1zwR1BCzJ9gVCAbJQtqSWX+CRN/4Y7xKg7RYMpRHCZgnuoRdq8H+5V8oIUWYnz2q3yZmT4d/3ieZmRvtq7PGex8FhgT2msBqDSPszyAc9Pm/FmmE6biUxYLF0mSnYPgZr0S7MyCki3txhxou1hB701yWwOKc4SA1OJVBx04FD1b93iQCY6osmh6ERw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2878ea49-6ad5-43a5-dfbd-08d610d62e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:40.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index cd1629170103..08f47e0e9f8d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -819,13 +819,13 @@ struct ethtool_rx_flow_spec {
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
