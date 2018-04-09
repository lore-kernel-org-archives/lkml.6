Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233380-2-17775038237961233125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233379; b=joy9vpLmeev+u3Y23YqZRi/LlkXuapmcXqMr6RB0L+6q9kVPMI
    IaaJLICwYFQNUicVyR/GuB1BIZBe9G8sPtw+zOd6jm/wP/p670ZVtZRG+j8xG7rb
    1wIkY8sCGpc0MN8kPOHKimfmiSQBkLsh6sADKLJM/Wa2L8L/HYgh+LkC3fgl7uds
    enJ+gYeLHK1N0RK9QXVUgfeBhaxuiTNPZgpqP+0bpABHP3wriog/ThrMK7B63RDS
    e8FZ9OHbKYCK2h0p10+8qBGHVJoCUwsvJgPjV8KcbPTJFcSlpSy6PCIfsjCMprhO
    sCwwN7YG8dAbU2RjGJkDxt6k8EM4PPBL0HuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233379; bh=nqviKwCNq/
    a/QBEHosZu1z1fMHOwa3IUdLgk+WyTpHs=; b=CjJpX4Y00TGdH01bp5XylOP5ii
    Use20d1QoVmHxHrkf2moy9oFTo1lCWguSMXrH3kktObq6Dk44ioHgafnhGWNNfrL
    xYB+h4XApMxAouGP2J9h4AWTGvOn08yPqntZpbQWGXPZD8+uuORK2vMel+13PLYt
    GCGV61ab+9s+3nM4JLivbWY49RNIbF/VILJSuC+vXLGjtDW13w2vJru2Qq7MMDWU
    qRbfZk/SNe39aM10I5BMRGP3gVvSBTolYeLtb4rVBvJaH4DJFf45ecJHVa3FGsh9
    hIeWse3SbTitp2v40I7hJ7QVP9sURlPzzxUM26W+pZfvfh/WDM7LBRWMYjOw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UTqzU01l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UTqzU01l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrxUTEyH6eFWjsgfB2idor8gjyDq2ZhSuzOkAebIb1vDD77Yvh3E8rvONWl3JsGtoVENUHb1GL8OCnTjZ87AEhliTho96s7gh6dbydMkqDRQNA7SIRP
    pjmbT72cZ+F39cCx0BCZvScFLrSbP7q9GvpZ5+NtMTO/mIgsZRqryz+RNTuPZth6Pa6xPTp0jhh1s8XevdYGotR6yByANHtlttKkC7yhDvejRU2SscyrdIaP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=Ti1_Xk-tyVAdlljdAEgA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeDIAW5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:57 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754735AbeDIAWv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Maxime Chevallier <maxime.chevallier@smile.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 038/161] spi: a3700: Clear DATA_OUT when
 performing a read
Thread-Topic: [PATCH AUTOSEL for 4.14 038/161] spi: a3700: Clear DATA_OUT when
 performing a read
Thread-Index: AQHTz5iIyv5ak0pv+0GRFcpwm3L0Nw==
Date: Mon, 9 Apr 2018 00:20:14 +0000
Message-ID: <20180409001936.162706-38-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:nfrGyqm0x8N1IkMxFWTaKQD7M9u5TTuqjUN71aaewi4IExU+Qi9NxEsoPhm6RiK/uUujL8Vy05/t9M7VqKvD6QcfQL+afqEtXQPjzdfHEb7k8WhaCpNuZHNuTrcQCdOecJTEt6CWr57g+YcQ27RrZelGlYO4oiJ7nhq6TEDGnRTgfiukozD9IBzwmTfJLwzIOcMoc1SY44dBRK56BBjyOWTGSnDeMyu1Md59U+6nPyFT+49VfPGVzL9P0v4hLxhB;20:QLR93Z9uPa3zVpcWL2/qaJdLqs+kQUaFbo12hYZnOXk8nwdnRHDqYQ13NXmO5H+sSc76N2Jocvb70weOz1A6S8ofqNInJp0FnU8zg16Lak4vKB0j8jVA1Qjjn5yiHGI8q4glqhHcjNf5NV3BcPpoSx8SlIQsSZsE2R2WHLJhkQM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ad1038f-0945-4066-5b8c-08d59db0061d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014EE96F8207AC1943AF21AFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HXN0nU8DLBdnqK5pLV8AZ31Qvk4U7KlQo3AxIelFhqI0RZMOjsecJ6JsJiI0uaqKyVb58NhLDm7rprqMiyDZXxSZDFoYSFYbDDCiX9lXI4uZjlbCebwvp5EApWV/XgjBsC6z/7ExN8TFM6+dmTKmycgDdTXWeuc9XGKId6SJTFEFzNxv+slY/LHh07tIETeChsN8vvhG/WRu6ZA1NQOzzzYK22S0REbr8BuUcPiLrN0mQUXCQRyCMzo9iQM3PlyJCVTGOKWyHBFQqnm0NdyvzPEp2JH2yCrAX36s09/JL5rsh4En1NrxXJDzPmoIYX4C6NTjv0GFVagjRrD6J+cAhceT5GSEhdhOBvlzJVRnxREYtFmgwzVCuRLLmw9ZdbH32UQEoLQ1dgo53njntog02Ag7KRIxkxIxw4p4tpoMaRY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad1038f-0945-4066-5b8c-08d59db0061d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:14.9883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Chevallier <maxime.chevallier@smile.fr>

[ Upstream commit 44a5f423e70374e5b42cecd85e78f2d79334e0f2 ]

When performing a read using FIFO mode, the spi controller shifts out
the last 2 bytes that were written in a previous transfer on MOSI.

This undocumented behaviour can cause devices to misinterpret the
transfer, so we explicitly clear the WFIFO before each read.

This behaviour was noticed on EspressoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-armada-3700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index fe3fa1e8517a..4903f15177cf 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -624,6 +624,11 @@ static int a3700_spi_transfer_one(struct spi_master *m=
aster,
 	a3700_spi_header_set(a3700_spi);
=20
 	if (xfer->rx_buf) {
+		/* Clear WFIFO, since it's last 2 bytes are shifted out during
+		 * a read operation
+		 */
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, 0);
+
 		/* Set read data length */
 		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
 			     a3700_spi->buf_len);
--=20
2.15.1
