Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeDJNpT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:45:19 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:18816
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753163AbeDJNos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:44:48 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH v2 2/3] microblaze: remove redundant early_printk support
To: Rob Herring <robh@kernel.org>, Michal Simek <monstr@monstr.eu>
CC: <linux-kernel@vger.kernel.org>
References: <20180328020700.17050-1-robh@kernel.org>
 <20180328020700.17050-3-robh@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <584d5be2-6961-5f65-d0d7-bc4661aa21f0@xilinx.com>
Date: Tue, 10 Apr 2018 15:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180328020700.17050-3-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(81166006)(478600001)(126002)(64126003)(81156014)(47776003)(23676004)(5660300001)(65806001)(65956001)(2616005)(2486003)(65826007)(476003)(53546011)(305945005)(36756003)(486006)(106466001)(50466002)(63266004)(8676002)(356003)(2906002)(58126008)(110136005)(316002)(186003)(230700001)(31696002)(229853002)(8936002)(426003)(446003)(26005)(77096007)(4326008)(11346002)(31686004)(6246003)(76176011)(336012)(86362001)(9786002)(106002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1397;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT055;1:U//bVj3gY3lkOhClqj/TF18kU5SrFGlGRmGlThDWbyVbIziGoHPXuX3qnloqx0ePxrB6pY0squHlqnhs3Z4wAYLjBrxZt8FzZF/HliuujboevJ5lupotxx1MB1rY/uLo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ade979-99d2-4441-7e66-08d59ee938d4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB1397;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1397;3:ZVcRg5G4GAVAj+gXDFeVEt3H2VOK+Z5/0mKlZx/KnKP7VMgTBWbmA9+YDyFxPYiCOYP0X2kaLWj3BvXSPETxCnGUy1/NOZtEzqxQ2eMchmqQGeMuDJzuHNa479od46xTIR5LBVfeBeKza+4515K9waS22V1XA9S487KCaOnAU33sD5/oFv1pDGISQH8B0cQs97Gb2lXdAAXSOTDtwWNILyb74XbUGb7fHH1dbTNzjmF+o9uWAPdq7Vep/HK9H8Y0vNcQL+kQ5rWIANvyaXqhID54Rx2uhTgQkJbj5oKtzqxb2sOsjKocg5YrvX5vCjiDmxcobvrh+bdXxUh9tMMcnFece+MsL/A13J2ZSxgpvS0=;25:+3T+ZcZVxJ8+/DlLe7nnnuTJ1wZkhSS9vUzB07spZ9/7e90QkgV6CmYR8LTKtnBb8NzZ00e8HR7B+7Xw9MF2FCmN+iK6XlNCDM1vCWNl+DRnOx0/ssV/1DmGUzBktgCZmqCO9QbStz5VhsUxFccpj09zWcNVkEUUsxTxDY9zm0MZ9LDmbmIgoSMVB1MTi7LeKArOiFwd4P/D1Sream+k+D+JmxjCQEwGo7N8fJfh7asix1MKayQjVoYVmnh+V3jq6DqlKDTx+q1VGXs8nqVuD/bj+QKu1b1Jwh6X+WfckuICc2xzu90/2ccDGEMhhWvpNxRhgy8Mhqc7D/m79NrGBg==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1397:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1397;31:2fb8hxXzLBqmyqh3SPCnk7o4b+h+ur/qEheL6Ua9LutImaOoiTnK4V2bRDYEWj7sC79sPn0XK5dqPy1tQqPVz2hPG7LU4JYzHRbZ2tozrjiB4H80NSoDUWIAsADh1ccHIIAEWYGblVBl638wKv1nL+DJC4lzzdDiDZHahusY9kzn3P7uyqUd9BQ5ndcvA5WJSaURYf6h/Lx66WXtuQMgrHl3vflx/kILGqOzW77v7gg=;20:OgdgRn13sO8QLmAbqWRjSzYv4Fmfed4SfqAuilzPvq4iUmgeZc7FH1cJMLDdy69/0Lt8mVfpIhxCG5rIWbDYK7922U2aaRH4h1T+95Jxw3+3JnQ5AkHHc9KAg1cBQrcWFPkAOC3q9v6Cun/WTWTOSGaAeMARhvCDZp+dxfX/MAkXRLg0EWVY6so0N0OhCqaND1TZmz6ttmsekdtqlMiSNtyxBnlJc95QokkwQbZxvTGLP2wGFH6NbonE1mG4LAU6c54coRMIM48tqgEUwLiukaMhdQZvTJRtJDG+uDt1VnIe/iRuZ6E3mXVaMuskO81BZRkW+gfy/pAYu2SZpwinKqn8l7gX+COA3hRAYvXwf5//qniKPXMTN4e+n+owzz0bLmNOjhyUNNTSSHMshMMsB8dOptYRU6uLeIqIkTbiTVuElLrghGEcFLPT9trD844/UGIBtuvgeqcB2ZRzGOay5Og/Rbv5dZCNT1ZpLmAPHaPF1jPwkU8xtNO0njAiQ/w7
X-Microsoft-Antispam-PRVS: <CY1PR02MB13976016E8A55E32150F4550E2BE0@CY1PR02MB1397.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR02MB1397;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1397;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1397;4:AiCoyKGjGYrJjkq2u2hKhje1jATu5FL1lUkO/+4zyLotoohxqW4kMduMSQz7Kp5qg5p2DZNzBkLl/dXXTPMMzInTT53AekrOsNacaLKlAlmQeXJYvC4r1lOU6JvzUN3uc+A55O9UCXC50/myiVuSioA1P4TomcESvqw03Ogi5SyLeRD/YnWXB3J/RNhobe9OZOnQXXVykCKv84uCPURMO2ZvbP48Y4iRUOw89RD0Ic45eOqJ6oC2uTsfGXxEVIM9I60goTZNqJV2X3PPF4nAJg==
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIxMzk3OzIzOmx3a3QraStRMEh1WlJQN3MxaFdLY0hqVjFG?=
 =?utf-8?B?dGRYOFVXMCtnR25rZDNjWU5aMWtUVnNCS0FlVm8yWEVudlVkeUY4U1JvQ3ZQ?=
 =?utf-8?B?Q2tRRXFSd2VLaFNjZWwwTXlaQWhrRm5nVU02SlhPR3RVRVhuTmtqOGFlWklO?=
 =?utf-8?B?blM3MXdzUk4zOWloWkRxN3dDZ0kxOUhTVGJCOThBUmZiN2ZCaVBkNGswSEV0?=
 =?utf-8?B?TVBCWEovbTBHMy82RFRjL2pWUFdRcThuTndaNmNjcjlZRE1pSjQ2Wkl1NExT?=
 =?utf-8?B?L1Vva21PYllQbWZUVGFxVjI2VXJ5d2FQSi9KUGYybVF3Yk5vQ2VCcWZTc2tl?=
 =?utf-8?B?ZnZkQTdxeDk4QnJTOXJpNGhrSjI5TkJhdysrRVVybzZzZGJaenIwdTRlSVVx?=
 =?utf-8?B?VU5VMXl2VGlYdUxDZ29zNUszbC9OMnpCMnVmcE9NWVBuS3RjNy96NCtRZU1t?=
 =?utf-8?B?VmpyLy9YejdwSnNjR3JPNmtOWGJ5MkRUdzU0YmJLN05GazY5OW4yZk1taitl?=
 =?utf-8?B?QU5zR20zdm42TDYvSFhlL0w3aU8wZGtkUWorRmFFL1NTREE2OFgyVjl1TjRL?=
 =?utf-8?B?Yzl2ZEZZWFB4VExUQTRGYlgrSVJyZHFlZ1FvM0R4K1hCMkJNYllIYW9ZNmNu?=
 =?utf-8?B?ckJMUGQ4dmgvV2RnTjRyVCtjb0htdDE2bm5vNUFobWJ5UktYbCsvazVwTmVP?=
 =?utf-8?B?SU5RUlZOZHBpQnlGLzdRWVJuK2JOcGlXaEpOb012TjNhRHFDQ08yWHFUc0Mv?=
 =?utf-8?B?ME1najlaTFZvN3VKdmh5Y2h5ZitCTERFeTRYdkgzVlVLSlVnQitETTIvUTFm?=
 =?utf-8?B?RzNuZWJJY2dxK3R4dUx3dVFhU0FVNmQwcVUwZlNZcW1Xc243MWtQR3dkTnZI?=
 =?utf-8?B?R05rK3lSSGJZWEd6WmJ4NFBxczRhVGx6cjd0eE1JMkJLWXR0MDVMc3JqSlA5?=
 =?utf-8?B?VGFWdFNtQklkcGp2cm5jYm15T2NCdytUN3F2UHAweTNwMmMzdTRJZjhDN2hN?=
 =?utf-8?B?TkQ5MG5KZUxXdVVqVTNyaW5WcVpJMzRaVFBUMXlYd2Q1aHF5d1dNR2Raend2?=
 =?utf-8?B?Ny8ycHI0SkFyRVpOck5GbjFsYUYrQXFWeEdDZHBCMm1Pcm5DUmFLOFozZlph?=
 =?utf-8?B?ZW83QlFXOHQ1c3NjS2docVFDcmtzZ1RVcG9Nb3F2Y1VYcjRLQW9XN1diQjVG?=
 =?utf-8?B?RDBra2V4bDVFcDlUNnRLWC80cnZ6L3JMRkh0UkphamU4eWtONUdvdDVUOEc4?=
 =?utf-8?B?MXRka2tpd0FCdWFoZzZNaGlnT1VsRW5EOGRHZkNTUHg4UVpSSFhhbUNMdFJQ?=
 =?utf-8?B?QUV0K2ZRbXI3bU9mZHpYanRFSE83TTE2N2Vva05aMm40dnpqOVpPMG9Gdzdy?=
 =?utf-8?B?TjUxem1IRnJCYzVzZi9MaXkzVVRSUDVZd0tIa1hJam5RMmhyNXljbUh5U1hy?=
 =?utf-8?B?aGhLYmhmU05TMzhoSlJnTytaUDZqc0VVS3doa0Q0eUdBTlZyVWZtT0ZINDJS?=
 =?utf-8?B?SzRTb0pRRlBLeXZLZ3EzZVo4bU5DcGpUNE1mRUlLTmx5MkhDOGVraDFQOU9X?=
 =?utf-8?B?RHRiUWxJbjFBQmhQcktxOXB0Z0xyeHV6UG43dVdkNG0wSDBpQjNOUy9pMnh3?=
 =?utf-8?B?c1Rpd2hRWmpsdDBCYUtqVTU3anB6RDA3aTBlNUc5VmxBaGFOS0gwZi9nPT0=?=
X-Microsoft-Antispam-Message-Info: whjFjjQB3lW8Gg8bIiC3hDPAkASQ6TSB17GKPbXJCXhE7hlvGUd9LqLKpp4xzRt4LbJkv7jN3nSCamemSdTVZy09iW/sR+bwXzJ7PXYI4n4JzJnWLAi4DXdlbOQnr13S/AtEf6pCT+Y8LkIcSQo9+FEOyIEfGlqvy/UGsz38fLicjoR7NMJzeJQhQeHJ9l5D
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1397;6:QWU+Fzg8oYEGK8yF3JFuxQGXPEZOEUb4NefvgADUwbsBKtqvGJz+e1Bs1+gNcguKXb91xGPYcC+3EIiG734SMaz5wMbJPAtOnrkyeoR9IK/eqJ1bhnURs6U3zrMF/qpbCZPmsPUL03fDFtje5yqpcTmbiDkU0gmRFzALQZajzQxLbIRIMj8Mk5xzb1DF+xbUjqZ3pjWNX+ekv0UeOUvxNSctyzaf5U60wUDwxOAOfAd5qxPCqdHmJjLaLZ960qjLaS7HwnCjSfjyXMmkUjv/I0u939ojxjv9rxATqx/cua2vbup9kHfzqxylwwMrkVKDNM6VsQPV/TOfolj+SmONLIchSib1vaS/0X/7CH3DR+HmfAhJPZUnGT61XI4WDgRODDZg4i1po5Q8YPbM/z7fNequPW69PiQzxSehXNf4+7b/BBUymMLz+obRNy30pMB6j+kAXheC6Jmr08NQUOF+3w==;5:CYwU6ZFISwHBNxB4SyuiesfnC+Gt6fVMM7CdwDxZoD7LmzC6VibR0P5twsItdLbT17zIZ7IMs30m52hx/lJVyw2xWWkBQ80G9i07GNn0DEqdJwYyoegQ7IOdSY2tPQddoHE1NFPe7L4O5KcpmWhmb1sMVLn3EzQ+T2PLy3JKi4U=;24:9mL24E0HG/opkxQW3s/vYSUR7+qugPoAPlBolbJzYzYG+g6V/yIr0NFi8+n6ekth/5f9pNn5HnEM5W/StQuXosgK4e362HmnUIJ+9SHHoro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1397;7:bSy8jjqJ5kFlL6Yrx5ELwu9GDimbmnPvU8qFxyjAxqxKhznivghh/H1v867FklcXfJiGSPPkHJk9N/RHhWI4R1lF5f/2pMkWs5F7ZZyUdvn56ykcHvK+lxyhZZNNdqNSKGJEZd07nNX6ZB9SNBZE2dPR1xisRjsJ7BE6V3Vz/rdGCoePW3QND7bqLR+mRiiqzrbw3iXvMnr2zGDxPwT6EyU76y8//U/xiHVXxCzvp9QBpk7Kt+fc3pbruZFWzNMg
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 13:44:45.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ade979-99d2-4441-7e66-08d59ee938d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1397
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 28.3.2018 04:06, Rob Herring wrote:
> With earlycon support now enabled, the arch specific early_printk support
> can be removed.

earlycon is not the full replacement of early_printk support as is
designed right now.
Definitely current early_printk is pretty old and contains code
duplication but it starts much earlier then earlycon.

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
> v2: 
> - Fix booting. The setup_memory call needed to be before the 
>   parse_early_param call.

What's the reason for calling setup_memory before parse_early_param?
Is there any dependency?

Thanks,
Michal
