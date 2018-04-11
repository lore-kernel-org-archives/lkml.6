Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeDKKNI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:13:08 -0400
Received: from mail-he1eur01on0129.outbound.protection.outlook.com ([104.47.0.129]:48531
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751972AbeDKKNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:13:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to
 at24_driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180410131206.25760-1-brgl@bgdev.pl>
 <20180410131206.25760-2-brgl@bgdev.pl>
 <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
 <CAMRc=Me66c+ySsmU9bePG7KFU1sTH0OHTfoxrxC_z6Txbu3tqQ@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <47dab3e5-1232-dbaf-2dc0-d71d83ef8d38@axentia.se>
Date: Wed, 11 Apr 2018 12:12:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me66c+ySsmU9bePG7KFU1sTH0OHTfoxrxC_z6Txbu3tqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0238.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::14) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:E6I0ufgW5Zxfm35EcvBbrxj37aDx+7ERYOE+PghEdMxTGsCa21H9UiE3oVIeMM/Zq2k8osinI8WWv75WAGIpUmUQ/9ePIyaJILtWgjZQz2FzuzCm/97L98uw7eL4Neekw6PwX/aQMDl8MKBr07R0A+Srf8eZYJiwhFTWVgbyVeMT+G+prlEw4541/j+3+5GQgpoNImdE+yiaCQRoG5nKnJ6R9OdyvTjf6j3a6dMgcpB9J8tBheNM5Ci58CNHR4hd;25:p597saU6DBdMg6dV+uqC57CH9M3JIoXu6dx4ha5R1AK7ltv7zWB5mBsfMq89PyaMlUYVEnPRKp3eH01NorNYzTTEwtW28xOCYqVwtyt2iyjFNGqpkwZBzI4laVFZ1YzOVPpfEM7nPiyT3c9BN6idW57o4XAbycdxVWDcpdaKp83xy/R5xbOE6/SNxTxCUih7Eu/Qi+dueYmfUS/rZmt+uYIHtB+NDVVpnvml3MvVkPQFMRn7hkLA1LkLq1QrsRKM78JVziYNbm9StHKBBEqgY6d9kLLr2QOIt5vVXuw3ZpgmiZ1fxfpkxacAmnK7LSmq+4072yXWARyzZ3ir3CVUpw==;31:u2O+6lS9YOqZ8eYFNXpbfYCkxofnfkzBBrTOWnjHfcb33v5dHMY5+ihUgv3fAc7iWKkWVCOy8ZapgYMPxE/Oer6OZ0oQEiZNh79UailntNTObZQrRbsT0bIgZZdoIEmNWIIyaT2QvSaGSgCFy3ZuFJslzm7nigi8P4MhLvDvAt3whj3NUWf/yhDAQSy3lvzIif8fIlWf2Ft9SkDZOz2yWCcGXdA5oMRKDWMnJ4quggg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277773FF303D7B54980F8224BCBD0@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:QuA6fs1pt2fCavy2Z21SLzzmCb3r/c4W3A20GaoRhyBXs9bDX8Fv0386r2FGw4SfWG93Kweppjkzkb9vEoowFscBp6+LTJeXmIJNVoBRm3aLV4HcmWECkHqhB9C49ar8K1RU+u0LkC4ffS+SAxyohlzK9SEYdnPZYxNACKb7P/LaAHbC3IqcXsAOi9hZOe1sSi7skNJlTxgUw8H45lo2l9DnLpIzK0tvXL+zcMqZVsUwnCkTCeIH303ftm7DahFes6yfltOi2D/owIF+cIMgHw==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(366004)(39830400003)(346002)(376002)(377424004)(199004)(189003)(6666003)(58126008)(54906003)(2906002)(476003)(53936002)(6916009)(316002)(6486002)(6246003)(229853002)(4326008)(230700001)(7736002)(97736004)(478600001)(36756003)(486006)(305945005)(16576012)(3260700006)(31696002)(25786009)(117156002)(65806001)(66066001)(47776003)(26005)(77096007)(16526019)(74482002)(105586002)(956004)(31686004)(2616005)(39060400002)(186003)(11346002)(64126003)(106356001)(446003)(8936002)(8676002)(50466002)(86362001)(68736007)(65826007)(52146003)(2486003)(23676004)(93886005)(6116002)(52116002)(36916002)(386003)(3846002)(65956001)(81166006)(76176011)(81156014)(5660300001)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzc7MjM6OFlxMXRzS1Y5azJMaEdXNVREL2hQNnZs?=
 =?utf-8?B?aWVDMFlKV3FEYks1ZnF0Z1ArL2t3WTRoY01lZWhYZmRFbDhWc0dET1p0Smxs?=
 =?utf-8?B?NEkzNmZPL0ozVG9YdE9XTC9rcUlUK2l2MDVtdUJoODFvcVVwYytxYTA3bzBy?=
 =?utf-8?B?S2RCekxNSndXTE5HSFZnOXdoa0RnREQzTUFmcldjYnA5MG02U1lmNWR3bVFy?=
 =?utf-8?B?UzEwWGNJT2FCL0huVE92Z25mVDF3eU5sZVBIRWs0aGJMZDZXRVBvdmQxQVNI?=
 =?utf-8?B?RzNsSXJRL3dLd09wcTQxaFZseTc0UGlDR3VPZDJXdDVMdWp1Nmo4elZEeHdZ?=
 =?utf-8?B?UEMzVnc5MWlsYWFQcDBkSFRROEptNnc2bjAvdVY0TUkzMkErN2FmSEdpQzg5?=
 =?utf-8?B?V2pIZG8wbElVZTk2dytPOS81U2tPdFdMM3d3Vi80VGFzOVI0cTJsT3RtNkx3?=
 =?utf-8?B?TGtlTmpxK0RZWDllN1NEUkt0MjFrbEdrR0tLNVVBRVJpNkhVU1FNNWpwbXNv?=
 =?utf-8?B?UUI3dE42VW1YbHp2eDBJMndKRE5qTEFFQUNpdnFjTGt3aUhUVGFuTUhoWUJt?=
 =?utf-8?B?SXBaclZXbDltRGFncWJ4c1pJZnVRbjhNTURROS80bFlVU1U1ZjJyVGcxaUVB?=
 =?utf-8?B?eVhWeW44QUFrYXUzY0R1L3hXMG5aVjBSZkxXUk9FTDlBN2VibFRvUFl3d0s1?=
 =?utf-8?B?SzVCZGppVXVTMGIvTGs4bisrdUFvVisxRk5MODFRR0NRNjlmY08yanFxUFpo?=
 =?utf-8?B?YXlHV0kzSFI5MXBXZXFhS2VQSVdRdnlHMmpVYUVPTElENGFDUi9ObGJsck1O?=
 =?utf-8?B?Lytwb2VIcEFQUHVIVkVGZzhPTllkRW02S0hOTWgwaHdWa0cvdHRnb042VHlo?=
 =?utf-8?B?TGpqaVlxeURJeWtPWEtNSmZOT3dOV0RTZnlsTzM2aGdBUkJBdmxEYlMxUGgz?=
 =?utf-8?B?dXFTMVVMcnpQNHZjaWk5QkFrcXNWenpqV3ExUzB3dTU3eFd4dXZmUFdkc1N4?=
 =?utf-8?B?cFlnSkFEQzhOWFNFa1BySGwwRHVxN3JVb1loc2xZaGxPUnREaTRsNEpzTVFx?=
 =?utf-8?B?K2ZQenkwRytvNjkyMlpaZTlncTJwaHNFNHcyMHgxNWtHc3NUZzlZYkZCOXpQ?=
 =?utf-8?B?TjZFTVg4R08zNTRLWjRQaVVFSjVPMWFoYVhibE9mWmZNdXZ1RFRaOEN1STJJ?=
 =?utf-8?B?OElFZnRPM0czSnBkVG5mSjNyWHZnck5ORmpTSUNyRExUc1BvbHA1UlV5R1BN?=
 =?utf-8?B?ckMwWWU3WXJNQXIydHlRR2ttNGJYWnJMQVZ2SG1VdVZ4ZzFZMkZVWUEzMW0w?=
 =?utf-8?B?UzdYR2gwN2dDVW9YSjc2MW9LejBhUkZ4VE1mV2NjZEhscHpTT3pJTUY4SUVE?=
 =?utf-8?B?L1lIeUo4RGYyTkh5YlF6K2NiRWdSQ3ZmMEsvTW81R0dxbUl1Z0hrbGl4cWN3?=
 =?utf-8?B?S0JJV0M4QVdsZ0czajRxemY4L2dRSWNuQytwL0NyK1BRMFhOTFEyRzhJNXdF?=
 =?utf-8?B?b0lISlpaczNHUU5YbEhqVHM3VmRjQmYxZDh1V0VqdEQ4eGpSQWZYRXFkOHR2?=
 =?utf-8?B?Q1JCYUZyLy9YZS96aXZVaktuWHFoalJkc0JGR3pRc3VNQ1R2Q0hJVHNqckpa?=
 =?utf-8?B?NXdKS2ZBbDhoWjdMd0xIbXJHU1NYY1RBbGxicXh4MjJ6U1lHazEwUTFTbGhj?=
 =?utf-8?B?UERIZjZsdG04VUxQdTVKZTlkSHljMnRtTElwRkpIOUY1NjBVUDhzWmE0Z1cx?=
 =?utf-8?B?ZThwVjlNSXRXa0tQeXFGT0swTjJpYy85MUNwMUg2N3VGelowNEJlOGJIZ3ZR?=
 =?utf-8?B?ZHNiYmRueUtGMmNTSGsrOTdLUkQvWVo5bGp4bk9uRS9hTkJSalZ4ODJZcHBz?=
 =?utf-8?B?ZkhJWUtEZm9WREk1ck4vMEVLQXNaM1pCRDNPcWNjbEVGS2tzS0NPNGJZNGVD?=
 =?utf-8?B?dXB0MDhjMzNLMHIxeitWUmZkVUJMU1FpSk1xL2pEampVQlNpcDl0U3VMNnNp?=
 =?utf-8?B?N1J3OTBKZzNDb25pNTRsNUpXU0MxNDJPRHZWb21zeHlWRnFUbWpxM1pNYlk2?=
 =?utf-8?B?TGJINlJ5MnI5WVJOQ1BIaWlNYkZ1ODNkRlBZT01vQW1JdzZtUllLUmdIR0Zs?=
 =?utf-8?B?SU8vbXhacUZHTkJSMzhON3Y3N0Y4K2xFTm00eFZXaHA5QU16cWxUYTkveHRX?=
 =?utf-8?B?YWoyZ203c2JLbElFSko0Q0NKQjR1RkE9PQ==?=
