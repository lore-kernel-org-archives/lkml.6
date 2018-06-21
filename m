Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C5C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rx++WwYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C5C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeFUJqO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:46:14 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:32288
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932704AbeFUJqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUwl9Yp2hsHh7enPfRcigdOK/qdtvwDEBmXwe24Zb20=;
 b=rx++WwYj9iDqFXZ/UXx7Ikrd7Ag2EAL7CRjhXY6x/BqVXEbRiB0Ist2S1/nXW0RGHQyIofGaAdU2STsNaKQ6Y0RDemwpZtG61jVe9hPYS5LfonxfbgxAnb56KLc5HUPq9zmUNxndG1QcUDfM74RBmxm9d0yz2k0uw52Ts5LZt9M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Thu, 21 Jun
 2018 09:45:57 +0000
Subject: Re: [PATCH] drivers/i2c: Include SPDX-license-identifier
To:     Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180621094019.GA5348@sesnaco>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <331d6408-e61f-6227-da44-0aa26078da0c@axentia.se>
Date:   Thu, 21 Jun 2018 11:45:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621094019.GA5348@sesnaco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:15::34) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 967a037c-4c76-4911-fc45-08d5d75bca8d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:otBtzPQtmYUbPCqd4or3C4ruBqSwBlLcBNekdorxi47EZVcFzFUjZGn/wwL9vPGDgQMOEAABxi55mTyEXpwb03HL+V4uHmB4aUcOrg2ABosw7lTw6irvL4N90zpZ2uW4XbO7yUgnBlD/C4ygM5gnF+I65Pn+T5kD0+FGb3ZLIKL8ZiiaA9R+fUjPI7x8qRl1CjbfqKPoBDHAmGb7Y6p9nbPbrNLa4K/DQGWvxnQgTFmesj57KDNmEs84eE1fsaCr;25:4onEsFzRCFsKOPR5fpYX3CwUSgphyek3knexbFucY1TPZj2zliy+MLDGrQ6B1aMtOticu/cNw3fB4yQMOGRlTkmJK8qifKxjqA16pwEH1WOA34kh0gItDoazWrsS0/aiGGdGFkXrsGHxmxkkPXXqeB0ki2mXfbkyiJoVWljdkaJtgaJlx7okZJGY8ORW07BEEgptpFSjavLHNABvau720VWeHomolysXMLogkiWKjr7dtqKVuShAOAikQMB4E25kwUwoQ1MY9bvIbt3fw/xvxTmPO3zCzi5ua8IoGjDMTbkrR3EgB/lFza3bWp1l7+1Oqd2+AgK8ht0dth/r7mE/Tg==;31:kk0ufQC3cVhW3z12ZJCUzBfL+aGFFDTmT2w2o2Y5n+Vb7+jojt0r0CazCvrd5ipnogkKxbzDuRVPyxlRPUtTfD5SYaBSV918X5kzYe7JhINRMkfsz8AU6zWS80Q7Be0gVbrTTp4QLw/KQPl6cbrZOqplPp0XJBhpUbDN1vRvuG9uYEedJ70BNvQ6wEsBiXxgzReDmyNdgutjlUH2vK6KxYouw5YGlFNxT489IyvfsXo=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246179F04F9F4CC4967EE294BC760@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:afxfp9FFDcLx3GAx+3maE7wojdzVtYDfSOgNSfa3C2HONJxr6wNzL9PgK9ADeyTaAWG4d87AJf96tligRpq5jcOVLN9/rr8/UC8yXtKBRjSxOnBY42a6EtAafxWhS13AYHymDP5JMbyqLTj8DIXC8JgfdW3myUNcm8AVCLy+rWQL51t9KA9fJCf69jJO3I5M3HedXAZ7R1sBcilrWmrWASEhannMN+JnR1NRoO931HekcdE8+fOjL/7u6XU68HpOnrGUNGPps3vCCMqVWeOmA/J1Wt9R9n+6khUcieLvfq0UmrdrvjnF2dwVHsugR48F
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(346002)(396003)(376002)(39380400002)(199004)(189003)(316002)(3260700006)(105586002)(64126003)(65826007)(25786009)(50466002)(16576012)(58126008)(117156002)(97736004)(5660300001)(106356001)(6666003)(8676002)(31686004)(81156014)(3846002)(81166006)(6116002)(68736007)(8936002)(305945005)(7736002)(230700001)(39060400002)(2906002)(76176011)(4326008)(478600001)(53936002)(36756003)(6246003)(52146003)(52116002)(23676004)(486006)(6486002)(2486003)(36916002)(65806001)(66066001)(77096007)(229853002)(186003)(26005)(65956001)(16526019)(2616005)(47776003)(11346002)(956004)(476003)(386003)(53546011)(74482002)(86362001)(446003)(31696002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6UzRWMUtBNHNrV25SNmtKc0VvakZEV1pH?=
 =?utf-8?B?Nml6aFI0U3lXSUVwV2VwSGNNWU5HRmNaTDlZZ3JheHM0ZmVqQUg3MDdNTldD?=
 =?utf-8?B?NjhhdXRRbjZlQWp6WUhBbTM2N3hWWlhSTzN5MlIwL2QvY2VQRGNEdjFjbmdE?=
 =?utf-8?B?Tks1dUFYREpSeUMxQjU5cTI5YXNrVWhKYkFxWk9Sa1pBelNMNCs0RE12bW9I?=
 =?utf-8?B?MU4rQlV2dUNpNDY3bGw4RnVnYlk1WC9wMWZOcmJYc3JUYWJsdkVoS2IzRGtH?=
 =?utf-8?B?UUNnc2JnZmpjNWVqMWtpMkR6akFGS0FHNFUxZytZeGhXZ2h5RXQ3bUZ5TW8r?=
 =?utf-8?B?UXVTaFVoUGRLTStEYVdmcEgvZk9VS1ZaR3p3eGlzeHp3azJYdkxISHQwQWN5?=
 =?utf-8?B?NDd3eG9KSXU3a3luZTUvMlgycXJMdXpiYWRWNTBQcnBSVjVFQjVVY2dndVdH?=
 =?utf-8?B?dWhxVlZUUFJZaTlKekNaTFlpdml5M1hlVGhRa1ZwRW1BNVhZdUNlaHE2ZCth?=
 =?utf-8?B?Z0pXVkkxb1YxTjE1aTcvZnpHb3dMZ082eHdjemV2bi9KUWFBZm1RMjVYSDNo?=
 =?utf-8?B?dkZqcUZFTkFzN1NKVGdmOEZXWTNnT1VRcHFhSkVvZHJpRlczdFBpbnp1SFZy?=
 =?utf-8?B?MSsySVEycWluTFh5bGNIWjZ2cXFOZFRyeFF5U2E1a0kwU3FtSXNseENnWTQ2?=
 =?utf-8?B?WHRtNmppam5lRzJwTTlsMDN0ZkR2dzlObi96bjBsbHM2N0pCRnF1REtwM2Nw?=
 =?utf-8?B?M0w1akkzeUMzckU4YXZkMy85WnVDK2JFQ0FjN0FxbnpxN2Z1QU1RdEZKRHQr?=
 =?utf-8?B?Y2Z0eWZOOTlOUVB5SUtQSlNNUWJYZDlhV0ZkTFBWaHJ3Qlc4d3EyN09oU1c2?=
 =?utf-8?B?UjZsTzA3VTM0RERQVG56OFVONHQ4OEhHaWJVVUwxNHJSOTN0ZUxZeklhKytN?=
 =?utf-8?B?VWhydXEvKzUvSWhaQWNJYnRpUVhFRmR6SWdoZVFRaUtXNkw3eVEydysrV1Bi?=
 =?utf-8?B?am1LWGtZNVJsbEQrZW9LYVRQK3ZOKzlRajBFYTFjSDZuKzhESDhlUkxPZGVL?=
 =?utf-8?B?UTA2T1ExUTBjSnFOWlpON2tvUXFxbFp1eUlwRjdpOGlLWHQvUDgxQy91UmdE?=
 =?utf-8?B?eGE0NUpxdmRobDJXWFUvZmVBMWZWUlhuMG9tV3JLemNDR0h5ZEhZUVJVMlZO?=
 =?utf-8?B?dXJ2UGtINVRJTGcwcmVVeEdsRWh2R2h4MDZnNy9jNWZDb2pUaGNIa1A2T2sr?=
 =?utf-8?B?R0x5N0RPeS9xR01WeGxxTTBwQWpNTEoxTVA3L2tZcUtqY09rSDhoMXVLMzdI?=
 =?utf-8?B?cENjWDA4RXRUUURnUWR1UndxdGlXK1oyaUdEQkRhOVpuRk1YT0VDTmZ5YTZC?=
 =?utf-8?B?eWtrNmhEbkIzNjRxOWx2M1lIVEh4OTlnWERnZlVjZElHL1VpS0VMVjNXeW54?=
 =?utf-8?B?eFZuaHlTZ3NMa0ljQVBKampITTlmWUY4bkVsUmRSeS9NQmh3V3c2dTFuTEFY?=
 =?utf-8?B?OUM0YXduWFpNeGt5T3BJM2VSUk5Fdm4zZG1INi9tVHdSVDNycE1IRlFxakRO?=
 =?utf-8?B?OXF1YUluNHptTmZyeDRpVmtiOFkxTU45ZDZwYVYwcCtpT3Z5UGY1SW1JQ1V3?=
 =?utf-8?B?T1FIS3pFM00wR3ZqbG80K2NlTHd3U0d1VjV2U2VHOXBFUWVzNnBJZ0JFUlRk?=
 =?utf-8?B?RUY3LzlILy94b1ZKck5VMkk3Nll3R3A0QUNqNWlnQ1E2MzhOMktXT1JINVZv?=
 =?utf-8?B?Z1F2SmlBb3VpRStmQ2V5MllFSnVJZldnVmEzZzR2R2x5clBobUpNNjZvVFQy?=
 =?utf-8?B?TFNUNlNEZ0dra3ZNcytnUk1Db1A4ZEJHS2I5ZThzekNyai9kdlJIamJnaUU2?=
 =?utf-8?B?N3BqdjNTN0tLNkgyWWNFbGdIY2FyMXdrTVc5ekJjSDJpT0pxNkxSeFVMRGxz?=
 =?utf-8?B?NGpxYmFtVmV5T29PaVJoc1FHQ282Y2pGV2ZvZWl2T0E1QWtQUE5kRllpWk1N?=
 =?utf-8?B?b3VCaTBlUUFwNFBuVDAvWFpuZ0g1L1ZUY1pTMGNPUngyNmg4S1V4cU5EekdN?=
 =?utf-8?Q?mtZiemS14pk2hRl3cqX5zwdg7bO?=
X-Microsoft-Antispam-Message-Info: EoPiAPex9NwL1oRsPPAw124KUw8+l/uEMgPJoQQmv7ye0AIyPd8aPAY1MYchFVtNkvH+i1ywCzNSrO+63BvBLm5PwGHmCGpfQx/aoI5HJj+iSdJ2lLS9EO/KBYXvpIWHDV1UIP+rhGouZ6N0SGhdksx0GVh6J4XN1TIR9N4gYi1fM/97xs3h+kYtORzI5cJKMesK2ZcmthwFN9j/yo/aW9dWQl3AuXtNvbpquny5jPyUZ6ZfHqDlc3yd4QeVadEq8ANlpuBz4MuL7Or6hTYWZW8phSrgHTCorMIjqez7VcwIbVGOCWCU3sQz1gNnKD38
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:Zo/UuZS6xCl5vgstzv8rsXowaMpsPnSObfwYDUGRAiNXPd6lyIiha4+ke4vqXK+tbXmbCL6MM9CVZKWRYtdiRcy9cUEiUDsaxMXQkcK0NTOEIkJdoYaM3ruY8yBMIgwpQNUN4Yulxyo+jIEfDs6S+jURIHOG+VSVW1MCkvBSCwtTf9tjzmwFdROh8juwgMSLnpuqt5l4ghGFawkxkymA9Fw3/2CFVOhv3dzDKhd80KIFScn/jm8yhm+IbnRQWZbTq3LM+rCBBU1Rab0JB74WRRV9vkOWveAcRCjdlrZHPSGHf3oOrRr4bWKyaEqF5Heh9fYedOPgsCniX8zFfJDLyHx0rd9XNHRl0WyL/RQXJzjp0DeS188DzzzpiAm+EsL3u/zhtVXO5BFCHcWyYOjnHN7A159R97Q5Gt62y86vpVIDiqsxBWTF4w8t2V1CXrtdN+Cw1r4qN4oi0QenJoanaw==;5:duJDJp3B1YtQU/CIS/u8o4qYiWY5B5sFLofz18uUwpR/NfVL+zLQa+mOUsM8bQfPb0CC99B0ohsTe8TITjj1GD0YAJqTTWO2/JaU8xWkuxXF6UTREREE/nFcWRClxQJ87mvRbvNlKW1+Gho4+Kq3h1HWKWICoLjcQ7lhuJdXBOA=;24:9SD1sJOI4VWcWJos66Y4WOUWtS3H3MeFT7EhTaT3Zy7i5bH4eQl+67dcvcU5YI/6RzQZM4tQtafsucpADIQDpYNKNrO9mb0sR9Ze/62BNwE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;7:hO4+vDPMXElVD0Th39aYKN5KwwSgKYIxCZInhFmppZw/4eH4HohAMsLyLQGt4kbGdSRtxThd4w9O+5h/debTgQlPs93jAAYehQqowQOLhUgVSGRWwYJz0GkvZQz48817BCyxdCBPVgydni96gnh3hK5azK9CLL2cmWjdtfMGrlbkZk+roQEDUt0wEhB0s9msOVINB9XLya2vTC6ZMSoYACXRXHnsKoz/trvm0sIo0OO8H5BqLw1dJXhJvpvWx9xm
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 09:45:57.8237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967a037c-4c76-4911-fc45-08d5d75bca8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-21 11:40, Mawanda Henry wrote:
> including the SPDX license identifier header  makes it easy for
> developers and machines to know the lecense that is governing the file

If you do changes like this, you should also remove the actual
license text (it follows later in the comment in this case). And
more importantly, you should make *sure* that you use the correct
SPDX tag, which you don't in this case.

So, you need to fix those issues.

Cheers,
Peter

> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 4a78c65..883ca836 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Linux I2C core slave support code
>   *
> 

