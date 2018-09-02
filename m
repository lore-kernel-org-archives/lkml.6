Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E485C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11683204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dT9Q/CFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11683204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeIBRZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:25:00 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbeIBRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A9eMszegdlBx8DlAa3VTnscXCjKFIL5o+8+5adOqS4=;
 b=dT9Q/CFaF2GCbBjt+bbZ0GusYiw/BWWRwikJlM2VA+md8Or8qTH96v2rZ+qK8bU4GYWaQYSsfpiJD44ouBcfA7mEFxPS/sOJwprvgsuJwxtPbnnBuPoabw8Ik2iV3YrQJWByESOutvVTHF6c8I+l2xF/ox2lt3jTfasYhgPcmaU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/62] ethtool: Remove trailing semicolon for
 static inline
Thread-Topic: [PATCH AUTOSEL 4.9 02/62] ethtool: Remove trailing semicolon for
 static inline
Thread-Index: AQHUQr4OMln3GozUGUSpaupiWrIf0g==
Date:   Sun, 2 Sep 2018 13:08:35 +0000
Message-ID: <20180902065131.183542-2-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:9kfhM+Vz9vwdscVKVFVMzkn9hLB4fTEauqJgKX7MJH/b1sBRwr3pODwhjvzmYLhT39M2tz83jZCppXFsajuZnn8PeyMYrdq0dPUmChSGYpwZ6H9jSsf4FiNT09dS0klSUVK2p/gOEgIgwvvWUqY20UILEsC+PH4+oe5d3ZBj9U4msILxOpni/QATG6cVLSkkb42cNKv+ADnrUmDUe+G55ajRFXg2CImbi70Mcp/VG6m6pOhVCGiMRdUtmkanKtF5ryGOUCCVjwbEbQ7TW3FuVZbVLSuqFPr+b23NP6fjvAp/xaHkGlczlH0RECVnvEENM1Gzp6P/BA1KpH21Hwt7tfjzSrNJgcsnwLA+aGefcLC8mhzAQsguVe5YyOsir1SKYGefOH6y9YhA3PlTkb2WzAl9Q0Bikt+RRVD0WxGeS+yOX7JYuCOz96E9l1vkhUoiAlCRqe2nr5b/i7vThLGKow==;5:9gno6gwsrvjMFOo/h9L81FygThJcrFTGcqR6OG1IfUtXdirJdnxxw1+yvrxTCW0F4TwriySyhfd6WxVFoEcmOfwb6w4PYRY0Y7wLNjsFerlpH8fG672eAULz73/movZOYESnCWtkE5qiHOfYAnA5dmfPj/1QW5VoXYA9WCay6yI=;7:G7oQHXCwEI57fjWDZitL+qsgDbZUziBd+7sWwkkjixJftlsxGxznh/TtmoiCqOjBCpJIdAz2M0+XHa1261Fjh+jmsfyPC7P79tdbopzSfUqCf5BTOsGpKsNwtsu1QAiJ7IO/LoIN+u/t/QAMtlwfnYscNe0+ewpuD550r648TwMOlzTiKL7YNYkY0KlJrYD3ZYUtL92R5xkbVjCd5fLDXxcCZv5kkCAxMWce1AMfmZ8C4oyxpwLBpCM8OJfRiaBn
x-ms-office365-filtering-correlation-id: c181d47a-0144-42e3-0c98-08d610d53bcd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04690A318E105A8BC91B0C34FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(39060400002)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b8RVh954li4xnbiVeklvCB3e7QPCkTRsV62kA/RLgNa4G5ajH8AtnESpcZUFMfAul+2yABOHupBLFeFw7hmmBTobXpaD6VUxAwGuluAuuwdRIAutNkXBnu00EM83njoEIwp+NqDlPWUcf9qkWTKYsAXdtrVDRN498cDV3H87n2chxqjxVtF+gAmGvFdneKAyGu3ZcPpEbQXl8ocRqhKE+568bXxHaMJCrEAYcp4DEZ68lqsl4mqJEWQ3RzQ28AmOra59ZPn9lLhXiEhJEtbvIqyvGU84uviajJfROSyH50Hia/Levve/4uOUt7aCTnCWM69k3Np4rr8+AuNUhzGiRTVO2lgQWzWISzySK27M2OE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c181d47a-0144-42e3-0c98-08d610d53bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:35.3138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 5c22e8cab24b..8c5335bde212 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -882,13 +882,13 @@ struct ethtool_rx_flow_spec {
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
