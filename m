Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeDFMEQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:04:16 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:12198
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbeDFMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:04:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
Subject: Fwd: regression, imx6 and sgtl5000 sound problems
References: <6a6a2258-a34c-ca24-9890-0a88accb13c2@nextfour.com>
To: LKML <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
X-Forwarded-Message-Id: <6a6a2258-a34c-ca24-9890-0a88accb13c2@nextfour.com>
Message-ID: <d5bd9308-17cc-d5be-18a4-b2666bd4082b@nextfour.com>
Date: Fri, 6 Apr 2018 15:03:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6a6a2258-a34c-ca24-9890-0a88accb13c2@nextfour.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR05CA0159.eurprd05.prod.outlook.com
 (2603:10a6:7:28::46) To VI1PR07MB3343.eurprd07.prod.outlook.com
 (2603:10a6:802:23::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 706392e5-63f9-4846-0246-08d59bb67b7b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR07MB3343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3343;3:JE6yvv0Eih9bTfOfgLT44WkLO/hMvUQi/T7bm7+HypkF6wXw8fTQgxFFblkQVbd8nbWVUXiJaJVDc6GFVgBmn8QYTMFrlwJFBVPaXwgcnA+LXnomXQd/RXK4fuWJw/KjpP/V/u18x7itLV9rkV1DwiDxbMoHVbvK45jbToywMqjxhIiQXSo6qZSF50NvrC3W+QupP4AgbGmq39ld50mYtS0VtO2dy4Vo0QhBA0F5YQN0HYMLuWSnccXoACCv9kvR;25:ECHDZRDKdxT4n1zx7h/YIUznu6kRNvpdvrJm4KQ+QJWkwC7VgNYkdjqW/OCtaay42eVVSherU3kLhGdgL1zm/FLaT299MP2evtcQnRJZFcSwmEZd5aXrPVQ04mIz3ONApAbB2NRrnR+1fDb6v1GD7qXSStdFEFBVFuWbHq9YQPNwPq0+23jCbvTwJIbEek9Mda3Yoqfo0dD1aQTYOllMyNjY0/PO16jN91Nmcq6rOuoWaUUcTBbmIYR+yNP1MYPwQQpPO5iQOTRz9+9u0HC2ApnRnhGInBP1Zqhd8d0FopfcGdDjOvvcqtGaf0C7FJc+Nbr66D9f5POHGPWZ+XUbVA==;31:kH0ADbI6f3Qzwp4HaWhfzLehfmtumJEJOQ1QsbDmb6HWgUp8Y8213cF4dt9NQEKZg3YePr2Y8b0q5h3EOtGGFjfGP1NuVndPwoU0i28Tm91lLgPt+gGjk+Wes7YjKQcJRBtLBb5cul7Ff/UQl1Nw9pX0ZGXlH/VJ91pjOKr0d1pgVFKh0MK0SeETnAnZmVjmK9fhfPQlfhivTmnJw0/NaFPhl/weEWFvxLlWplYCjsQ=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3343:
X-Microsoft-Antispam-PRVS: <VI1PR07MB3343C64045D628F28704D64783BA0@VI1PR07MB3343.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:VI1PR07MB3343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3343;4:Bnx/SvASM7dUT79ADOqKwQKJ0JmWIYAL5bwBNhia40j6m/eYdef3T8hQ4cOeKjnY6VQtdJfaoovE8hEM9Yv+IKTFfuS83TZC/W+itPj5ZFEu1Fj5ZkRVt105XValM0ykLq1mSGHAn6X3bZE4YRdF3pTM9Xp4YbEtCnfVm0O79DyoNcXK0gB4vlr/B+skpDDDuUeUe4aH63drvLbc9npwIqoDV8r5FijX/IFK7E7asEUS4PON89NKvxaZsAqkFD5NNsuCSbfM4uDqr00VPqr2IH9N8SkEx5mreLSdZu+KVar/DlYtbTRIeBD4ZzTAYV7o
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(39830400003)(39380400002)(346002)(366004)(199004)(189003)(8936002)(956004)(11346002)(31686004)(7736002)(305945005)(81166006)(81156014)(446003)(31696002)(316002)(8676002)(105586002)(486006)(5660300001)(16526019)(6116002)(2616005)(476003)(186003)(68736007)(3846002)(50466002)(86362001)(2870700001)(25786009)(2906002)(26005)(77096007)(97736004)(2473003)(36756003)(64126003)(66066001)(65826007)(65956001)(65806001)(58126008)(47776003)(229853002)(6486002)(6916009)(16576012)(23676004)(52146003)(2486003)(53936002)(386003)(52116002)(478600001)(6666003)(106356001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR07MB3343;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMzQzOzIzOkZCenJJbzVCQTNkV1psKzlNUjF1emh2d2Jo?=
 =?utf-8?B?RUxaSVNwUEgyaGxIOFpCYWhqV094Zk15MG4rejkvSlF1Ujlzb1V6ZlRCQzVU?=
 =?utf-8?B?ZFJKV1pIekFDU2pDN3g3TWluamZidmlDakFzQTFNeG9HSHNBellCY1F5ZUpK?=
 =?utf-8?B?L0dZemhUTDErY1NScUZLN2U0TjhiMXMwendwWGltT0hvOEc2ay9hbnFvanVB?=
 =?utf-8?B?b2NPOEcyQkduSlFKdVZKR09OVFIwcG9maFBadkhUd3M3S0pLK0ZEL0FoVWdC?=
 =?utf-8?B?K2U4WHJoRis4L2gwVHNLbXBSOTJvTXlxN1p3MEt4NjNmNEUyK21Fai9Falpq?=
 =?utf-8?B?eUNXQlNuRitLZXkzc3EySGNXLzhoOUhjSVBDbmhHMWYwbW9STmFoNzZCbU5P?=
 =?utf-8?B?NnhuNEZwT3VMODAzOFY4anJzSlhxREtnOFFoOVhnWC9vVzJPOUx1dytIZGJL?=
 =?utf-8?B?RXVyYVIwbVUvQkhZOEhieW5QR0RZRllzUlU4djFVK01oMG9WaGpHQThoUTdO?=
 =?utf-8?B?ZEFqUnVNbDd5bWpackdSVFFNYTkyRWp3dXFVL2tvZXZCc0psNlYxbjI1d0VW?=
 =?utf-8?B?bUppNVJ6VnNhUGlCRmNSUWJlVEQyNkJUblFsQ1FNdlBmNG4zZVozVXhzM2Zt?=
 =?utf-8?B?UXlLNzJ0ZUt5amdIMkpONUdnYU1tb3hWV3F1cnM5UHpTQnJSUFg3blNGdHUw?=
 =?utf-8?B?L1M0NnphbVAwK1ZRL3hwMDdpK3JKSW5kaHFheUNESmhzNVpmS0V5NFdXVkUv?=
 =?utf-8?B?eUVYdTZIZGxmckNheHVreUVES3k4T0hTS0orU0Y1T0pWelpwRzdERXE3UjVT?=
 =?utf-8?B?bEhWekVHVzJicmVpbWhYWGNVand0dTlaa0pYTGVuSGx6UmdMNk55VGVqUmdi?=
 =?utf-8?B?ZGlTaWVLdUthZVErKzZabzRtd2hBR1NlQ1o0bzlSb1pmTFJEUzBTMHMxQmtL?=
 =?utf-8?B?N3JwQUdCQVRGUFRYSnd3VU4vNmU2RmRIbVZNTU03MjlqRDJmL2RlU0oxdWNz?=
 =?utf-8?B?VDJGTy85OGhmKzU0WCtjZk5uU0JYYlV3bUx2UXdoQ09MS3RsNEZhWnU0c050?=
 =?utf-8?B?cm4rdTEvakNReDRnT2l1MDZvd1RGaXBTYXhpM0k0eFRySzRTeFhHd25GVkxW?=
 =?utf-8?B?VVIvV1VwUDZOYUVNQy9sYUR2SWVRRmxNK3o1RFBIN3FYcDEvQjhYWkhFNmVs?=
 =?utf-8?B?aDBuajBua05EcUpIWUlDUmNYMlhBODJlMVU1MVlKaHR6b2FncWUzREcwQlR2?=
 =?utf-8?B?ZFFGRlZaUVc4Rm45b3I4Yktack9UbkxXMDJJL2hCQUl0Rzg0dXZYVk04QXMx?=
 =?utf-8?B?K1lUNlVsOHlEdk5pMWJOSEsvSHUwMjBXL0pTc2VJTUlUODZNUW9sbnAwZU9D?=
 =?utf-8?B?QzRiSmNIdjBpQ21OeVk5NlY5VEVmNWtjN3UwekRrRkM0YzVVVlJ0T0xOdUpU?=
 =?utf-8?B?UWJvcU14ejBIejVxSzcvV1NOZXpralNLaVJQa0wxeUt5QlJFNDZCSUR1M1NN?=
 =?utf-8?B?ZHdCUWs4ZFpLT1h5ZlNWdk04MTRkaHUyVjY5WjRjOXZpK2NzY1R2MnRTdndo?=
 =?utf-8?B?K0JHVWJBRFZKN0g2UDdkOUhaRGtZMkZIanVJWFhzOStPZmZNWm9lSU0xTW1v?=
 =?utf-8?B?Sk1kT2hTd214QzhGamFhU3JYUlVOSllKS0VScXpodW1wcHF3UkpUaCtiUUFG?=
 =?utf-8?B?Rlhkc1V1TzJLU1VVSTFHUHZBd1c5a0VtT050MFRmRUQ3WWVuRUdrWHFYNGtW?=
 =?utf-8?B?L2dJTm5KK3AxeU13SnJrWTRIeDRpeHFlaWttSml0R0dGWU5zK0M5ZElFbU5I?=
 =?utf-8?B?REY0T3JnUUcrTGI0WVlaNWg1NnQxaHFNcURGelR4d0pQSEpXVUxpOGE5b1Fy?=
 =?utf-8?Q?tq7aog6DGIk=3D?=
X-Microsoft-Antispam-Message-Info: vqLttZtRjZm4u5GEumVuMSLtEqm19CW80yqCYow0xgQmkyRW9Y/sD7dk1bErgEYJ7vNlGrtTdEaRcQ5OaoChItksBICVI6JpIAep4FGzNGubpAOqU8N5ml/jF9v9vOCkbJHSr9zE36y/xyn+n3TCJ+jgF3YhxuZDLU2VrEtbL6UVtcJ4znJasSpADVWqoBIe
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3343;6:swgalwhjSWuDzyVZ3y/siF4eguWajnExga/SPKTBs2I6Df3Meevv5u5chDqtRp8ANFFFSz2W8+GcdB0Anaa5QI4CB9dwx5UujNaUg58kaSBzTxQPX4lFxhDic1H4kDb9E1QDuQdkY0G7DR1QeZsnvocNAQiMUIOPqnoXq/is7x2EJQQY8/HpHqtGbOBFfwBnEfPPxUWtdTyKTouD4U9rB3TYCvFyClF7qf8YpkhbIqL6IepfonYt7c7DTxrUJWzkeLPmaOMvs4BWkhVxWn5HUxlyr/crDRvZ9AOismY2yX8TeoHgxU6N/mPkrPKLaFK659/nkba6/3HV/6dE+4hu0f8L5IeVP5YwTAplTME9smXauXY1b1rc0riyhra1ThgJvj/I2bN7Ey531FawSR5YNNqU9lnt8OXxmVzXCltXQHouKp969BX2/3itNbZMA6sGzTKATYQro/Lb32djByLibg==;5:SsiPoAhOx/6r2szoyqSTkR1IHW/rn9bKxnUAejIjTG1IVkbW3YHd/IWmJL2JB7BC4Df8tKtE+1wKkLoFPu7tdRuN1/QcvzU466DIKn82tZ7p08fsaQZFlXchOSd0a696+XuWczJHZgd/S2Ke2CFJMcnwZuxR7tetRQhRpzbW9Q0=;24:s3BI/EQN61i6nIBNsPJ0DK++lFyYnZpDF9OIhWaFKFPionxY3FDZ2pFw2ShBBQnQv/HoQiBZT02pUNSUloTm9wprzwEnGDxvdyKG4dXphQc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3343;7:XTbli3tkgcymEFusgMF5hUn+Hp+eks3cb9jypA5/RrAmBt2ChA2So5Qnl/vmQEeuiRyNdWj8EwcX5uCced7P4Nvdt+RU6F/QNELzjwOmTfr6iIqFQHAkJ+4jjTxIS88SwvMBkQI5lI3YxTdsywSL5zChK58PO5rkisd9yxkLj5KrvX49Q+uawYBc1DA8rDQjrMb21KF62tVaQCYx7l2A1Z0VeX7M9l1rgbn4oA5tx+ONnrFu2RtTGDIvoae2x0oZ
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 12:03:59.9242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706392e5-63f9-4846-0246-08d59bb67b7b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3343
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Fri, Apr 06, 2018 at 07:46:37AM +0300, Mika Penttilä wrote:
>>
>> With recent merge to pre 4.17-rc, audio stopped workin (or it's hearable but way too slow).
>> imx6q + sgtl5000 codec.
> 
> Could you please be more specific at your test cases?
> 
> Which board? Whose is the DAI master? Which sample rate?
> 
>> Maybe some of the soc/fsl changes is causing this.
> 
> There are quite a few clean-up patches of SSI driver being merged.
> Would you please try to revert/bisect the changes of fsl_ssi driver
> so as to figure out which one breaks your test cases?
> 
> If there is a regression because of one of the changes, I will need
> to fix it.
> 
> Thanks
> Nicolin
> 


Hi,


bisected and with this reverted I get it working : 

ebf08ae3bc906fc5dd33d02977efa5d4b9831517 is the first bad commit
commit ebf08ae3bc906fc5dd33d02977efa5d4b9831517
Author: Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Mon Feb 12 14:03:10 2018 -0800

    ASoC: fsl_ssi: Keep ssi->i2s_net updated



--Mika
