Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032559AbeBNQ2o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:28:44 -0500
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:48960
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032444AbeBNQ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:28:41 -0500
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
Subject: Re: [PATCH 2/2] mtd: nand: gpmi: add support for specific ECC
 strength
Thread-Topic: [PATCH 2/2] mtd: nand: gpmi: add support for specific ECC
 strength
Thread-Index: AQHTn3GUbk+2oAMyxkafCnu56MqD3aOkIwSA
Date: Wed, 14 Feb 2018 16:28:36 +0000
Message-ID: <2f28681f-c261-31f7-9f93-602f50109343@nxp.com>
References: <20180206174021.5947-1-stefan@agner.ch>
 <20180206174021.5947-2-stefan@agner.ch>
In-Reply-To: <20180206174021.5947-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [192.88.168.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2383;7:nb2ZHqhdLyT0kB3rl94jncLkV0so7gqJ1ddRTSDmOGjDhFOM9plNeAcH37SwX3X9mu/IYXPUG92hHOFsxUEOJlAhrNPvnrLptgPo05g5TcM2avTshwxIhwIJyxbKCO5jR1Pii1IVDx4abaodD7w0ImRvBkkuz6k5j7vaAWKORWs34tDLSYtBlqQOuY1uPcLdRAb6QDVcoSlyHUpnyfhdpjHeWx5A7DqMpTIKo/9HcCEI+zvkgu7CCZohoXwF4iBx
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 478ccdcf-bc2b-45f0-9323-08d573c80016
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0401MB2383;
x-ms-traffictypediagnostic: VI1PR0401MB2383:
x-microsoft-antispam-prvs: <VI1PR0401MB2383C888418349307AE8BEB197F50@VI1PR0401MB2383.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0401MB2383;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2383;
x-forefront-prvs: 0583A86C08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(39380400002)(199004)(189003)(2906002)(5660300001)(25786009)(26005)(39060400002)(6116002)(3280700002)(53546011)(3846002)(102836004)(106356001)(6506007)(2900100001)(7736002)(8936002)(305945005)(31686004)(36756003)(2950100002)(6246003)(3660700001)(105586002)(81166006)(81156014)(31696002)(8676002)(478600001)(4326008)(76176011)(6512007)(229853002)(6486002)(14454004)(5250100002)(2501003)(53936002)(66066001)(86362001)(99286004)(316002)(6436002)(186003)(110136005)(97736004)(68736007)(54906003)(71600200001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2383;H:VI1PR0401MB2221.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 1HRW8u3bnRQxp2Cq09l5pxFoQkxcTuu1TANgUbQX7pePuPOBFlgGx4EqIbs+jXy192uqOSl/OwUGvXSyixd+Bg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB1983446AB00C4F96B6F66C2101EBC9@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478ccdcf-bc2b-45f0-9323-08d573c80016
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2018 16:28:36.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2383
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1EGSsmv032570



On 02/06/2018 11:40 AM, Stefan Agner wrote:
> Add support for specified ECC strength/size using device tree
> properties nand-ecc-strength/nand-ecc-step-size.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   .../devicetree/bindings/mtd/gpmi-nand.txt          |  5 ++++
>   drivers/mtd/nand/gpmi-nand/gpmi-nand.c             | 29 ++++++++++++++--------
>   2 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> index eb2d9919d063..ea6e9b735160 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
> @@ -46,6 +46,11 @@ Optional properties:
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
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 50f8d4a1b983..8cb378358e11 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -198,17 +198,15 @@ static inline bool gpmi_check_ecc(struct gpmi_nand_data *this)
>    *
>    * We may have available oob space in this case.
>    */
> -static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
> +static int set_geometry_by_ecc_info(struct gpmi_nand_data *this,
> +			unsigned int ecc_strength, unsigned int ecc_step)
>   {
>   	struct bch_geometry *geo = &this->bch_geometry;
>   	struct nand_chip *chip = &this->nand;
>   	struct mtd_info *mtd = nand_to_mtd(chip);
>   	unsigned int block_mark_bit_offset;
>   
> -	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
> -		return -EINVAL;
> -
> -	switch (chip->ecc_step_ds) {
> +	switch (ecc_step) {
>   	case SZ_512:
>   		geo->gf_len = 13;
>   		break;
> @@ -221,8 +219,8 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>   			chip->ecc_strength_ds, chip->ecc_step_ds);
>   		return -EINVAL;
>   	}
> -	geo->ecc_chunk_size = chip->ecc_step_ds;
> -	geo->ecc_strength = round_up(chip->ecc_strength_ds, 2);
> +	geo->ecc_chunk_size = ecc_step;
> +	geo->ecc_strength = round_up(ecc_strength, 2);
>   	if (!gpmi_check_ecc(this))
>   		return -EINVAL;
>   
> @@ -230,7 +228,7 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>   	if (geo->ecc_chunk_size < mtd->oobsize) {
>   		dev_err(this->dev,
>   			"unsupported nand chip. ecc size: %d, oob size : %d\n",
> -			chip->ecc_step_ds, mtd->oobsize);
> +			ecc_step, mtd->oobsize);
>   		return -EINVAL;
>   	}
>   
> @@ -423,9 +421,20 @@ static int legacy_set_geometry(struct gpmi_nand_data *this)
>   
>   int common_nfc_set_geometry(struct gpmi_nand_data *this)
>   {
> +	struct nand_chip *chip = &this->nand;
> +
> +	if (chip->ecc.strength > 0 && chip->ecc.size > 0)
> +		return set_geometry_by_ecc_info(this, chip->ecc.strength,
> +						chip->ecc.size);
> +

I was wondering how to keep, let's say u-boot, and kernel ecc setting 
aligned, if users can specify the strength and step_ds in DT? Did u-boot 
enable to get these parameters from DT?
>   	if ((of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
> -				|| legacy_set_geometry(this))
> -		return set_geometry_by_ecc_info(this);
> +				|| legacy_set_geometry(this)) {
> +		if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
> +			return -EINVAL;
> +
> +		return set_geometry_by_ecc_info(this, chip->ecc_strength_ds,
> +						chip->ecc_step_ds);
> +	}
>   
>   	return 0;
>   }
