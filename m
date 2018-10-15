Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04EC20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cGzldDiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04EC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeJOU5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:57:15 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:1152
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeJOU5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EomwRWeQ8mQrHHye5Th6qh2Xxs7TT9FyPBJW9qiPMUo=;
 b=cGzldDiMmcw045fMDkZLCNALsUw3a8ywkuxQfZCKhv1P5QsaVhKbqTE/yJCP5Z1ANpmokZo5VycqaobiLENT6X4/atZEh2s3u2DKt01pBF9euSz3XjSeYBKt2LP2JJhkPIkkftHsC6JNQO7nYTOxN4LtzufEfkFdeqCOVdcR7bM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robin.Murphy@arm.com; 
Received: from [10.1.196.75] (217.140.106.50) by
 AM0PR08MB3090.eurprd08.prod.outlook.com (2603:10a6:208:5c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 13:11:54 +0000
Subject: Re: [PATCH 3/4] dt-bindings: iommu/arm, smmu: add compatible string
 for Marvell
To:     hannah@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com,
        corbet@lwn.net, joro@8bytes.org, robh+dt@kernel.org,
        gregory.clement@bootlin.com, mark.rutland@arm.com,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        omrii@marvell.com, linux-kernel@vger.kernel.org,
        nadavh@marvell.com, iommu@lists.linux-foundation.org,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        nd@arm.com
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-4-git-send-email-hannah@marvell.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com>
Date:   Mon, 15 Oct 2018 14:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539604846-21151-4-git-send-email-hannah@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: CWXP265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::25) To AM0PR08MB3090.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c754771-267c-419a-2c09-08d6329fc763
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3090;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3090;3:Bjven1nlELwA7nmfhn2F1B8KJGST8qZCiXwk/d0AKQz3ufHoSOaA3+guZYYdl9as+BM4G+9MrvtiFlQuqQoIpjk9ZTspMqMy0Xd94N/2H9qxoz3tb8EwvCtDxoT+LBB6loIMV2IWLNWyHs3HUW27YmmEDyzYyEUEAN5zj2aXZ7iAYoVkQwEgMGK2qEGYIOcdekFUFldDUgoa3NXxl7NkArnYLzbAkvxrgJRYigaKK9L04tuScsRE/0Yh0NdywjvL;25:049MUpw0TEcosm0/TyfPc5aKMOneHOxARkMppmaUAXLR8kSU2/eg2IoLi9IjnbPZlg64zla48DSjaO2BzC8liQP99cfVYjJ+4ZfbgaWnv4BtKSi6Ya1mDukQttwZ9SikrHVYn9VyborsMvNkJnG34Vfw0Zh5yKFGMzRV5OyUzgC75z9y0DtaZWiUjIbNOw1rXLXOUKCiFv3Ro9ha6dsJzJrDijfHrm1RduZEe8t0pbpRcGA/3BLyC0YYdfON//g8orEBgGO/91uFGtriYk8CN8El2q8RObGfJFABoozMuzTyZT5mPaUYy1gq4kHfGoe+sA37g8NRruwsPp9/yUTnfg==;31:en1E/G/2/9P+As6BcSOrBzOZl62+W345pbfJHbJHnMGEfj/BkDBP9lCopGIqOew2s4Zfgq7huoc9S9QO5b2CnC9wxLtN/oJBs/ZmZNQC/6xGpTOeK/Z3+Lpc3BgeEFDVxuJdleLwIfHkV7zvFKl79x8x8Z1q5UPdRz+VNyCsxqTqEmFX8Qg8AaqoqkytxsjmA//VZ/nkL7APPy6EGCcV9EidpIBeyQbWrDoIHoKEgw8=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3090:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3090;20:NF5Ds2PrsK1UFo10vEZitT4RISo0haGiEkJSXdlkNMcJdh1Ulk24+Iafxe0aNgQVpvBtCNeTcorWFZ8ebHOhIfdxoPm5PvKYqeIkMJP7NGG1zh1wWRHB06yBO4TAYeD/f6vQJ3lpy5uxPAz6ay/H73drk2urmgvuukSJv8SkByYGH9Hq++G7+JQ4+UuoCFJL2K0baM1g82E49AV6TbhZmnKpRHOXPKXbbx0pFKlPwG3UYbByTnZndnp10+W98yymTs9ZDI2Ps0yfSJo6SHv4vW39OsHDzxeKXpGCzvBHriatiKoSE0Vkp+LM8NOeYf12COFrsuO6mWOfUzRdw2z/UuhOhJugJrOxBlWUOcBXyxjqbA55CjNIx3Q7WTVR+IBPPiZmSVdA7muvHWnTiq3sDlnynykbUNa8EVFDvuWPjpA=;4:nZRG2sSIBJuF4AEWdWQt+ZRL5nEl0QmgzhULcpHMoi70YQz7l0ySL09JU76vJBzyL0s/kcEUIkaYT2AxbeWQdG/2DjDZv8bsUm5liKbKBYYVPXnHtaIGKkcSeZH+6wZfK/Q0xBHxB6YCAE25x9jP/pEj5WZytNxIZzZZVeI29UzhbPBR9sDdNXyancV3jgcMUKlv+uT7XQ6fgEeyTdQfdt/EhgGI78MUTRJ+k88Zw/oZST8AzMsvyFDF9fb1r/ikp+u/vXVtrQ8zsUfmP6uDZQ==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3090EDC4817515024395B56796FD0@AM0PR08MB3090.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:AM0PR08MB3090;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3090;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(2616005)(58126008)(230700001)(64126003)(2906002)(478600001)(72206003)(65826007)(6116002)(3846002)(50466002)(52116002)(186003)(77096007)(5660300001)(67846002)(16526019)(106356001)(105586002)(956004)(76176011)(386003)(53546011)(31686004)(26005)(476003)(44832011)(486006)(11346002)(446003)(23676004)(52146003)(2486003)(14444005)(53936002)(6486002)(8936002)(229853002)(36756003)(68736007)(97736004)(65956001)(65806001)(66066001)(316002)(25786009)(4326008)(47776003)(16576012)(7416002)(8676002)(7736002)(305945005)(81156014)(31696002)(6246003)(81166006)(86362001)(39060400002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3090;H:[10.1.196.75];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMDkwOzIzOkFlRi8rT2tLVEN5RDdiQlV5NTZoOFJmRHFu?=
 =?utf-8?B?cHJIQkR5SGIvcnN0SndqS0k5MXlrcTM3TGhiRGdNcGVHanhzOUNmeWpERzZt?=
 =?utf-8?B?QmpvcXNGc2luVDd0WXVQQlllQ1Z2YlY0SDR2d3JZbFFNcC9xdkc2Z0ZMMU5r?=
 =?utf-8?B?S3NFRi9LN3p5eDI3NU9qMTFyRnQzbTVia2llaHBiMjRKR1M1ZEtrTzRtZ29N?=
 =?utf-8?B?a0h6R2Qwckd2UG03KzE5TEdPWTBGY2NSOVRicmtIdmdsOHFydnQvbWVraUxw?=
 =?utf-8?B?azFoVGxDOGxlMXFxOXJ5OUNNeko1R29Ub1MvbmJGWTZFanl1aTJWM3RUTnA4?=
 =?utf-8?B?aGdZQTJXaFpHVmZES0taUWF3ZlVqY043WEZ6MUV0WXIwczIwbmFjaWhSaUxW?=
 =?utf-8?B?bncxbjhKRXM0cEF3K21yVDlxZ2Y5SUxsNGVIekZvQ3RWd2VWbEt5SWFCNXFQ?=
 =?utf-8?B?dUFlZ1JMK3RlMCtGeGZabWFxZ2RLRC9KdGRLVUg3N0tkYVRPRXJBUDVrZzdX?=
 =?utf-8?B?R2tZSVRDQVc5WW9hSFcvTTJ1NFQzcldTTU5XV2g1MnFmaHk0WXVmZHpyY3NL?=
 =?utf-8?B?NkNqNE9XNm1RMlhCa2lCUC8va3kvQVZzTzRLVHBpb09tN29DUllibnFDcno3?=
 =?utf-8?B?dy9WSWlwY0taRXNHRUtsanV5ZkRENlVjS2tNOXZtbG5xcVhDUktHM1lQNW1N?=
 =?utf-8?B?dGJWL3p5eStUbWo3R2dLZWxvaWlFVFRvRVY5RUJLdkljZnJ4dm5qM1o0LzRP?=
 =?utf-8?B?eGxMOGEzbjlKSm1xbDhTY1g4OW5lM24rYmdaVWtZT0hnb0dlV1JvSmNzR1c5?=
 =?utf-8?B?VTFpT0NhZ0MxQzZWbUhDYTVCZjBsa2VKU0lhaUM4RzQxaUNEM1p4R3FHQTZZ?=
 =?utf-8?B?QUJRdU5mWXAvY1hHcWEvWGhVeWROejJjbzN5REM4TUU3UEYxTkh2K2MrZlBj?=
 =?utf-8?B?R0cvNElOd2hTaDNPZ0tsTjJidmNWSzlISVZhSjR0MEx1QUUyRjdndDNvWStv?=
 =?utf-8?B?S2huc0JUT2w3dDkvY2k4VGpZVVNKc2tmOUJSaVlvcmxaNFFDNUtrVit2MTBu?=
 =?utf-8?B?cjBYbWMxak56UTZUMVY4VXhIaHRTWUlCMDVjWVV6M2UvKzlUc015MVdBSkIz?=
 =?utf-8?B?VnVHMzlLdCttb1NybVhMb2tLeGpkTjBDR3lwTEMzMVVTQ3RNd09nb2JhdGpM?=
 =?utf-8?B?bTJhQURLcjRoZU81LytKQ0k3a0FCU28vUC9YQTZvUU4xeFY4eGNkNDE4cGRw?=
 =?utf-8?B?NTNHN1c5M1JsY3ladTFqSTd2NmJtYUI4dHVSbDZyNW1LS0VYWXBSbTJXMUFP?=
 =?utf-8?B?OGU5UFZPMXVCS1lPdzBIcjZaRWE0eU1GTkhWQVh2Wk9kZkE5MVQxUVVxWUJH?=
 =?utf-8?B?TEYzOXhVQUJRc2xreW5sY3M2L2xtYWhLd2toTGlvU3UvT0s3eExFYUQzSUZl?=
 =?utf-8?B?ZjdoZHU0eUxrdnBZM2dIdzZtSjQ0aGRKZTJjSlZLUlVRVEhpOE5pb0hPZzFZ?=
 =?utf-8?B?cHJuVFdpRGZKWFJQMHVXSlpkMXpWa1Vnb1EzNkVTZ0ZBZTNVZC9XYWp5VkR1?=
 =?utf-8?B?UVYvaXBrRUtCZ3d1SEQ0MjVKcW81ck9ZdDArbFNISVFVL2NTL25kRkt5elBO?=
 =?utf-8?B?V0R4Z1lPUm5hck9VelFjempERUlJRXh2ODVWOFUxYlFjemJzYU93VE56UGIr?=
 =?utf-8?B?MmIyVGNhMXkrZ3c1aUlmMjJFb0pkVSsxOWs4bWk0K2UxQ3lvZGRqTEJRRjdT?=
 =?utf-8?B?L1hUZFVvZFVMZGI3NEFhRGE5eEl2VUZoeExjMGY2TGZGTWt6bnVTa1BjR2FM?=
 =?utf-8?B?VWlVeDFQOC9pVnh3TU92NmJYZXdYdjRMQkZadGN6bmcrL3krTldzS3pwWlNo?=
 =?utf-8?B?a1pIOVp0WFdJdWgyWHFBSllabW0rMmJVdEk2L1l3LytmYVlMajY1M2pWTzFj?=
 =?utf-8?B?Z2IycmpSZmRFT0lLY2pUQ1VEajl6RVZyUm9uWVBGeU1oc2ZsSkZMZ1RodEI0?=
 =?utf-8?B?NmJmWGpkS3JDUFh3RXUxOXVVKzhTMGx4SVVnWVBDczZ5ejduM2JUS1VlYTBm?=
 =?utf-8?Q?r1I4R/8iiVYfNhxVxldCWcMAF?=
