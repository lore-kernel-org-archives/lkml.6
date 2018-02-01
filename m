Return-Path: <Michael.Hennerich@analog.com>
X-Google-Smtp-Source: AH8x226o5ZpSJu8FO9IFFghUTEFRmtO4stKH+9eo78lF9hYvnQ1+reBJe/39yMThVNjDpaMNZJDN
ARC-Seal: i=1; a=rsa-sha256; t=1517502336; cv=none;
        d=google.com; s=arc-20160816;
        b=uOR5KFLHfAx/opWGmBZzhE4mVDoeTQDtc7q5NqzxPVrv4yt/gJKfTrHhzuBJdcNVh0
         tn/6+9wluXsEFymPlcDa6Ny76bunv0JmxFTglpiA5HFoEUNg5QU3aZxGVT0b+YkQvtqw
         Dmzo9Tx5tpwcAQ8iwCii4pzhca5bWAmRI+o96NvF5ueUZUcAnt5nt0XejhLUQtl8a5ht
         9S6zZaLpZ4aw4KfgAoh7mn6Mm4jfiNr8HYz2MgCmjmQfnzHR+Ybr0F1RxW1F7FJ6EgxG
         kgVbvbzaFnZU1GsrOBtIb9Oe0I/2a9Q5DdAl5AJJ98W9VhdcK4ypkV3XEiA6OVJFeDO0
         SyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:dkim-signature:arc-authentication-results;
        bh=xIQfD9MHvxn963JZpSLwzp+OmB2tooEIAYdXrPuT0mo=;
        b=vWrC9iWw91UwxfpIAA1d0Du4j0GQJAVVR8dDqEFEeIAWp4izBLtlVlomxKrJhXHfjE
         bAmH1g06Ugm1gmiHQ32whzh8eyjcftZb0/aCa+O0uhi4eyG0b9efg+2zNBDy04sm14dX
         YTcOC86ijx/TX/X/pZkUnpB4sVTY7CwRQ251Kyz4j46wtLM3YeX0d2mxl64m8yTSA6FK
         MKGG22unTbwyrMgq3tnKile+ntBqRUQpzgVTGbY6GBU9uz/PhJtcQ/ucBKVq+yzPmpsL
         nuqLjz+9u2Zz6BNLrUT2QJXz6qMpcU5Zid2eqZVVBnBj/yuJb6+A7JDgRax2Q93gYCb3
         7DXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=VEsJ33iI;
       spf=pass (google.com: domain of michael.hennerich@analog.com designates 104.47.38.88 as permitted sender) smtp.mailfrom=Michael.Hennerich@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=VEsJ33iI;
       spf=pass (google.com: domain of michael.hennerich@analog.com designates 104.47.38.88 as permitted sender) smtp.mailfrom=Michael.Hennerich@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH 5/5] backlight: adp8860: document sysfs attributes
To: Aishwarya Pant <aishpant@gmail.com>, Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han
	<jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	<dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
References: <cover.1516978005.git.aishpant@gmail.com>
 <c7c9c2b13698320b590b52b7bf5796a87df49bd5.1516978005.git.aishpant@gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <aedcd1c4-45df-b3e7-c6d1-ca4085df9b7d@analog.com>
