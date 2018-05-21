Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbeEURbB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:31:01 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:6496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752943AbeEURa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:30:56 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH v2 1/4] PCI: cadence: Update cdns_pcie_writel function
 signature
Thread-Topic: [PATCH v2 1/4] PCI: cadence: Update cdns_pcie_writel function
 signature
Thread-Index: AdPxILlBz8vABv4VQZK3Wj7u0Yvp2Q==
Date: Mon, 21 May 2018 17:30:55 +0000
Message-ID: <SN6PR07MB4512BA57E8D259911D244E20D8950@SN6PR07MB4512.namprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iYWQ4ODYxZS01ZDFjLTExZTgtODZlNi1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcYmFkODg2MWYtNWQxYy0xMWU4LTg2ZTYtYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSI5MzYiIHQ9IjEzMTcxMzk3NDYyMDUwNDg4OSIgaD0ieVppcm5iSnB0dFBpZTJBMWVCdkttQ21mN2pVPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4910;7:9Ho0i0PJIVGDbvukZgOhysc7N27t0V8DlQbWKgpDOEgR7LcmcruPGq46OdkmbYhQ3qFInEYdVP2f4DucQW47uLnkJuS2hz0PS0tsGDlHatbh8LQPjFD54patBRbcZKklT9aUxwXkxWxjp6AqZT2P9/WE5Ij+zm/aQrCRs4FpwaHsPei4aYnylYRJeJdMDzDetICsXxGKRathK5G03lE24xM3B59DD9zKXMGu1AhosMt+MJG8BD5Fa0u1nHV9M/uJ;20:d0ocDAeqb4UHVQppSaZ9ib+/zcNOTJaI/HRE31Hsu/B6szpYdjwSw4XcAHE6p0oTMd9/ctwyFOS7hlhzs8kdzZkfEoAmKlVKSN/2tE3N7iGvrcoSzHmmKtlviDd+n1grIxHlKv5DpVZCF3Rrm6G6BfjpyRZ+ERgODZl1DTJ5k2D1yoxPGCWzNyhl8vXj2LnhhzrcRwISssfuPZWKC0ZkHmavwBoDfEdLgPgKBxv5CMfd5hR7mwcyNDY/4UYvtn9H
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4910;
x-ms-traffictypediagnostic: SN6PR07MB4910:
x-microsoft-antispam-prvs: <SN6PR07MB4910A16A284DCD7DA78F9F60D8950@SN6PR07MB4910.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4910;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4910;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(189003)(36092001)(199004)(478600001)(6436002)(102836004)(68736007)(14454004)(66066001)(25786009)(186003)(54906003)(4326008)(110136005)(33656002)(316002)(3280700002)(3660700001)(55016002)(2900100001)(26005)(105586002)(99286004)(53936002)(97736004)(2201001)(3846002)(2501003)(81156014)(486006)(305945005)(81166006)(106356001)(8936002)(7696005)(9686003)(59450400001)(74316002)(5660300001)(6506007)(86362001)(5250100002)(476003)(8676002)(2906002)(6116002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4910;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: i1DaANi6BVeIwyI+pSqAbw457WhPRx6+oZUIf8X4ZxYVC7IzJP3/8k9O8Q5mOi1cAbg8ur/q1zchFPgDYIQJXSRaJeILLpJGNwNjx8qhrLREtxS31+MGHgrZUMwB90B459Xduz1gdTpxLGvaD5v53UftuM5RjmvYuG+2LHmpleS4MttSDhlibsVIkLucJSABjDIkCiJpHhJwXNJ8vEkdVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 60d84a19-f1d6-4d34-67ac-08d5bf409b98
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d84a19-f1d6-4d34-67ac-08d5bf409b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 17:30:55.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4910
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4LHV6w2023685

From: Alan Douglas <adouglas@cadence.com>

Change cdns_pcie_writel() signature, u16 value changed to u32, since
this function should write a long value

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
index 4bb2733..ed336cc 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -279,7 +279,7 @@ static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
 }
 
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
-					  u32 reg, u16 value)
+					  u32 reg, u32 value)
 {
 	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
-- 
2.2.2