X-Microsoft-Antispam-Message-Info: Yxuob8ZJuw8MpZV2ar6Vf7k1GNW6Yxzwq/g+yKvOHhFBVhVtsM8Tw6mPUUAtVo0jCtU3Mcy2kKCU/qBB1unuEwT7wkOd0z4Xfrdf4wxZ1DAqyBClpQeWv6HT1qC4x1sJkRAI/Yso0YSwNzmIIiJyUL1uoJkqOU1RVsgSo6Ix9gn0+cFlN5OP74ge4ACT3ai/
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:0mnQ2rNvx+RgV1HeFnhew6Ae5B+mtE4bh8BmWE+5S9h/5sTxfn2mTiiC9D1L/lYwJOTr0R6Y74mpsdRojxKNsabWgoob9QD2xA/WMnfVV3lsiM1Mmofpdd+48HuiPAGLqMr6xx0aHcoVW/1i5hP+AUJ7xYWzBh9PDua79DwjdJui30vorMBnIJzQuYzaYqcbHSt3OHCQs+7qub5S44p3ojSILvWqqeW0cm8Jy2eTcpDOmwCmKhgWVkIhLDCjct2yg6J0U2yAS8n5LWV7wYK74ps2OV4DRyyHdKBl6Yd/na9gP9T3P1TNtYkhEstBj0xi/OccMyIYw5GZ1ok0zXqhAGfjZIrMkiVXSM1RvIfKKSLODnazjwog05viz2S9z+zXDlEAAm+fbpzKpzJ3mbwIrhVIqmZj5f2DeH7NDM42HLcvZ1Z3JUgQXcwXocrSkw9Srs3O5K40h1c4OwaAVSQPYw==;5:cOwKYpV+uKhpLWl5CwMhyeeRZqmWTjfzHFRBQ3XUA9A1QqDCaFG/+gUnn7B0vKxqg4w/E87JDufowpW5XSZgfBS55xTh4t6ciU0lIDttoZC2YCeO9IW08Zi8Pwzp5W+NrWPfYQndNhuFyi6urXwItq+8Xz39flcsHMOhR9sdsqo=;24:H7tRMJdFN5nEgtXkXFMHPQkkQT+RWnk0rTAb5eWleKSncRv6ZNMaSs3NivOjlsnSC1yAQr8fhcT8DVvWp3CrlCQwxoddIYBtpgUjMP1Ktok=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:G1ezpHuwRI4HrwnOmuVPAxbLGTV0gERIYELJPzrQqIUBfwqU+NMse3/BWxSP9A4eHt+upkO5W4VVaRyKjmPXoe36Z8fJ/3IK+u5+cnAphf18l91GABNvFj7v5qM/vhBdTsI6vafgovGFrgjp5dywT4cxjsLYbWOpfEzCxNJlxq+Dz1JIpU8WocJogQDpnzCaUI6H52I5EzbhTHXQSPvisMmDtbPiIF2WCi2MXU0VEnhFxXCo53/kwbbzGA6s2iqR
X-MS-Office365-Filtering-Correlation-Id: ff4af9be-4b22-42f0-c01d-08d59f94ce5e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 10:13:00.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4af9be-4b22-42f0-c01d-08d59f94ce5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 12:09, Bartosz Golaszewski wrote:
> 2018-04-11 11:56 GMT+02:00 Peter Rosin <peda@axentia.se>:
>> On 2018-04-10 15:12, Bartosz Golaszewski wrote:
>>> We switched to using probe_new(), so this is no longer used
>>> by i2c core.
>>
>> It seems to be used in i2c_device_match() ???
>>
>> This could easily be me not understanding something...
>>
> 
> Yes, but i2c core no longer uses the id_table field in struct
> i2c_driver. We call i2c_device_match() ourselves instead of letting
> i2c core do it and pass the driver data to probe().
> 
> Hope that helps,
> Bartosz
> 

But, i2c_device_match is a static function in the core. I think you
are confusing it with i2c_match_id, which is in fact called from
the static i2c_device_match (with is a bus operation).

So, no, it didn't really help...

Cheers,
Peter