X-Microsoft-Antispam-Message-Info: ULhc/ZdZz7vy1iKyFRQSE7CHw+62y1HQ1FNMLxQIr+5UoG7gKWvHvoPl4KgsS1d7LoENlv4rfPFcDNz9AT2HukOe4Ye0uumIHmkjr5bd68HWypRoMYm30XOeq2fGZVkB9eKTGtN9aJALeX/QyHmQKS5ufsKkuZxNqUSvRPn1lbeIUPA5VLF/22PA+pnesl7pN3giad/aZN2a7DLlLa6pk2cu4PmnB9NfkJApTYFpmvd8L7j3h/hiREpFugOJsctfw5XxWg41BfoABkSmzOm5tIVxNs1J0aMjbqdcBfMhXXmbFQGouXBSoHI7JNV/1aEEmBFTxhJ9TzsMuBzOvNVwsnED/5McjM9XkFwx19sfIzw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3090;6:5L1jQ1/pDQU2iL6WP/wcCxR2sJ37RYiLCSyZFeGNjkgyawmSm0wbMZj+Uy2yfJkpZMRSfML8I23KNnUFAqcP3SxoB581Kibkoydza6imvrr4NUPuno32ZGNqSmMzjGLEl3P+r1aL1tz+83ACYQTv3IzMdbC0+welxNWfHupE8z/kIHNXEqF1WWod9oSe6I8UC5WO3A+hWtVTedfWfM9qtW7OqRvhBrdVMB7JdzBo09FvDNmBw21pxLccqUzCT2PzRB0PbjhUPEEtb5mnYOWWCI1URvLEXy0RJ0oAO2uvyKC9DMwGLWFpUZ5d6ahYrGsX7JKWc0xymcv+0RE/Pmy7K1gj8yYG+l00UrvIJB/AOE5yOxjp6kZLgY53mWYcL1DIz1MXbZ77kwLfJqFoh6QnWkniVySDUGHxBPaLs0nYqUMds7reNJdZFCgpDOq/GCZ0/hN7hvKC6usscTm3p8lGhw==;5:amRtIoy+H6TXlK6H/nDAFzk1LfEDkSktQyO0VbZhqTPNJKVI2hG5DFVJ7bIBb991eLOY7dudxO3W2dJV1LCA1KBmLOa6aPklfxgcLASOUJCLa0/I6OxFrs6zqi2dU6KGdfz90TWkQY1VMfFekbYRP1IqMkRzVbf90hsw0TBxCe0=;7:w4vUBL+lh7mLuQ2gPF/1Eu6hIXzZVAhugH5xWfS3u+9CNDa+IAgJJFu4o97R0hjsi3gXosdf/tlsNruETd6Ur7n3A44oPKi7KtMY1dsdUuRduDG/hCQvotpklTKSM4TMcla3Ub4i3tEn7tUGW/STmRFx95fBoVEtPP1YcdHBIJfZzZWaU3Nij/vtvFTzutG/0LcFP2Gv7Nn/JusnIfP0siHwlyhnY4g1WAfSH5uXhAqaNzNYhAnXri5pirImhxfZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 13:11:54.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c754771-267c-419a-2c09-08d6329fc763
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/18 13:00, hannah@marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Add specific compatible string for Marvell usage due errata of
> accessing 64bit registers of ARM SMMU, in AP806.
> 
> AP806 SOC use the generic ARM-MMU500, and there's no specific
> implementation of Marvell, this compatible is used for errata only.

Given that, I think something more specific like:

	"marvell,ap806-smmu", "arm,mmu-500";

would be most appropriate. Otherwise, if some future Marvell SoC were to 
ever come out with a *different* MMU-500 integration problem, you'd 
already have painted yourself into a corner.

Alternatively (or additionally), we could perhaps consider a separate 
property like "marvell,32bit-config-access", to mirror the existing 
handling of the secure integration bug.

Robin.

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce..92d7263 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -16,6 +16,7 @@ conditions.
>                           "arm,mmu-400"
>                           "arm,mmu-401"
>                           "arm,mmu-500"
> +                        "marvell,mmu-500"
>                           "cavium,smmu-v2"
>   
>                     depending on the particular implementation and/or the
> 
