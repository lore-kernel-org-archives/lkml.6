Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CBBC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976C62087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="my04pd23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976C62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJKS2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:28:05 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:50555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbeJKS2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC5MqRa1cB8ifXhOON6/aCvbWrBB/c3geYEe6rjxLJk=;
 b=my04pd23you2tlwUqJ/kyG0ktioNiPmAxKutbF6AorYhjQ93rbVzxWMd5eYoWMztmSatg/QpbWzBfBe6hMnREYj3gWm+MEydHZ3+1YN8ZjIpcPaPacixLxXc7CvU2ddd5kK0eK+3+n0oYdbhecUooFDOASFpxx/oWSudCPuPAp0=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1024.eurprd04.prod.outlook.com (10.161.109.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Thu, 11 Oct 2018 11:00:55 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 11:00:55 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Thread-Topic: [PATCH 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Index: AQHUYVGuXDL8bQ8mOEu+Au0CLsFMOw==
Date:   Thu, 11 Oct 2018 11:00:55 +0000
Message-ID: <1539255519-1408-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0173.apcprd06.prod.outlook.com
 (2603:1096:1:1e::27) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1024;6:z6zpt8Z2/uyU5yw2v0BqHODdOJuh6/F3Wh2cEVBEuiTUC9dSWkLuCbOUV1SZzzBaoNCHVncCtknV2cUkrenYbeYpbkQx0gugGdX7Fi/Uny5xMT66cl5ch18f8+lTKsjxJP7HNtqnAYy+u3UkMQDr/afwBGExB0kE/ftVImHft0fYf44sPfPd13dGV73rWoSwFJpliAyNjRLoECeCLmnGXrm2v7mJQ2ViMEZkfl8m0lPbJ4W6jezstOJbdW3r/YEv3DTXNnKSCxj4GVP2kk2ZgKOwZoTRGRTI2t8ecsXIhCHb2xJgKDO7de0TW5juPSsBMfhnK2dDeogVq/v1qQ4A8tdCKflteia9PDqEwGmP4JDe57SnDet3fUp/OG0ZnGTZrLtiRJaSIV02wtZNtHrnK+mx5kJew+ueEd4a0L0XndihHWcCLGD6lzZEwl/UOPTOozyZJRGixXwsyaa8xo5wdstPEP4Ew+ernN5oCylvSkc=;5:Yqb2FzbSleXx6drvlMAjScx4o8E0Q/EhtlGNZF961oPYGdpYKUDL7CGpHd8Mis+/UdTS55hhA4zOoj5TnbGgVLdD+iIPvTa8gf7wmG5PHf70zoVvg+UCWkRbJ5xOj9MmjeUvljVCBI3/QXD1xJKXP7lm3JjRzmy7S2O/QWWbMNs=;7:otW7sbZ5d6KO9cPWeSeGkKObXvtTBUlCrLJwL/7TcBwmeMPfmqJQigJVRCN+MPVmo+41+LqeORZ5c9wpqXYaphzRylUJ0JZGCRqMwkY1/902A7+pt+HPoN3UijjWYeh/4uy8FIJz5+iYOwG82nq36AKjGXyf7fVL4AleUqKkPEL+2c5fWGxGCiveoeNp4c7LDCcoGXEu7PUinK4w3DSVQgbWcpcf7R5UmF5R50QjIWEezpn/6uixPpFm5RxFR28X
x-ms-office365-filtering-correlation-id: 09b0e918-0c49-48c2-cc81-08d62f68d0ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1024;
x-ms-traffictypediagnostic: VI1PR04MB1024:
x-microsoft-antispam-prvs: <VI1PR04MB1024A514601237B5C06086FE99E10@VI1PR04MB1024.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(162533806227266)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1024;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1024;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(478600001)(39060400002)(4326008)(54906003)(66066001)(25786009)(8676002)(2201001)(53936002)(68736007)(486006)(476003)(7416002)(6512007)(446003)(7736002)(3846002)(6116002)(86362001)(11346002)(305945005)(8936002)(2616005)(81166006)(81156014)(256004)(105586002)(106356001)(6436002)(186003)(71190400001)(71200400001)(110136005)(2906002)(55236004)(6506007)(386003)(5250100002)(99286004)(2501003)(97736004)(26005)(52116002)(6486002)(316002)(5660300001)(102836004)(36756003)(14454004)(2900100001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1024;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HJLNzJsc78rtSQccRQWZL2+GaJY7x/NZ44XqH+m1HTtI/I4qLSrKx6+B20efYbMLhJwxlmTpcUvY77u8fZBMAVygpUW77/cmfEfWpapteqs41AFDJFUc7uUVIam1jTPMKdSVk+SM4CI0cRadDqASrcPMhomZ5cOeB7iVY7lwitBeLCGSDtInH6glNse4QaOG5UFAHSyAjP/cLxx8NZGL1lFTicetpgy47AElB9hblQyQsEaQIAqDcFWNlMFcKX+C1JgYoDK1fnmbGrNll2ceDfjpW8aeYr4+aLRLb8GiE2jfStIoDEAiH7bg4ri/qsB3yvB8rqCPrnHwTGSY8yBvJuk8R+Ff1xBrFlqJBcQT3Qc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b0e918-0c49-48c2-cc81-08d62f68d0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 11:00:55.5419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2696898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10228,6 +10228,12 @@ L:	linux-nfc@lists.01.org (moderated for non-subsc=
ribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
=20
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
--=20
2.7.4

