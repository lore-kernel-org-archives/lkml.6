Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeDMV57 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:57:59 -0400
Received: from mail-ve1eur01on0079.outbound.protection.outlook.com ([104.47.1.79]:32035
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752317AbeDMV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:57:55 -0400
From: Han Xu <han.xu@nxp.com>
To: Stefan Agner <stefan@agner.ch>,
        "boris.brezillon@free-electrons.com"
        <boris.brezillon@free-electrons.com>
CC: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: mtd: rawnand: gpmi: document specific
 ECC strength
Thread-Topic: [PATCH v2 2/2] dt-bindings: mtd: rawnand: gpmi: document
 specific ECC strength
Thread-Index: AQHTs/Q8LFy3ZB+PtEefWPRU3UP+6aP/fQUA
Date: Fri, 13 Apr 2018 21:57:51 +0000
Message-ID: <1a657c4a-5f2c-e2bd-3d7c-9efb978ea469@nxp.com>
References: <20180304200602.11475-1-stefan@agner.ch>
 <20180304200602.11475-2-stefan@agner.ch>
In-Reply-To: <20180304200602.11475-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB1840;7:XQ9lPfIDxn25GBYZTAkOawlWGM1VYe9hAJDSBSwX8IwPZQGY9FSxdtiOysq7MfQaarY+D84I20/05nuVzIRe20bK3q4zMOuxTv52onSp65J5TR8nt5va0tK3Ipk4VFh/3wSRrHYQa0YiJjH/yG8Ziupljh3a/It+kdAjyhfCIZMSn1lEqeyTOMqPuETyhI/ZjrEs86BbQW8TUyl2FA5mbq66tOV0tX1zikUmcFnWJcy8pas0QkywCLofjGaoooFV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1840;
x-ms-traffictypediagnostic: VI1PR0401MB1840:
x-microsoft-antispam-prvs: <VI1PR0401MB184036B3C673B97A8B6C6BB097B30@VI1PR0401MB1840.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB1840;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1840;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(5250100002)(2906002)(6506007)(3660700001)(3280700002)(66066001)(3846002)(68736007)(446003)(6512007)(99286004)(105586002)(53936002)(81166006)(8936002)(81156014)(31686004)(8676002)(2900100001)(76176011)(2501003)(6116002)(106356001)(305945005)(7736002)(36756003)(39060400002)(4326008)(97736004)(478600001)(25786009)(5660300001)(316002)(14454004)(6436002)(54906003)(86362001)(6246003)(110136005)(2616005)(53546011)(26005)(476003)(486006)(31696002)(186003)(229853002)(102836004)(11346002)(44832011)(6486002)(71600200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1840;H:VI1PR0401MB2221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FY7bFh0qObyUdXFClYir+G8W4Z0k1AYLAwKFSFB17wyS9R9g9JG14a49p5aOXxLKc+18IYg9jC1uX1hOgTJ3qv63YfMJ47hhbh2B2lYa03OkSsu0hhFRNwXaSoPmitjXFJmMQKYudwtH4QGK2gnqtSZpNaPOwmzhG0b3DJ+LSxZI7acx9uX71y4lDL3ULmqm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6FB1C7FC0942C489754DAA825075C2D@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7d675165-ccfb-417f-9b5b-08d5a1899a84
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d675165-ccfb-417f-9b5b-08d5a1899a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 21:57:51.6985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1840
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3DLw3AZ028004



On 03/04/2018 02:06 PM, Stefan Agner wrote:
> Document newly supported device tree properties nand-ecc-strength/
> nand-ecc-step-size to specify ECC strength/size.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   Documentation/devicetree/bindings/mtd/gpmi-nand.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> index b289ef3c1b7e..393588385c6e 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> @@ -47,6 +47,11 @@ Optional properties:
>                          partitions written from Linux with this feature
>                          turned on may not be accessible by the BootROM
>                          code.
> +  - nand-ecc-strength: integer representing the number of bits to correct
> +                       per ECC step. Needs to be a multiple of 2.
> +  - nand-ecc-step-size: integer representing the number of data bytes
> +                       that are covered by a single ECC step. The driver
> +                       supports 512 and 1024.
>   
>   The device tree may optionally contain sub-nodes describing partitions of the
>   address space. See partition.txt for more detail.
> 

Acked-by: Han Xu <han.xu@nxp.com>
