Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeCTFAC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 01:00:02 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:43360
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750888AbeCTFAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 01:00:00 -0400
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: build warning after merge of the libata tree
Thread-Topic: linux-next: build warning after merge of the libata tree
Thread-Index: AQHTwAgIp/1hLBhfHU+k4X5oxRpfsKPYkD3Q
Date: Tue, 20 Mar 2018 04:59:56 +0000
Message-ID: <DB6PR0402MB285693C27664F40857CF24458CAB0@DB6PR0402MB2856.eurprd04.prod.outlook.com>
References: <20180320155701.1122cef9@canb.auug.org.au>
In-Reply-To: <20180320155701.1122cef9@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2807;7:O10T6mzQax+FqJld5mH2a+cWgAmG11QPWfVsnfcEpZuDGAl488yD/JzxSWABTeYj7vb+PiGtk5kPqmEVq/KLuzfYEXejGmooauuKrHOkrg4WnuI23hXUUXvAfBgIkSd1EseEEHL7piCmURUYFDAik6WOENTJVhiQU6HvAORRhf7s1kVXG5i5MFBSItAJQxmzd0xrAKVQWZ6vJxgaJGiPmrE6Ttpt89ZnHb/7+9+cFxoD+4DtErLlAJAOoFEO90dx
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08fda70d-ce0f-4cd0-246f-08d58e1f6d0d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2807;
x-ms-traffictypediagnostic: DB6PR0402MB2807:
x-microsoft-antispam-prvs: <DB6PR0402MB28071C102D46F1289A1B6AC98CAB0@DB6PR0402MB2807.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0402MB2807;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2807;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(366004)(39380400002)(13464003)(189003)(199004)(9686003)(53546011)(6506007)(5660300001)(59450400001)(99286004)(102836004)(4326008)(6246003)(76176011)(33656002)(106356001)(25786009)(26005)(53936002)(186003)(7696005)(5250100002)(3846002)(3660700001)(6116002)(97736004)(229853002)(2950100002)(2900100001)(110136005)(55016002)(105586002)(54906003)(6436002)(3280700002)(2906002)(68736007)(316002)(14454004)(7736002)(81156014)(8936002)(81166006)(305945005)(478600001)(8676002)(74316002)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2807;H:DB6PR0402MB2856.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: I+SSqdawI5/gEo4r+Fecz4SVH2uTnzRXIoeewUwtXGjT7ZbTXV64CyeDcE6rgMXOoSXeRRnGJsjExffAZezEyLA+qcKQmyBfAV/DX6szE+2/y8UqeSCZC/XQ120UX9xzJRF+xKblXsJwZWLSapiafiFsFwdOeU1DR60XyGVuhTDbj6/WSglNjQKKngqhhbSWeagH9WB4AtvrZxEQ+Avy1NzonY0RRVHswUVWk9j6++WF4OVZa09jLy+0XSEno09q7v5Om/gtxZesEKRHh5aY/zW2agDtkS6mP/G74L8QmJLfB2nNG1qeOBtF/2tOpsMHF6hlWGI2X8Se13G7tKwS9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fda70d-ce0f-4cd0-246f-08d58e1f6d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 04:59:56.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2807
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2K50992011315

Hi Stephen:
Sorry to introduce this build warning.
I'm preparing one commit to fix it.

Best Regards
Richard Zhu

-----Original Message-----
From: Stephen Rothwell [mailto:sfr@canb.auug.org.au] 
Sent: Tuesday, March 20, 2018 12:57 PM
To: Tejun Heo <tj@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Richard Zhu <hongxing.zhu@nxp.com>
Subject: linux-next: build warning after merge of the libata tree

Hi Tejun,

After merging the libata tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/ata/ahci_imx.c: In function 'imx_sata_disable':
drivers/ata/ahci_imx.c:478:2: warning: enumeration value 'AHCI_IMX53' not handled in switch [-Wswitch]
  switch (imxpriv->type) {
  ^~~~~~

Introduced by commit

  e5878732a521 ("ahci: imx: add the imx6qp ahci sata support")

-- 
Cheers,
Stephen Rothwell
