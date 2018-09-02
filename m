Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FBC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8C120841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="muXcIKIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8C120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIBRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:02 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbeIBRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QjLhr2CIxgka7ehoZudjqqrxTH89Kfk0AAO1xOhQoI=;
 b=muXcIKIyvfQXE+gKIWKNCzulMIwrbAFMON/eMTHKIbeuShbewnTQaUMCAh8eL0vsmrrkS+cXqTilACwE5iPA9ngFNdgEH6Md0YBreUnjG70MTYcG9C4xehd3hte3mF2gyQofNcveneadqv/P/jnJU5am3KSUt8SKPo9C4hlvSts=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 005/131] ethtool: Remove trailing semicolon for
 static inline
Thread-Topic: [PATCH AUTOSEL 4.18 005/131] ethtool: Remove trailing semicolon
 for static inline
Thread-Index: AQHUQr1Ig0ZODEoVmESZvMvOu8kq7A==
Date:   Sun, 2 Sep 2018 13:03:04 +0000
Message-ID: <20180902064601.183036-5-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:eFWDRUD7K77rVQSAvHyN9U1gv13U+05NAFz6XCKL4aQDINxzuq2vE6yWfzpmNZnECcxOaoeiP0nDPUj12nDN4Mf/FcWK6EBxvqFLG30fFK0cX0RyKxgmzfjfKKmb0ndGplk2kjqplOxhkDHtPWmqG7Sa0JEm/1wnVhYws8fVAf6aIT5o6EheMb6MKzY1n74+uH7dGZyhALjIAvqJv/Rh0fKQGQx0nIPiNPiABI7pDm0GYeyNQIDPpXTALVVQml0OAxwbc0AkWWoA9Re0PZwN22WMY6JkDy5rVoipiXiV9qksoSSr+U9h6jhd/67uV51r3A/eZep/AhIXSJqVHiABedNTtBxSitgrVyerMiwg53KaMm9d8VoU32OQsc9ZukhprGmcfw//WVklzetdX211UXNvNWL/ETjWwl16vgkniuWANEsaJZRzAanVzkw8LfHirtjty7IbF1MDPtfhzOhhfg==;5:58wHroWhnmfQuSfeqc7KVp0Oyw1Llo7dPjRrxkAFkITiVQDo5zZl6Bfc/P844LNx6EPkxq4sEsoEK5vZNcwYqpAYY9MG7KPz571I7YdvC689GkiG8l872RVRJ7Uj6pnBx84x7L4qVF8XEPyY6dp78pS0LmiWIiQ8cnT7YKRxzWk=;7:uwJ17JoP/VfJOB7GhWgWF2UKzTbpraq7Bs8HdI4JWUpsUoLJQj0zzFqpd4ckvuF+hUmwVbkmeFnJhfiG7HGI7ewd+h2Sf3T0Dv/T/xQDgtgSVVeF/UHaLHAHMZI2XBcztaW3D+RuX4vxsy4GGxVIEUt2deQMA6Ncxfk4M3A9Q2KwNz3pAHM2mxvdkXFsBgH53l8RkshnewjzGTeDP+TseyWaVaHcNSfrGcTrvd5Xa4MuNhMlr41Ms8S0n8kj5Q37
x-ms-office365-filtering-correlation-id: 376019fd-720f-4143-a8bf-08d610d46b8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837FD04B1D07950549DD605FB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(39060400002)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eNVNAQhu9EMEMW1xyfJX473hoU0TrmMqtVMD7LdbbX69zy8uydye5lffWcuELjdcG4vAhEMwwVbmGRBpuNLzxWfsWldIgWHOQMF8N4XSZKnl1Ki2QxazX9aXxYyxAe2h1wzTVKOPLT16E/KPH7/je1KwZ6m5LMVPE/XZd90UNkST3/jpy+1CkBtgAg2KJf+3/OwyUsp0WkeJrG2YBQ7c482qcd6u7O9DX+hUMrCgombPugZOJ5NTSXv27Wfj2/WjzyTR6amvtpw3DEsyZUJP02JE73apyUkHF+koZyOixpwrZsjBSiIqzOzcaxNDwc5wuX3qG+ZZZEqXIGVEvG1X45q+A0J6ii+AGieqd4185ck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376019fd-720f-4143-a8bf-08d610d46b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:04.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
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
index 7363f18e65a5..813282cc8af6 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -902,13 +902,13 @@ struct ethtool_rx_flow_spec {
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