Date: Thu, 1 Feb 2018 17:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c7c9c2b13698320b590b52b7bf5796a87df49bd5.1516978005.git.aishpant@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(39860400002)(376002)(2980300002)(438002)(50944005)(189003)(199004)(47776003)(3450700001)(7636002)(106466001)(4326008)(2870700001)(2950100002)(86362001)(65826007)(356003)(5660300001)(229853002)(77096007)(64126003)(2201001)(186003)(50466002)(65956001)(246002)(305945005)(8936002)(336011)(8676002)(26005)(478600001)(23676004)(2486003)(316002)(110136005)(53546011)(58126008)(36916002)(31696002)(36756003)(43066004)(76176011)(67846002)(72206003)(106002)(7416002)(31686004)(6246003)(2906002)(83506002)(39060400002)(65806001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2718;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD042;1:66r19Wrw8jwfLgAv8VjINU0ecanqKkqC5If9mnkVpXEe6m5CmbHaGZpQZ16fcu157d/sdfHnNaczoSJDT0Df7iwYitGLz1zA5kVrpy+nisNiuOgZzaVITP13ZY4jGvIS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 164f5218-793d-4cb1-bfd8-08d569906a96
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:MWHPR03MB2718;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;3:i3pwBpYMvFkGrgxEtXF+ICr9BGfceTjpe47RBZ6mnjnBHt6FFLlDqTLwc8/eZvct2yHy460C+8bqD3B1QWPEPgUkrotVXiU1zQTHf9LymzTDWJWHXwd3RaqiWtR9LpNsMRrLIWNGiwQpafvJ0PmdADdM7s5jLsBv87gF5s6Sf8DSyYbfonWN+1y+SkxTiSD3jxjuxwsu2TMNG5gWCQMqZqINLzO9bImVB9UzCstsJjufH7h4xfUaPcTsVCCX2blo4/A5mFZGc8hTmJ42OyIEukNFFP6/yGP65cQ6ts9/JzeTSpD7jSRC6v01O7c2zvCw0fMgG73aqRswsbrzuo42GJU0SfnvmwvmVyT5qat9wh8=;25:NIqe8UECzfjKbC1lnVtzgqmRkIUK0+FOO2YAZpwCTeRKepHurLaPsTzyT3H9VUTta6cAVZOWt8ENlsV7SXBgWawiX14LprQrk561kuVbRo8OEtfQlNsdpCCa2x8hYeOHMEgv8ZhwnZyQAkqr2tyk+YGI5m+k2YfXlAb5KnZbuM7V8NkZcvV6w9bA0E8y82fXgbLADdW/EsX/YLBzqopR16hx56zKehKHBdcFqFfGf3kaqDYgjFNPmfSX9Qc44e4equaVkLE2uXKsNtjKwyGH4GG6MH0qb1XNHtBoX+tYgal9swM3QTrshPU62To5WIe6DkdOT749jEl4ARxD/JBu+g==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2718:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;31:FBF43400SplyOLdZ9DwmgbYA+hEmjOaXxKYxoLPLrKeNAGv0XgQDVywi7r7oQxYMnMO5H31DcJuj4gFfT+JQ9rCYb59voyV++BS/umsSj8J0DnruGpqlthgxsVUmsVDOgADnQhrgbtlNrqQP3ohSfVFhAlXC1NLjxAtFUwjMiLcOxKntSjox36ClTgKv8GKJfYY5UKrt26JWppodh3xN8ljrrTQrimPtLD3kegJhTac=;20:n+LPyphw0QvNgNVnohFWEVp5t2bwBD0Gr13fh9kC9/nJ2gBr6P8g3oNTt8qIHOQTyeXNjBDIYs2dy7ez4qB5epy6yN55T9LOn6kwB5EBfFSRDapuke0MjboKcZIlkEgFSEiH5775zOLce3q4qx4xj9G7pNf0lbdXDGxXbnM1iOl2ut+Qu75FVXSJYBIY2myaFr0WcFlMBBoHp+3h9K1NTwn4abPgUTJecwTesweGpmI2hH9PtzJohFpce4v3gww224BUYn98LMBkarg8KdNoqJvDvQ3S2G0Q2PREIh58gKmuFGuZ1CPSmAghqzJ4wTGaw+064Uap8ULnz0flqBH2dY2r2+x2eYYHD9w88sW8x0xQk6wz6pjMCwTuPRhFoTKUtmjsLOe0sdBjaIihDmdYaoOqxe/kAaiNPhtrLQmvuNHzr2sAcSkAAI0amChUfzS8NM/VQQt74FMIf4tZQe0PxqPWP2FH+YdRDt5fqGsto+F3F4yC7c+Ppa4xfyedzM+Q
X-Microsoft-Antispam-PRVS: <MWHPR03MB271884736A34607DC66B32698EFA0@MWHPR03MB2718.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR03MB2718;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2718;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;4:fzy8ANqmUuE2dr82FdQXmkDkHTtE5XDf70YQaM+mJ5sBR4Bj8kgTRYzj+1rJ+vuI1F03XJqDJmB52Ep2vsuIJ57l2TLShyPRrk8LdNdIXNajO1/eWBJksP7Dd7XDyyHuoPP3JlqU7EYgaogGy/8imEFFX1AwRipGL6FJBuai0zWM6uK2NXjf/eH1MyEABjxw7SN62n04wCotXY9lNh7zfS0ELqAiDiQ7eozNms/TEARFJC7iQnC0GKFlACPuAapULZJFzHeG+fZEus5Q7GiShFdN9MKLrdmktCtFSP9tblFuosfUZZyTIQMFfPU22Hwc8Epst5RS2oelgGFAiK+UeojQYCySRR88VhHoBUCUJsM=
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIyNzE4OzIzOm9WYmR4b1U1Z013NXB6ZzdCTnVvenFEcU9k?=
 =?utf-8?B?QWg2TDZVZmdhVnNGSzR1MGFxR25HN3pMK2l1KzR5RGpQcUgxaDYyZjlPWWVt?=
 =?utf-8?B?NzNJZ2E0MlNjSHMwSW5wRkMyS1ZlUkwveCtaZmJRMk1ia25GNkIweDFHa212?=
 =?utf-8?B?cThsVUJFbnRMTlRSWWhxakZoaDBkNTRvaThhR2Q5THNDdWhobDA2N3d0dDBN?=
 =?utf-8?B?WmlIek81dGhNRGJkVWEyeVIwbjNFUnNrVkRoVUd1TXhOd2g1ZVdEajQ4WGoy?=
 =?utf-8?B?MWc2cnRQV2NURjRrczRXakJBSVY3dDFtckRJUkFCV29CS2dKeVcvSmFLMG1B?=
 =?utf-8?B?YlpoTm1EVndtd3RoZUovSGIyT2FlVHpRbGtiMGM0SkRKS0ZoTXNxL3NKVXRu?=
 =?utf-8?B?R1UzT3IxcGdLcDRMMnFvNURBUUpZc2tpcWdmNWI0MG9TLzhkSEZmZGNqclJy?=
 =?utf-8?B?QnN1RWY1ZDNUelQ3NFBIYVVUWU56aDRYWmp2R1hqUTQ3MGRvaEJaYkVnWmVr?=
 =?utf-8?B?QytVWTEzNytiU0VaVndFZHVXZCtzZk1PSUJJTTBQM1hLeVZYZW53QnJEeEti?=
 =?utf-8?B?b3RtTDFzZEltN2NuWFNoWTNjSWhOTFdCaGdEanVZUUMzeVh2dVBSQTZoRm9n?=
 =?utf-8?B?UHpGbHFPVHBWTTc1RGJQTm5Ga0xlZXJwaFhNd05RNk9wT0RnbFVFdlpmT3hm?=
 =?utf-8?B?TWxTUjdLNHR2VFpmc0NrZDR2Zi9FSzRoUWsxRUVsMnFxRHNmbzNWMHFycWtm?=
 =?utf-8?B?WGh2OWlXVnA5alN3UzA4SU5HeEhSVkFvOGNaWHVQb3hFQUtxbldGY01KWDJ6?=
 =?utf-8?B?YXBpOGVtZmhITWdTSmtSdGdteGVnVTNvNHdCc2tDQ1llZGNDNFBpT01TYnBW?=
 =?utf-8?B?QitWcVg3b2MyYlBsWHVnRzg4ZDhWTTJYMGNscGFaV2YrRnFyYWJGeFpnTU9r?=
 =?utf-8?B?MlRnMFRpRk5PWCs3S0tDQXBzWi8yTHlZdk9iVnBrRGZzYWhETXZyM0VkbVpo?=
 =?utf-8?B?eEptZCtuQVpZZ1pSTGdrb1kyYk9hZUhhcyt2UXFsVVpmMGRra1c5NGhVY2Ir?=
 =?utf-8?B?MGZzMkxRTEVmQUtXYlN3Vm1NYlVwU0p1RzRQQWxjNXI3NDhENlVXcG4zVjdJ?=
 =?utf-8?B?bW1YazJYaUVMM3QyTyt5TXh6Q3cya3ptZGdNTVZzd0ZIYjlYbWEzU3BzLzdP?=
 =?utf-8?B?ZE5QcURxMStlc0tyYk96cXRnR3ZmQnB1U0hUV0lmUG5oalpiUmRmR2N5d2kv?=
 =?utf-8?B?YWhubkVSY2dac1I5bldweU9WaU9QVCsrV1BnZk9YUGdRTGtFQ1dsMURLcjlU?=
 =?utf-8?B?RjRoTHJxYm5YaDFLVnNrbWd3V1g2ejZERGZwZjRWcndFTXFhQmgyMXZicGxV?=
 =?utf-8?B?ZVY0eXNZWEF1WmtyNjUyajJBMmVtbUJzWUc3L3p3ZVdURWNBVCtIRGZTKzFq?=
 =?utf-8?B?LzVvcVM5dDFSa3B2eEFGMzQ0NUJ1ZkpVeGYydFRvMXM3cTdsT2lzdWVCNUNE?=
 =?utf-8?B?K3gzN1lJVWswTXpjeE1WODBCTzI3dVhwM2s4OVNJdnhWSVpuUkRLVzAyalV2?=
 =?utf-8?B?ck1tOGtVOVgvckp3ZVc4WWlRNnN2MEZFZWhlWEtxTmxtUm9CckRPbEdEZG1a?=
 =?utf-8?B?QzdrdEVyeTUrMnU1Q1FwMUtpK2tKK1BPTkVTSW5hUVprb2l5STdEcGd3S1gz?=
 =?utf-8?B?MzNaelF6T0I4N3hJcjFYRE85amtOLzFkQnc5aUdUSTdFYnFIdWhPQU90RFZQ?=
 =?utf-8?Q?3tCEjrcMTsi3+pe/R3N6RS6mbsToJOTkTHvu4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;6:vaxKLFvIrx6Ks48ZsJ83Rqljqls2js1SFybU9cB/mkLmervtz2gVT91pbRqTw3vQMOMRPoLDytB1c69NipcnlJ2DlXGCuSczXcwQjyyVlJc/Ma34pOnbTP1lk5GOYrwBUpUJSaPXKuHzJG/91oJBiFbFCJwtBv5k2cm36+iLWtprfRtmyRVr2bOuDGef5XckdlV7ecFkqe2j6wLEimCJPQiFucs0mvu3hfkbOck2QCv4KTZzos4Rn5jXrtGwzR+B1YLhzSZUNLnWwk8uvOigLvS8shSBlEACHZwbIYn5Bpz/o8baEJ23Gw3MqOdG3sGtgruqxEh/LjZ1VgevVujuFf++9BWOHXN+qDEDcsOq+ZQ=;5:NamPUrVBNg5odtx+9kmfdI/gny/M7DbEUOA2TJ4ysPY7jk9yC+hCvS6a8ofE37Boq4G4kTHyvXvTG1IuDQUnpSuJn8TBRoF6l7BkwW9RLsBvPb/LJGHvB55u/6ElSj7kucGewiAa6I2Dtg7DZxJ0MhpUBV2e9W28/NZIqxVx0gg=;24:XBpfMJNsN01KxTSXDC878gdja7shzkjxRDJHFHSEPTXsEQuVf0IeCmQCAyF2QNhDZHuJUhlY7bhWTqF4vnVShVVK1aMOOoiOlck1S80doQE=;7:pY9ddgeBLtbP40ij//RhO/B9YQOfW4lAKPVH48iuTuwI13Iz6UcuWH7Qfba/xZhWcEayxwax8GooAy6pD4RkELgGtP9lsD6MjoYh3rnjkkYVBxJ6xIg6qvVG28Ers83FfHF9gyY370mYbQ3OPwA7iIBEM2BlJmBIBWPLBByKQmfLwFKyC9mqAa5Q2SsYuLOLUpaviNYCc1cBNXSlhHxUiSlDmmPzgZWiJ2djjcmn5XMINQBmJmibdWNU+Xkz34Ei
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 16:25:28.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164f5218-793d-4cb1-bfd8-08d569906a96
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2718
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590667288861484455?=
X-GMAIL-MSGID: =?utf-8?q?1591216530295466741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26.01.2018 15:55, Aishwarya Pant wrote:
> Add documentation for sysfs interface of adp8860 series backlight
> devices by reading through code and git commits.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp8860 b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
> new file mode 100644
> index 000000000000..54d61c788b1b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
> @@ -0,0 +1,54 @@
> +sysfs interface for analog devices adp8860 backlight driver
> +-----------------------------------------------------------
> +
> +The backlight brightness control operates at three different levels for the
> +adp8860, adp8861 and adp8863 devices: daylight (level 1), office (level 2) and
> +dark (level 3). By default the brightness operates at the daylight brightness
> +level.
> +
> +What:		/sys/class/backlight/<backlight>/ambient_light_level
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RO) 13-bit conversion value for the first light sensor—high
> +		byte (Bit 12 to Bit 8). The value is updated every 80 ms (when
> +		the light sensor is enabled).
> +
> +
> +What:		/sys/class/backlight/<backlight>/ambient_light_zone
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Read or write the specific level at which the backlight
> +		operates. Value "0" enables automatic ambient light sensing, and
> +		values "1", "2" or "3" set the control to daylight, office or
> +		dark respectively.
> +
> +
> +What:		/sys/class/backlight/<backlight>/l1_daylight_max
> +What:		/sys/class/backlight/<backlight>/l2_office_max
> +What:		/sys/class/backlight/<backlight>/l3_dark_max
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Maximum current setting for the backlight when brightness
> +		is at one of the three levels (daylight, office or dark). This
> +		is an input code between 0 and 127, which is transformed to a
> +		value between 0 mA and 30 mA using linear or non-linear
> +		algorithms.
> +
> +
> +What:		/sys/class/backlight/<backlight>/l1_daylight_dim
> +What:		/sys/class/backlight/<backlight>/l2_office_dim
> +What:		/sys/class/backlight/<backlight>/l3_dark_dim
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Dim current setting for the backlight when brightness is at
> +		one of the three levels (daylight, office or dark). This is an
> +		input code between 0 and 127, which is transformed to a value
> +		between 0 mA and 30 mA using linear or non-linear algorithms.
> 
