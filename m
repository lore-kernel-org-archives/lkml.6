Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755055AbeBOHpW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 02:45:22 -0500
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:18976
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755032AbeBOHpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 02:45:19 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: caam: Delete an error message for a failed
 memory allocation in seven functions
Thread-Topic: [PATCH 1/2] crypto: caam: Delete an error message for a failed
 memory allocation in seven functions
Thread-Index: AQHTpcINkL6pgU8O6k+4QE4YgU4KfQ==
Date: Thu, 15 Feb 2018 07:45:12 +0000
Message-ID: <VI1PR0402MB334251AFB6F45F48F0A5C32898F40@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <9a9a602d-93da-457d-c37d-2acbb4b7b5d5@users.sourceforge.net>
 <594d974d-577d-353d-9e99-4f98ad911cb4@users.sourceforge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2704;6:+k0u8BYwxg54MQjO4wWUV2MLsgLJ/Qd0vMsc0AvFb2N3OydVH40iBKrloQH8IEeTu2NVphLx6Um8KKW5qxTSadKehP2CbQexkrbwEK8CXiYDciPziPjqO7/n8Lhhi7umKse29cBh5qV6Gm045XMo1C3cgTQ7z9DI19mIjT9bufJta+k9WEsHg250pOEExCWbm/83q2wXZCGTUhZd7XcmQ3tMepoOxOj7bPy1vrBEpL1Z8Jow9JfXsGb356rm+hqhEVHUplms8+ZFpOQexe2agYEke4bGSs1CGEPqQ6z3dfFQ4Wjjl+lnbVDO+qRkIZNWu3XWsN6eVMDFIdKCuyP9hoSQ90H3I2QlMxbXZDExjy2jDJap01YVOtNoxmmPUTW0;5:z4ti/Qr+mjxhXm1Hzgudi/4sVsnGb4y7GBX43sT2pnHnAtfONAvaub+UeW8C1WmFjyp4PT/0I3kI//EVH3LrIKAyxbC+IEoIxTYswfEtJk11j9kfKCrMiE50hS2f1PXgXUrLc14p+3y+Oa8lU+wwrH9ZYKiW59hI+cp6Jg2KETE=;24:d32KBeU7TyXdKaGHokuW5QTipOHaEaEBAfZvImt2HESoL0xNQ8MOQb/Wn3fqD3t/gO3u6JMLEkzzAvCjA43B3uTcZ/42Vl7SsPyp8cCPbqk=;7:idMhqd7Fi79xeNzRFhGk37t5lN0Zv1dTZaM6pNB8HBBJEpVMa/5BESWcP8zwOC+kUy+ObvihBRz39URcCPryoOtyEMwnk/I6wyFZGHeSQplhvldr1KniaHXolmDaHZPJcEP49wDGBbpR9mUoIE1DhOjFX629p+kZbGI0DqQNDSgbtijSkgIFY9AIguJGvf7m8cbHkt6LzxFjxO+M/wmTi9Dpleo6vyu6Hrp3FR/ISGVkKylaKTLQ3Rvd3AdCVJJ/
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(199004)(189003)(3660700001)(14454004)(25786009)(5660300001)(2501003)(3280700002)(105586002)(76176011)(229853002)(3846002)(6116002)(81156014)(81166006)(8936002)(2900100001)(8676002)(86362001)(4326008)(7696005)(15650500001)(478600001)(99286004)(97736004)(33656002)(55016002)(6246003)(53936002)(305945005)(6436002)(68736007)(9686003)(66066001)(74316002)(5250100002)(186003)(54906003)(316002)(7736002)(59450400001)(106356001)(110136005)(53546011)(6506007)(102836004)(2906002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2704;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8fb3d49-4fa7-4dac-e55b-08d574480b8c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB2704;
x-ms-traffictypediagnostic: VI1PR0402MB2704:
x-microsoft-antispam-prvs: <VI1PR0402MB270425160450DA9026DBA72698F40@VI1PR0402MB2704.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(42262312472803);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0402MB2704;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2704;
x-forefront-prvs: 058441C12A
x-microsoft-antispam-message-info: 1sCQDPXBoJYI5jyObiQSHc72/6BvtjYOM5WlFJ+OKsBOT63sH/OXEoNj3MJg6qOgv5gTSH7FC3assrnhD8YQqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fb3d49-4fa7-4dac-e55b-08d574480b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2018 07:45:12.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2704
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1F7jQwX026710

On 2/14/2018 8:31 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Feb 2018 18:22:38 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Horia Geantã <horia.geanta@nxp.com>

though please consider the following

> @@ -689,10 +687,8 @@ static struct ahash_edesc *ahash_edesc_alloc(struct caam_hash_ctx *ctx,
>  	unsigned int sg_size = sg_num * sizeof(struct sec4_sg_entry);
>  
>  	edesc = kzalloc(sizeof(*edesc) + sg_size, GFP_DMA | flags);
> -	if (!edesc) {
> -		dev_err(ctx->jrdev, "could not allocate extended descriptor\n");
> +	if (!edesc)
>  		return NULL;
> -	}
>  
With this change, ctx parameter is no longer used in ahash_edesc_alloc().
Either here on in a different patch the function should be updated.

Thanks,
Horia
