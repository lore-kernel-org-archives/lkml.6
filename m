Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233621-2-3699106600469917345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233621; b=dNuzh4fHxqdpiDhikAnGJ1nZrN2zFJpnD05UClsFuLFfgIAQYC
    QZzF7x07u0+05sOGvv8l19NDOaLXCePyDdwa6mQl3qzq5KsAeftQw+MJi1OVH4yS
    WAYVMawMMQZkNtPGmSv+PoVNMRp8p4UslS3tT3CQ+6LPGlebwY5b85kWj3QiaYHC
    7M/tICLjRCDS+1an73x3IPPJCzDathCrImxyhoF3WUgmGFOlMCbbl+oyrvFhckZm
    R/FMwKiJ7I/ywp8vR9WsRoKs+4jgZt66ax0bTcPglQgg+izpQnzWyGJuiBvWZ2sm
    Rhb+OAT1fq44/rQ9l970rBY5jk5kyyVRV4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233621; bh=HmxERGSuez
    bB9tIc0D81Hc6U3yuTk4J2ST99XQk8t+E=; b=jGQsd7eyxgBBO8/KkJ9QalLYlk
    npH5fQzrywroYF6+lW0FP1ybpVOoI+BQMi986yfJMxqOIkTpcymF/ny+x9ifzH7e
    cgotvzqL8F5hepRdRBcbZZfPh7ecvpdzEK0C9eXGTDbd5sBTl+cy97qRw7J48N44
    D9UMcOwrPugtLdbyUeihM0NHNegYBtMyowc6o1dGb16pE6nJBo6RSPph9k0mMzT5
    p5OwxS9AuFaJW6OlauVLg5tabOii66dNh2WwzRGSFNrcZoGvw3e3Cbnsj/askTcg
    MSzjw5tUSeGsK7pMlfflYf42RyopDlIUbvbKxnN1LAgte8cPuYrYO2iJq5TA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AcxP9V9H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AcxP9V9H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLXoiFsVeGQKGcDKuLGwd4E3HXpAFOoruJ4PLl1USh8VA212w3lm6LvTWa5zwGV31dAGjGj+eCG9ni8GOq1HE0a8O//dUN8tH2WdYjyRSQMiEULD1hsz
    XABSwN1TEgGF8RZd0hxmYbhs7j7Locfms0/RDb9i7ftskiAXDdVQ3f9s0F3dtb904JyVLfGwVdeFfPX12kd3LoKd6lU7sQz2/H1GIOien7Dhdu+IApdRYXtf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=Ll-lzOZgorDEXhrBINUA:9
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755475AbeDIA0y (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:54 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:46250
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754647AbeDIA0u (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mario Molitor <mario_molitor@web.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 023/293] stmmac: fix ptp header for GMAC3 hw
 timestamp
Thread-Topic: [PATCH AUTOSEL for 4.9 023/293] stmmac: fix ptp header for GMAC3
 hw timestamp
Thread-Index: AQHTz5jvtd+9hZey4Ee/y9MqytTWrQ==
Date: Mon, 9 Apr 2018 00:23:07 +0000
Message-ID: <20180409002239.163177-23-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:MHTWkjoViM6v4yugeNdS2sF14P7mSAd3LjV/wEGp/gLgL4MQtGnRz+mTZVSCkVlnDY6C1mdvqMdHbtBUpcCWSDY80zJCkc3oAc9de0lVyyOUfScfhnMMKEUjfC0H3tH7MUNaOiuFa94Le30MjRTQTxCkICw/dOelrr9F+6ZISB7vE91TOspR5QUfi7+AipOCdnnJOvM0xxUSYTEwPSXEsCOr4HY2JsyktOaCROiZ8HHoygzqdrWn4r9u37i8ubGd;20:ZK86enE+U6VLv/RB5K351ZlAFxWg5+ABRibG4ajUAhWyFUF9MEylO/CdZGrKIL4/zCreyZ0GA98telfn8nJ/egFraEqtY4+TiRzGSXGHa/KBJ1QYwi9Dfpsz0p+wpxK1FSmJbg+6aFqn60Gc5agToi+SPyp35YWt6zxuyWsiwMk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b7c4461-3682-4ae6-edc8-08d59db0920b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08857FC30C9F2E48DC6724CCFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(245156298449039);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: cTWsmG9U2ueAQ8UL3WeozykWO5qkvsMW3FaaBICoa+2Jt9TmJNGoaCh1G71XmHPqGHOxelCf+6+5RiZEObqkobBjfAFqQv6zNUS6xUYv174aNt8fhpPOxAc+975qkfcTiJxMVzuwh9Xt9qtGVAf/Ny7Tmrg6QYvQtKkulO+Uox63y4wwhf2E2A66a/jV6p4DCB3zPYoZHgQJig4XRcmZT/wb1x/eZZ2zwF2PY3pWyRjE1HcWPUNSq6yvzFxc5iBS4vX2QNu/FnzwMyg1nkSmLYdLMn2Pb8wwA5EgTAInC9YerOjn5XCXTr+EcVzrU0v7zCSZGbknDxIH7NfEPsc9IqDUz3JuypqEs4wbOEXR95tZju/EmYsdFFikvqTvyt4XX2vITfcZENMbYJh2r5HKzSCT2YnMArTYCXf+3f+i/mg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7c4461-3682-4ae6-edc8-08d59db0920b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:07.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mario Molitor <mario_molitor@web.de>

[ Upstream commit fd6720aefde06eacf17404eed2cad65c6ec103e1 ]

According the CYCLON V documention only the bit 16 of snaptypesel should
set.
(more information see Table 17-20 (cv_5v4.pdf) :
 Timestamp Snapshot Dependency on Register Bits)

Fixes: d2042052a0aa ("stmmac: update the PTP header file")
Signed-off-by: Mario Molitor <mario_molitor@web.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 ++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  3 ++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 98bbb91336e4..c212d1dd8bfd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -478,7 +478,10 @@ static int stmmac_hwtstamp_ioctl(struct net_device *de=
v, struct ifreq *ifr)
 			/* PTP v1, UDP, any kind of event packet */
 			config.rx_filter =3D HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* take time stamp for all event messages */
-			snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel =3D PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
=20
 			ptp_over_ipv4_udp =3D PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp =3D PTP_TCR_TSIPV6ENA;
@@ -510,7 +513,10 @@ static int stmmac_hwtstamp_ioctl(struct net_device *de=
v, struct ifreq *ifr)
 			config.rx_filter =3D HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 =3D PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
-			snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel =3D PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
=20
 			ptp_over_ipv4_udp =3D PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp =3D PTP_TCR_TSIPV6ENA;
@@ -544,7 +550,10 @@ static int stmmac_hwtstamp_ioctl(struct net_device *de=
v, struct ifreq *ifr)
 			config.rx_filter =3D HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 =3D PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
-			snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel =3D PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
=20
 			ptp_over_ipv4_udp =3D PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp =3D PTP_TCR_TSIPV6ENA;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net=
/ethernet/stmicro/stmmac/stmmac_ptp.h
index c06938c47af5..174777cd888e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -63,7 +63,8 @@
 /* Enable Snapshot for Messages Relevant to Master */
 #define	PTP_TCR_TSMSTRENA	BIT(15)
 /* Select PTP packets for Taking Snapshots */
-#define	PTP_TCR_SNAPTYPSEL_1	GENMASK(17, 16)
+#define	PTP_TCR_SNAPTYPSEL_1	BIT(16)
+#define	PTP_GMAC4_TCR_SNAPTYPSEL_1	GENMASK(17, 16)
 /* Enable MAC address for PTP Frame Filtering */
 #define	PTP_TCR_TSENMACADDR	BIT(18)
=20
--=20
2.15.1
