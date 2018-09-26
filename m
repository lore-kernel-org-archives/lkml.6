Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BBAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0520684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iBcHKYSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F0520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIZU6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:58:18 -0400
Received: from mail-he1eur01on0124.outbound.protection.outlook.com ([104.47.0.124]:32054
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbeIZU6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGmCXGTresXNn3QJyG/SLza5pNGgprryxaX6WvA+Ddc=;
 b=iBcHKYSprRvsOP5dFCNY+daSCoBKWtd+z1q0gA+U1dsPGGWEAkzjBmJAelVqy67wZFmF+zh8+Uu+ItK3UHxjsi0tv6cVccYhSTWYyXzlcYEi8x2pF2twBpj1vZYIat1+T1kJsFRQAGHPB7tnUARXP/jE6J0q4RTwk7tn0p9EwT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 14:44:54 +0000
Subject: Re: [PATCH 1/2] dt-bindings: i2c-omap: Add new compatible for AM654
 SoCs
To:     Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180926115751.20421-1-vigneshr@ti.com>
 <20180926115751.20421-2-vigneshr@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c3421929-1c40-513a-5c14-73e132a11d0f@axentia.se>
Date:   Wed, 26 Sep 2018 16:44:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926115751.20421-2-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::16) To HE1PR0201MB2459.eurprd02.prod.outlook.com
 (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026fb351-6a5a-4ef4-8712-08d623be9f81
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:W+dGF/UgBNAdHdypRtVjDtikx3yK0OuNz6pOH+ZZFUw4KKu4ZFhk6gjx3uotM/kjmJttk7ZkpVsJciM6AZLIJ7bA9qOcD7BPTwjjeR4TO+SX2yAc/o2HI4C6uyNmcK2P0Wa149djK8EQ2IV1nER/e+chDODMC+ZdrZGRWCaYH0GO7MmxWjwiezcG6YhJoweRiPq5AdTrhyR/j0/ilb+nUbhU/5Nl9pHFhJd9y0EqykmqG+Mte8X3ANs0+JBWvECw;25:CA7+Dar3i3BKjJ0c3ck/FfqaErxQEL+vs6U/X+izgWvlPMSG6fnPq5VvSHKMIhgXlJtkRQLTVZEqSI9Gm+2wlYAMSN4i/MiatESk6gpvKym3kZcFpebK9UnBJwxtdrH1YqE5ouL/wKAbSfKHMSA4Geuyf702owKZFRhE0VdGUOIXHd2cPBoadc+J7elGmWEgf0dbaKV0kk6g/2CG/3h8Z9ZutRpTUw8ErF4QUKUyR4XTjLUI9ha92zBBYaYrU5tbQUhXPvFbOFsBarFwo0U6ESUSh55sw0g3L6zNPcP0NXFWgNPZcICSZ2S8juGhIZ33DDDa83JjttPeB0KKk7/FhA==;31:+boDQgUwlA092CUE+mRm5jUvUU7QOKCtSSGI4VDFYhQyumMHgJPc+q4uVbB82XbK4ujJ6DRotZ+NG3KRFbqDfU+qFwSeCnYs0u1PcSI70BeSN5C53fT+DEUZByLo6IG83DmSPd0HbZihCvTpKIBFHC9M52fCe2+gdhzfWXDfbBBP2DDlItuh0Mf/06b4y7pfiQKxzgfXpY0/FxH7+bexXkRZQZkRjQxDLAXO82LFacw=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2459A6A2148CDCC25BB0B600BC150@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:21w8mZpOrIjupA//hF6MW/ljcYpywC+/ofXeHDamU1kpt3wDvcF3cMOsldmyuOl7OstR+pPC6FJ/7vQEgPJfcUwcB2Pe8En2YOtnhkOw/QawRFfbwXwIKQxdKSw2tmVKEOMXPM2C/q5xu5lrVzjVuJzHVznIKZAWbEgKkAxrK9flwjrjv+10iz6BWPdMQZeBF36QHZvGkbMRswn7zPNvAqUtPEVsCXcLUcrlfK7K1wF8LgM9G9maaB7n3lW6LK/DBFoyhMxv+CbLumBpuT/I/ITk0b3iUSlrFOFr4dm9ri0COwFzGx3Evv8N4KziSf2U
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(6029001)(396003)(39830400003)(366004)(376002)(136003)(346002)(199004)(189003)(66066001)(65806001)(36756003)(53546011)(65956001)(2906002)(16526019)(64126003)(386003)(50466002)(476003)(26005)(53936002)(25786009)(6486002)(3260700006)(47776003)(31686004)(229853002)(186003)(446003)(6246003)(105586002)(52116002)(956004)(77096007)(14444005)(76176011)(34290500001)(52146003)(486006)(23676004)(36916002)(2616005)(2486003)(106356001)(11346002)(4326008)(7416002)(8676002)(8936002)(74482002)(16576012)(5660300001)(316002)(7736002)(6116002)(3846002)(230700001)(305945005)(117156002)(58126008)(508600001)(31696002)(65826007)(110136005)(97736004)(86362001)(81166006)(81156014)(54906003)(68736007)(6666003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTk7MjM6VjlxbzhpNHVtcU1wdmRBcmxIQ0JiOWc0?=
 =?utf-8?B?NG42M3BHYm9aRmFiRi9zMncwaWdtaEMyL3R1NFpCNjVYNzlUUW5nVStvNTVB?=
 =?utf-8?B?WW9obk95T2ZXb2ZVTmo5ZVRYWGxoSWdab24yeWxiOWNBMVRJN2ZhcnJJK0lQ?=
 =?utf-8?B?N1hpa2xjUmcyZDBtOGk0NzFpVjlleXZtMGo5ZVgrZnR0SWZWR3hzaUxGKzMy?=
 =?utf-8?B?R2d3T0VGOEdjWWIwWjZkV1RlZGZPRm41UFVlOXJYdHN5M28yTGIzNERSYnIy?=
 =?utf-8?B?eXA5aDc2YWdqWWJiYU1kNm1TN0tIdTBIWGcrWVI0UkhIMW1DZ1dzYWg1Nnd3?=
 =?utf-8?B?ZG1SZHZTb2VhYnV6SzFNK1NCYW9qckNzUjMydDZKR0p5NmJhdGRrOGl5Sm9z?=
 =?utf-8?B?YUdtaFU2Y3Bod2o5MHJMNzBidkQxYXBpL21MQTN5M3VZWGVnbldtY3dYblVi?=
 =?utf-8?B?OVV5bGVXTFF6WUd2U1h0NkNiZlR2UDJnVmVXNkYzN1VreGZnTk5Ua0lDQita?=
 =?utf-8?B?OHE2OTFkU1lRQjM0M1VTV1VDWkRMN1g1VERrTUJpTjNmZmQ2OVNtdWxGQ1N0?=
 =?utf-8?B?aHRpVUlvRWkwdmZjaFpNcUNRbVAvWUtaUTN6bjltWmovYTRzMEQ4TzFTU3BI?=
 =?utf-8?B?cnpVZWpaanZDa2UreXZYK1YrWHZ3S0tENHFiNVZvTDdLK04wc3BReUo4d2xa?=
 =?utf-8?B?ZS93aGxXbnpNRURqYlZBclhoMFFQR3FkbHUxOUZwMmppcGJvOFc4Q2RGWk9G?=
 =?utf-8?B?NmZiRS96djB6U1ZMekxhT0MwT1ZnRmMzTzFCOVRPQUtQVlNXZUJ0b0loUlB3?=
 =?utf-8?B?d0w1TmpublhwQTVRT2xkcWQrdkhxTTE1WE5hdGZ6bng3WDhXb0lNcURsTmdO?=
 =?utf-8?B?SEsrUzdDUmJGYmNoL2MyUVFHeUNMLzN2Y0lSL2xWWm5BMGUvekFPZklGaWZU?=
 =?utf-8?B?ZDNvaXFFSzV6V2x1QnJYTHp0djFlVWpJMTk0cjVocnI5QW5kTkZSNjl6RnFC?=
 =?utf-8?B?R2ZocnZTL0xGU3Flc2hwczFtNXErSW0zNmhXM0JnS0w3aXhHajU1cDlJQWY0?=
 =?utf-8?B?dDFpY1hWMmthLzNCVnRULzFLY0JOSzY1WEYvSk9wL212MDlxSUttclJaL1Vq?=
 =?utf-8?B?M1JyL2ZlU3VlZE8yc2VUTVdUNTJWcHcxRGFqbGpxRVRjRVZsK0VodjZZM08y?=
 =?utf-8?B?NkNKL2RiY0FIc0ZWcTlESkNYRUVqUWt5R25QL08vMTR5L2xIcUY4c0hyYWoz?=
 =?utf-8?B?T2V6OUdmeHE4bDdZN2I0SmhZTDVOQmo5ZDhBcVNhK1hLOUdzY003WDlDWTlZ?=
 =?utf-8?B?ckVYTFJ6K0RHT3RDSEZoTWprV2dpYzhXNXFrTkFoSVM4b1JVb1BlblovTHNH?=
 =?utf-8?B?eXFibW1kRDkzc3NTZCtPT0tTM1ZpaHBoUEZBSWUyR21heGFuMVllVVdNK3Mz?=
 =?utf-8?B?YjhFU0VYdWhSMHNMYkcwdzRIL0hSK3BxOC9LN2xqa1d5SldXUGZzbkdteUpI?=
 =?utf-8?B?RmhlUi93N3Bzb1hvVytubXVPR2RZT1BvZWxjOGljU2lVTCtFbDFGYlNCVDZX?=
 =?utf-8?B?dW4rSVdmWW83Vnd5MldWUEVCWXFtZEpPNUtaRjVoV2poWGhsSWd2TlNPZ1o5?=
 =?utf-8?B?akNrOEd3SE9QNkdXMU0wbjlCazJ1SnhaY1F1RytDaGgyVVBJUEcrdmtvMTQv?=
 =?utf-8?B?ZUo3M3Q0cU90MktEdUZDK0M5OWkrUTg1M1I4RzN1SThlMTZ3aTZpZWR6aGdk?=
 =?utf-8?B?WWxSalV5Uzh3czJ1RXV4QXRpQU5hZVhoT1p2bDVqeGNNTTB0R1JDM092QmdS?=
 =?utf-8?B?S0lLMFNqaVRtQ2VWNnpxMS8xRGQzNktWT2ZWajFQUmQ3L1BNTHlnQVpEcGpE?=
 =?utf-8?B?bEJXaENDRkxHQTRQNWlWOS9UV2Myb1BLV3BLQjkreW9aWFA3cno2clNPZlVH?=
 =?utf-8?B?bDhHQTZIR0s4b1orMVFXNDRvVnJkNkV2aEk4K29GanlTNDR0aDQ1RUwvcC93?=
 =?utf-8?B?TDNzdFlDa1NFOEhKRjJFWEhIQmZia1NNNlNEVnhlNWJwdlRZOXM5TlVQeTNF?=
 =?utf-8?B?L0N1YmFORms0WTNJVFpSejlyRDg3Z25DaFN1eU0ybVZVRHE3YnBtemhPeUF1?=
 =?utf-8?B?Y3g2cXNOY09TZ2tpanBwTk5BNFlWUEdHeEN1N2pjNnRFbytpUTU1cVNwMjdE?=
 =?utf-8?B?Z0Y2UGhVOTg2UXRDbXc4bTJIbGpzSGc9PQ==?=
X-Microsoft-Antispam-Message-Info: fAELlYzb6oS8Z+jdf7mbyaNoSuCeroVUe70lXTeP9RWS9PMIyUH/dT4gO8uh9/ViXxwa1nZC1MA7IOCpujjnZyzMLpf0rGZFvpfvIHKRMZx/1rQIF9qnE+ZUgAkWWARyJZnNL5VXNs7mP5JfMf+f6TnqVo9Nthm8O3C4hQ/7iFFxqCHzztmxNQlyeI4Z169RPJ18KOYFzJwd2dK6gkGeSh5IicSiAvE6yD7IaOmHcKQVdr8LzgWO289JtsYiaWHY7hIqzd5nJ4ye/1VSxPQ4HtPmaP73quVshVyArp+0kcSqJp8Lbw9tK0RBrCLuJ+iMBIlkD32aTbe0d27Ul6eAkxRW7Zsh4+19CLCa4pNfZhI=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:KiRMb2C3Nm0248U9ASThqjgthpcY6sP9CZC5dMtJcmPTWCGnFxrGMqIjY1x/lUXHrgNaZDGjmOiob4OtXHMwBNFDrAr+JBVP/PQ8l0v/gtaXPlYja+7xnO5iaduitcjc2asqS8M8gspGkZXTWLMsTVWGzp7NAZLd4QhaVJNwwZSQTMdLKVfOhCl2PHPee+zZWNo6dKtPn5o04I0Wak65f2RXcpCjhtOkUeUlIDlEtspjKh5FtYppc671vl8Tg1camQ+intK/o+tKGOUZEKrCdQasvaHButM0gGyKmYYi51cdSkGUxwyLMiw4ufXrcySIs0n9Lvy28xzhndTVWHuAEQRaZp/zG8kiiz1+z96cWuVpMcMr6hjRcXAE2I9igACF/mDj0j9dZNB5KJV1oqmbwawjuQbAkvHNGwlitGwnQ/ScmJshfQR8n3axPQ/dDD3qAxsLOYO5qGsihh7+Kr4ZiA==;5:MmRIAHaMGCvs/1yIMpK9vkCTelQWJUOG+HGjmFoWPCWcQA5XlQ79mRdRTrFDYOR0LfTfMu8K9UZ+l8WDbE/zpiyh0uDiF3IFztjL76NV6rw01C+P9ZRdwrQ+ydQFYImSofcT6xYK5cCi5YkKJOkZEIUEjS7wrLxDYYHYrapabRc=;7:XEX7aplVNhp3oYmNxu/WZj/6LtbXBjvILmQH1zJWhGymrL1UuWeUwESzK17D9b5KHNzVGFybcdrWT3tiOA1hCx0i4aFPlfs6zatuyhA2AF73quLfOUbTGptlJG84+NfRPcPvDNnpKU94otnzdr/tqUZBoyT69KpGaR/VnG+QX01Leafh/QnUlsU+4KRR39Wv5EpjipGmih4hqJ7dr8YM7Z76M/zIt3etk4phvjdSm9r7Ov9xrxOdeCCZ6+ixhG3N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 14:44:54.3095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026fb351-6a5a-4ef4-8712-08d623be9f81
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 13:57, Vignesh R wrote:
> AM654 SoCs have similar I2C IP as OMAP SoCs. Add new compatible to
> handle AM654 SoCs.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> index 7e49839d4124..11ce869d682d 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> @@ -2,7 +2,8 @@ I2C for OMAP platforms
>  
>  Required properties :
>  - compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
> -  or "ti,omap4-i2c"
> +  or "ti,omap4-i2c" for OMAP2+ SoCs
> +- compatible : Must "ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
                      ^
                     be

Also, it looks bad with two 'compatible' entries in the properties list.
I think the trend is to list one valid compatible (plus fallbacks)
per line. So, you should consider reformatting, possibly like so:

- compatible : Must be one of
	"ti,omap2420-i2c"
	"ti,omap2430-i2c"
	"ti,omap3-i2c"
        "ti,omap4-i2c"
	"ti,am654-i2c", "ti,omap4-i2c"

Cheers,
Peter

>  - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
>  - #address-cells = <1>;
>  - #size-cells = <0>;
> 

