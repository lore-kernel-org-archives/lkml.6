Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeD3Pkx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:40:53 -0400
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:16033
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753973AbeD3Pkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:40:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [REGRESSION] drm/amd/dc: Add dc display driver (v2)
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1761751@bugs.launchpad.net" <1761751@bugs.launchpad.net>
References: <fbb549e9-88a9-cc85-f8f3-e4bd0157b58c@canonical.com>
From: Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <497193e8-0be8-0353-ff09-7c7a35ac53f7@amd.com>
Date: Mon, 30 Apr 2018 11:40:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fbb549e9-88a9-cc85-f8f3-e4bd0157b58c@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To SN1PR12MB0190.namprd12.prod.outlook.com
 (2a01:111:e400:5144::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0190;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;3:NZkpgS3p3EdDA/00PviCvPFwlYA4B4nLOkveNiA7yj+wu5YjoEYWMQ3g7pKGVwvnhK4SN1D1v/9zaXqRk17Ke5HJk9kLJ+6BGyxkhyRq4JlFTxXtaXZjFlYU8saBXmXLIl1/lx4L9Su5J6IcSV7Ax/Yrg2B20+XsSoFyqueHi2m7Qombag94EmzqVFlDfAHRPVWQd3JB2PqC4Gw+WgmHHqZu2kVqzsHiRbLO42gV/hyuvleRbJGHzYuQXve199AF;25:CKhD79oWC4y1xPCRTwugmBlOoC3oJURoLJR4zYA4OnBf1IZgnnMZC2Q+UBPmLnhkRnUAJsYY16beysrgtdrYGMiUMTxVDkQ2tN37k5BaM18a9BzpSPkE1UQ2pYebbPYIVesYJuTpzPqKBpRcIe/KjGKtHOeaGmClBwxTlBCGBKC8IV4JyJnbW2RGvcPO+UD5d/U+4jaB1lj1+KOW72qh0iCMLngow05uWf8Kyfi2jX6cH0Z4hluKlQQ9FqBtOqnjeDzpatYUs+FgXJzegR+FOtl8ZbHpcIZSidNfpkSWcrTGfPXabF7CY3Yg0EIb9fRPGi6D0tNke/CJhMJrXPueOA==;31:UFAdZmoafN00BZjwZlNd65bzSf3m9tGGSW9AtmleSOCXo+nNJbsqjIzVLD0HjvUz6w3dL/L8CZoaolkG4xvRd4rxWQtNu9Gbh0htuvJckoZ6wUMerhNW2SOICqZGhaOGQAlIX6I0dKcpb+ehPlA9PN25BhqyN0wZx8y+ZUxPMJ/X2WCskkYmRzHK26CXwoApQ/Z2uvIMhy976Vruk0FSlTyk4PpY573T90BvLfbHFas=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0190:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;20:t/BIRjnM+0Y/WxYKk4g0g6bDP1YHdXmnggL0qBDO1Fk7r8DyheoOS8X/KG7cz8pYWZmeLsxj1ltyFNqCFJsDV47IFCTfYAQaHYnvWFerkAOlljbd6T3APq6MFMTeRvamdn9gkgQuvFS/k52/i+ZOR9nTYfcgvDPGjpdp1z0iJBspjTgMyXymRrE1NSgv9ld+ch1ZSBOVH1Tc+4Zqgv1uWbJ8CkF6jvDSqCLj08Aapo3CVU0/RHJT3QwZKCyb5SMMoYkOziZnl1R/4YbSdGXPjQRQ3ySaryyu6jnDriG1d4MQksEAi4X6o3r8D25yNpx5yHhgq6xFBAQYTSn0Ma4lzB03nMlU8UInXy3pTS3Oi/WoRFLBc67J+WLgXbnbXbSlnd3eNEBjUsazgxn/QtKnQzfquiD4u21QblYcB/e9U1aHK87z5TZVzlI+Z2F6LHqLclkdld/gUZ/UDYKAx+eo1dJzeatbvQpZbVwU9wpa0psLynUtEtftrVNcnardXr5a;4:9i5V0b1LQmNL/TtYTzw62gWkaYnSF3BQruTdPSHaqoxBoWdU+71jj4tqu74CQjvlYy2A9VHmDhql//Xkk8iWM/+60KL9A9LFti+0GYZRue5J9vui7kM4Q0buqEzi2hMy7GNKVyPD+tGNdtGxeyeuHTDr67ljr8JeDyY7YDV/dMl7v5DEC0fmI8Uo7FZLljtLLObYHcO81Uo1xGqJP5j7iOtp1Fa6zDBwkFSNyyCGnA70d09tugu6biDm3NQ2AdLdx4rsZhCHbeNnEP0lFK2DsAdsbd9J9R3h+XU8UXa7Gc1eQE1RWv4VnBAD6afvdeuu
X-Microsoft-Antispam-PRVS: <SN1PR12MB019041C90CDC57FFA2BF78498C820@SN1PR12MB0190.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0190;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0190;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(377424004)(199004)(189003)(5660300001)(478600001)(68736007)(65956001)(65806001)(66066001)(3846002)(16576012)(54906003)(58126008)(77096007)(26005)(316002)(105586002)(6116002)(72206003)(31686004)(4326008)(2906002)(64126003)(65826007)(305945005)(25786009)(47776003)(8676002)(50466002)(53936002)(6306002)(106356001)(53366004)(6246003)(53376002)(966005)(6916009)(6486002)(386003)(36756003)(2870700001)(81166006)(81156014)(229853002)(8936002)(486006)(31696002)(44832011)(23676004)(476003)(7736002)(446003)(2616005)(186003)(76176011)(16526019)(97736004)(52146003)(6666003)(575784001)(956004)(52116002)(2486003)(59450400001)(11346002)(86362001)(1720100001)(53546011)(10090945008)(16193025007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0190;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTkwOzIzOndZdHJZdkJwaEY0d3ZsZVgvc2dsdnNWVUdQ?=
 =?utf-8?B?alJybkRaOUViTFJVdUlJVVNkdVo2S1h0dGFoMitWb3ZJdGpYcGIyTitNb2RL?=
 =?utf-8?B?aXBIRSsyQlNZTC9CZERjMG5ZVFF1NjVLekR0eEJoODFrQ3lOSXJ3Lzg1MkFi?=
 =?utf-8?B?bmt1S084MGlObzhrM2JzWW1nVTdDTHJsUTVGOGxpZEVBcEV5Qnhock0xcVNO?=
 =?utf-8?B?N0pweXJrTW1lZGZ1aExzNkNmNE15YldIZ1pWTW41ajhGclRaU0tkM3JmbVJw?=
 =?utf-8?B?ZnFiTmZNNE5OL2RtK0lqUGxjcG9EeTBzRlVMUTVqMllqMUxaSDFYNlVzQUU1?=
 =?utf-8?B?Mk5qUWJ4em9oWFVPL0NWMDVlWllYT0RpTlRVTktIeXlKQUViajh3YmhHdWVq?=
 =?utf-8?B?WjVwRGJxWlRlanRHZGgzUzEyZE1RSG92VGhMYmlTRGVINGJ4UTRFQzB5akJE?=
 =?utf-8?B?RU5aN1cwZTZEeG5KalkvRWpTbk5vckZxMVdhWFpKT29ZbElYWkhXcWM0RFY4?=
 =?utf-8?B?TldDTTd5LzRIeVBjRTZsSlhDQkZSTjRjcjB2bFhlYitDS1habFJaQld2TWFQ?=
 =?utf-8?B?Z2hSdW8vOTd6STR5NkJiRjcramcwYWwwVzdNMVBDSU1xaHZjUWpidDhsZjZv?=
 =?utf-8?B?TnkvcG5DRTBSWEliVFNPci83RUtqWENoOVc3c0R3dHlvU1VvWEtLNm1ZS0pi?=
 =?utf-8?B?OWtxOXJSWVFZZlNvRHRTN1IvZUwrNUp3ajJ0V1UyNTRHYzlmQmRGU1FrWHIw?=
 =?utf-8?B?cWl4NE1ZSnc4Q3UremNMbG1wWkYrZnp5UHdGN2VVSXcwdGRkaE1DNHozdkxz?=
 =?utf-8?B?TXhRMytWeW1TTXF3TElvRUlSc3JqT3pDRmI0Wnp5dTRHdXhhWCt1K2hBNk5w?=
 =?utf-8?B?UVk0MU12dHdwNzc2S3lkYytKS1RIem9BdThtYWpNdkhCK0t4NDBRZW5IczEw?=
 =?utf-8?B?MWk5OER1WWRsUHZZcUpEVTRiL0cvZlJJbjJQeE1wUUFPWkpqMjR1OFRCNFY3?=
 =?utf-8?B?STExamduM0wyUkk3VGl4VlZjb05OV3crM2NPNzhrMGVmVHFjcE8xbnIvYk50?=
 =?utf-8?B?dzVJYWRaR2YzY3lEQjU0Z296SUw2dnMzV3hnaUc1QzNBUnp5MittUFFURlVT?=
 =?utf-8?B?M0pSblo5bG5ncVphYzQwa3JodGRnSm1Ub0w1VjVtcHpvZ1JCT1ZUZzk2THBy?=
 =?utf-8?B?YnEvRGkyK2dqVDZFRlhSeW80blRxMlY1c08ybzMxZWFkSnBNTjVHWStSZThS?=
 =?utf-8?B?UnNJM2ptMldTV09sQldNRldkdjhPb1pCNWVJdy9PcU9IWFRQbVg2cVVvNjN5?=
 =?utf-8?B?N2t1QlBGK3FGMGw3bWlvejBXUnpFSjJqRkR5eGpnb1B2Z0luT1U5aXZIcm5j?=
 =?utf-8?B?SEdVMGNCWHRlL2t4QUp4ZWhnSVVZK3NhazdMQ0EzTWlUSnhtUS9UYXlqa0tn?=
 =?utf-8?B?SjNGYndhZjZXa05iaUVzMjZhS2llWG5LNlNOMFBrVnV3Nyt3MjlSN09HUFVO?=
 =?utf-8?B?WHdjRmVxd1ltVE1xblRObWJxaXhmclBOUXkyQ0xQUmQ2U2RUZERYTGxYSjdD?=
 =?utf-8?B?K2ZRS3IzZ1liTzVUVzJFVXlOZFA2bHJRYVQ5Wm9DZnR4RW5WN1V4TzFiUHBM?=
 =?utf-8?B?T3RWOTRxTHcxaDd1c2Y3YmczN0lGN3FxUjFnMkowTThwV2pKeWxMd1FHRU9t?=
 =?utf-8?B?U3BtNDdRS0JyaWFneUVHZ3VJZjIyc3RPNGkrZG9mWUtrdnc2LytTdFA5OWF5?=
 =?utf-8?B?b1AxMHJ3SjJ1SUgvOFIyaWt5R3BocWNhZmc0NGRib3RmTzVVM3dpeDRCZ1c5?=
 =?utf-8?B?T1lQK3MrZXBUNXJOV29CaTBnZm5pTU9IYXRWRk1NdTUwVDI2RUdPaERDSC9M?=
 =?utf-8?B?R2dKOERPTzQzVzdETmN4eCtKNDUrNUtKUG16dTdoOC9heWxNazRWZGJDRjFS?=
 =?utf-8?B?R3pmQUlCdU84SURtL0tLZ1dqNXJ3WjIxUUc0OXNlOVRmTUd3MjFOaHMyaTM5?=
 =?utf-8?B?dHFJYjlyNXlSUjJXbFBLdGNsUGFDRG1ZL1U2V1BhVFJLRjUvU0VNblRSODZL?=
 =?utf-8?B?UDIwZ2laMFI4VzUwT3F5RnFWSmdFWWJQNnlIdFk1WS9udXdWbTA3SmRNZGFy?=
 =?utf-8?B?c2xWWjM0U2tYVXFnVUp1TUxUY1dNdXA2WHhTbk5aSHVSMW0wOVpOcy9Delp5?=
 =?utf-8?B?RG1tWWlEZGNNcm8xdGxUQTFZMlZrUlVwekNtRzU1UXRYc0tZQnZzbE5Da1hX?=
 =?utf-8?B?YlduUjEraWRmclpoQ0dVVHhPYUhuZ0FXNnRsY1ZLcTVtaGx0aVAzcW1hRzFr?=
 =?utf-8?Q?Zuzh8RkJ3UoXkD9w=3D?=
X-Microsoft-Antispam-Message-Info: NLFhOSzgeddS6Ki0GXQPZ5JAp6b0pe2v2O7deU/DjyfS/hle4VnKQqc0ClnWZT+amEQufFQq6zVcotdtUpRBdspTuagZKe1T7FF9ImBxenpohUldgVe+L40Hy+o81ki+n0G4Igu+lAoxmY+5YQGZ5KEHiH2DG5nwbLjjAZRoPA4qbbo2IydvA5ySJSd4ulWF
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;6:NJi5se366FmzkCBj0B9//f6/RzLGBhCc6mrTkREloGUwd2GF6x7c3cSyNCWISfgzEBiLB/jmW/FlQ03Hzjvfq0Q04r0xIRyRdBM9Ig1D/OeLZvbzOSdhSJYEinLK1sMfvB9d7gGlnDGzAGSMJMVXyUq3+0+6Dr0XkfIEU1PfKhSGCFYs2mGQq/vn6mhQ4zFXYf34n/96Xyt4dW2wLMe2tPeza9IpHP+e52Mc57NjEv1Gwd4OZSJw9JAEpOOx2IXzQEfWFQa0Kj+DiGcjIa19lxnG3Frt+vYMphH2PI+h8AmybFAGqBaUaBsX/Yjmmw3dxInk+KHLrwVaYos6q5D4evoMQVtCJHfQAJA3v9zUfqLQQzqgKYLazhQF/1bBtg+z2eDNoH20lyu4YORVlW5i2OTFdpJvrQNkQ4dtpQLqr20Ce1VRYRDvmJocDH9QnLfi8ehXioeDqQv4qIsd0opslQ==;5:9pvy7AX7+sZRJcH0e91nQyQgLEj8/eCligKG2XNSjV7aj+wSdp1VYgNzd5tHlwDWOGtxId1J7fPqXwMW7cHalXW8Ykgcp02hM6yKSppxui1GppBVgM600a5yabAt3HaFPh8vOlQROIdK54f7+L8uru4MUE9AANWHswx0DG6SSqw=;24:y4LqFdY7tAax986W8y3EZjjGYYJekC53rg7jLPFyvbTLsSfp+H+2rgKgRQFspOVC0pae9ZgJ7dOoiCZNUuZ+OeAdYz8PcepVmX99ZUrWEZQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;7:akOMYDQ4fWf+5fMdeP3xtKWiuW152F9+WsTBeD8AJB+/5o0E1Dq3JqtGEiAL9AxKNw83DnCX3H8ZN+qqiCqgBU4SrNhb8H+DW2zZEoKT0Q84+DXqo6TE321kGNb+Tc0SAPiTHIrM6WhwreMlBi9+Io1QWrHqTxpxn5HDkX/UYpIDBOBPJKaJMzlurA6nQl+ccjHwq0F5xMN/n/E352fzUEB9xhDRAR+fRxmUB66lJxrOQNTF3OKNz/3VG/gUE3iA;20:MDuv4qnmoZiYDgVuNtMHMc6sfh+IARHIjFvgAQjp0nohCb2qJRb/UOlUCNS2KQ0sLZ0v55y8b02F+gd0ImdDXHBvtSQw5QPXV8rlMDLnkpDHnlW1OChnA+0cnvVfKiGurUc0QKD9c902y4EWGDVIyMYbwaFL8jvVyz3+KlY/BGePVHMILxechGMzWYi7LEe5v1ARjQlDzZc1yLV2RFbi1NtNRRGGBKDMYKoRCfGpA/GTIDnkVV5B75uiZ2PVkJSG
X-MS-Office365-Filtering-Correlation-Id: 665f3871-ffea-44a5-a76f-08d5aeb0bf3d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 15:40:48.2352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665f3871-ffea-44a5-a76f-08d5aeb0bf3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replied on the ticket.

If this is about non-functioning LVDS or VGA I'm aware of it and trying to find time to find a good solution.

Harry

On 2018-04-30 11:14 AM, Joseph Salisbury wrote:
> Hi Harry,
>
> A kernel bug report was opened against Ubuntu [0].  After a kernel
> bisect, it was found the following commit introduced the bug:
>
>
> commit 4562236b3bc0a28aeb6ee93b2d8a849a4c4e1c7c
> Author: Harry Wentland <harry.wentland@amd.com>
> Date:   Tue Sep 12 15:58:20 2017 -0400
>
>     drm/amd/dc: Add dc display driver (v2)
>
>
> The regression was introduced as of v4.15-rc1 and still exists in
> current mainline.  The commit does not need to be reverted to resolve
> the bug.  Disabling the CONFIG_DRM_AMD_DC_PRE_VEGA option makes the bug
> go away.
>    
> I was hoping to get your feedback, since you are the patch author.  Do
> you think gathering any additional data will help diagnose this issue?
>    
>
> Thanks,
>
> Joe
>
>
> [0] http://pad.lv/1761751
>
