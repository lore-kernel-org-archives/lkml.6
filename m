Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeDBNrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:47:32 -0400
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:27872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751538AbeDBNrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:47:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" ->
 "Unsupported"
To: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180330160047.7368-1-colin.king@canonical.com>
From: Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; keydata=
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
Message-ID: <2b8c0ab0-e7c4-89a3-5159-6912a4c18a47@amd.com>
Date: Mon, 2 Apr 2018 09:47:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180330160047.7368-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 619b0824-0b90-4320-8dbc-08d598a04319
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0178;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;3:K2FZ30/qYBYYvCZHwSOfVU+s4emCQI2W4ghtpDfhPDXmrYxdHwfBTfsxzMTsK4LwPzrLg5JSvHzqtYItH2bUrRbGAjXkw3D+bA9PE1xODMgeVarlu6TGo033ISInsbwivCzWjkG0rmPVQcpP/K/E7Vs96MzueMizkV3UuoofXdvNlqPkyyXbMuQNBF+MDjAxZuWOjI+nIqkwhlmiQVlsYOH/LMNM1Dp4t+vQM5Q8I1Kfu5mfb/cyu8DMpUFgHPLx;25:9EtTCVetO+bcq44STWbE8x0iuLpNzWKxwPxfhnuomYXwUZ1sizEOS5Y5mcOdWiJxMcRdEwwQLSagEBWq8UJqNPNxrUnGYSI1sQ8GwBiuJepUlnDh3PPoXBck5ixLXbCOYZWAlFmi+wZPYfkNY73ijNrFPIHjN2RdTc51Zoch4PDep6mw0nDZwBUZl7jplonLOc6qCYq7BwLgs43MaHpYuRxkhXSZSBUldSc/UkR1IzWO8vZMRviqaGfCX+Nuksql5fCmEe4u05bLdgvDISClreQP7oxjnH/5fpdmTzBNRxgRUMW4kTp0e3C8Nz/J0a/vKQS16egWB/ZlfncX8DSUlg==;31:3jJgUI0DTi+NevpZf2uzoPrNiRqkM/9eSpbXA7KtOqu6K5flMwexDWXJbIuEilcmpqomEeV7E18z+KH8oWXtSzx0PL7D0GfVPIjlID1geykoH9xYqR4iDlXhxKug9xND0vi9eZ1CwM2JRah2gf/s3NT6QVbrp17vIJ/8obOJmmHb+MOh4ssuzIVEUTQ/HveuxbXTPQwCILInsZkwuzRW8SxxO167j+SzHhL9S9WjvKs=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0178:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;20:accSfS/alfaAw5B4xvvYIJBmVMNHVKvnupW2PdJ3FZayQVb/jNddBaajHjZeoezhS7ZCth8uNB3vD9xDB0JH1OnXitqtH3s7yHYCq9OCAooZZvUv8ORvqTKDlSef3b5D4S/EP8kAzUWBjr1r25lJoNJxMK340naFlJhT/t7kdU6JtCrOSqrn7oYC7wJ9giIs9NLBOCzizCNe92QFUsgXZF1nJCc4yi4LAzEob+zNXse8lt5/LI5tUwrbNro5Q7DmJvs3U3eGmuNMA7IwbR3qPhCxWk60AqMxqBpP6KEAojSLctO7J7R3aY479kNq2gKwasJz2Ccwzbm3LaTzVCXbwSfK44Hv1A/Yrq7UoAXPrb3EHvcN0IV4FFVJrP7giQC7LqeTM37ujssaDYiniehbadA+9LBfi8U1oCB7UMhl3x1a3pVI/LXK0hriyBqe7r99EXSrQKiuHT+M+iC6D++sIhQyBI6OnPyVy07BQFEcP2v4oD974M/9TMuxagKAJ6BI;4:rnxklhqEpUh9ryq5qZNqOPMymvLhEsHBmwVwdtoMnLYXVOHbEoc4Y5Qtk8vVCuRiotEUbPDSU2W8ybUM0hE1z5mYCaIWvsC9CklWB2kmmGCtWI42RGfamQg+FZBzt5qurIsw4JZgDr6UxVx3xCVr2tputGMXUOXArEAWcJfefBpcJjisn2Cnh2/05NnPVkk+uzUSPkLAN9jfbOglzmr65/p16/BOa5QioX2QyIDlSpxJsXiOFW/pREWBQ1QfiG7QVUA9Qpf1S65Dh8OKc2qUduAGcLoxtlB3+O9BGDJr1M+2QCVJhrmFBBjHvcmD4mUorPnuDy3iptHNqlAYXuTqYVovHbknNLZA5V18lZNTtJs=
X-Microsoft-Antispam-PRVS: <BY2PR12MB017878A763A85C25F7FD5A7A8CA60@BY2PR12MB0178.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0178;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0178;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(39380400002)(346002)(366004)(396003)(199004)(189003)(377424004)(31696002)(7736002)(52116002)(23676004)(2486003)(52146003)(305945005)(53936002)(4326008)(6486002)(58126008)(316002)(110136005)(86362001)(66066001)(6246003)(76176011)(68736007)(11346002)(77096007)(2616005)(186003)(16526019)(386003)(446003)(25786009)(16576012)(97736004)(486005)(956004)(476003)(486005)(65956001)(5660300001)(229853002)(65826007)(26005)(53546011)(47776003)(65806001)(31686004)(478600001)(36756003)(64126003)(105586002)(6666003)(3846002)(6116002)(230700001)(2906002)(81156014)(81166006)(72206003)(8936002)(106356001)(8676002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0178;H:[172.29.157.95];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTc4OzIzOmRpRTBzekN0Rk5pdWpDREp4ZlI2Tk84TnpI?=
 =?utf-8?B?S280OHJqdXdCTUxHa1IxZSs3QVgxcTNRUlpWdVlTQ2NPZEhkM2RPMExLWVNO?=
 =?utf-8?B?TUdpM3BSdWZ0aXlhZ2NjV2xxdFNib2VpL1ZjcmdQbzNlSTBJVC82TzJkQXVo?=
 =?utf-8?B?K1ExQWtpS0Y4a2Y1QzMxcHRpckRRckljejlpa0wzdGc0d3RBY3hpZkRJT3hx?=
 =?utf-8?B?MStsVHN6TFUwVVRRUDhWNkhRNFFKUVJVdk5ENWxiSkpOd1Z2RFlBWEVjUGVB?=
 =?utf-8?B?WjJ1THgwZGdLQ1BFZU1MVFdUTGZQQllFbXNBSXErRWNoODM2MFpudGhwbUs0?=
 =?utf-8?B?NEQyUHNSQ2NkaGNtUldtcStjRnhpNFphOUFPN0I4SVk0eS85Vy9JSWhCeGl1?=
 =?utf-8?B?RUM4SUozT05MazM1cXYvTzJCaXpnOXRxMGMzR2RvRGNINzl6c0xKT0dPbjVx?=
 =?utf-8?B?RnB5UXJqSXM3a2hPVXdqSitBdy9DSmw2c3lOc0hxTk55cjZXV0p1QkdLZzMx?=
 =?utf-8?B?V3YyYmpMclFXaFFlZ3R3RWc3dmhZbnBtQ1dXNjA0SGFVU1VWN0MwU0tUallr?=
 =?utf-8?B?bkRIOVNxK3dDVDUxeU1KVnhyaE5xRVZFbXU3cHJqWnJsTko4TFN1bzdFaDF2?=
 =?utf-8?B?S2RqWExNNUNQNWNtdG8zcGMyaTZVSjVjTFJyTTFRZ29yQXprZWRuNXRONVhX?=
 =?utf-8?B?NG1WanV3UVBVaTZ2MVhES29vQ0crNnJTdC90ck5YMEVGMlZSanh5aHllNDZq?=
 =?utf-8?B?VzBNU0t3ekdLRklDZGNadGwxZXUvWitFeXFKSzllRkxNRi91MjQ4dXo4UW5S?=
 =?utf-8?B?bjNqSDBJNytiWEEyR3p0dXZWeEE4TE42YjdUU0gxTUFneFJpMCt4M1EvYUlo?=
 =?utf-8?B?aGcwWHc3OFhHSEJ0Wk1tMW8rZTFFclIySk1DcFpYZUN4Sk9sZjg5UVVCVURT?=
 =?utf-8?B?bEdKYUZiRHlXQXhqUnV3RjhoVVhoTnlNTDB2cU03ME1ubTVIYlZNUlJpVmhH?=
 =?utf-8?B?RS9tZDJLbzJQV3ozSm1pR0FKZGdQZ0lxTXZNNHNyRU9obFc0Y1NmSHQrcjlC?=
 =?utf-8?B?SU91Ly9HYzUvd2dqeXBpSThYbWNYdXA2ZnJPZVd6NFZaZTIrZ3NjbkZocXp1?=
 =?utf-8?B?MzREY2U1NGdCSFdYK2ZSV0tDWUFvM25SMndwam52Q0h0VnRvSHdxeGdoRFdR?=
 =?utf-8?B?cThqcGNiUEF5L2pXU0x4cWhJS0RtYjE5eEY1bERYSnhoNXIvTEtrOFV6U2Nj?=
 =?utf-8?B?cUVOMmdSQzRnZDlhMHE0MW95SWw5QXVoaEprRVN5cU1uUTlvTFNQQnorT3p4?=
 =?utf-8?B?ZDBERGY2UGI0MFRsM1d3cFhvUHlQV0ZQL3hTTU1tMVJqTURHbmVzdVVaYzNG?=
 =?utf-8?B?WTRDZzQ0di9VVEdnWG9kSlNDTG9VN2xGZU5CRVBjZnlQWk1XMEhpcnBvVkpQ?=
 =?utf-8?B?WWVtUEFnZk04NFJBVzZqZVhVVTYxZW9OODFlTlRMZGdvc1FHa2dpNWR6ZE5T?=
 =?utf-8?B?ZU5UTXBUMmJuTjJJcHBaZXRrSnY0T00vRFJDaWVwaVBmYXpXNlNMcWNDbzBS?=
 =?utf-8?B?MVpLdnlqREpDTmdPNTB2UG1IL2xRMldIYzlJYzVNT0lXOG9uZUlFS3YxRGxV?=
 =?utf-8?B?ZjB5MGVaZDA5RDUyazFOUmIxVzFwU0Z0WTRTZHovTEhsRFY0YWVMb1hQaWxk?=
 =?utf-8?B?dTJiWEllZm1sRHBCODdPRFV6ZXJKTEl0T3EwSnZrVUIvVVlCQzhDY0tleVN6?=
 =?utf-8?B?TzZ2SUw4YUdNK0h1aEhQMERHeVNMVSsydWxQVGFRdUlqRGFPNW92Q0RnZ2lV?=
 =?utf-8?B?Smt1bWQrWWowejRjZWQvb1dNRjBPS1I4N2tZbkVUQnNhTFVQL01aTndJZ1o4?=
 =?utf-8?B?VFNsMmh1VW1DNEF1Q0oxU0lhU3NIMWVhOWQyZ1RGVUZHMGJOdUZIT0lESEgv?=
 =?utf-8?B?THpCdnhXbWNHSzJadXlaNDYyWHJDKy9CQWttbHMvTzdZRGlEcG5IWTI3UDYr?=
 =?utf-8?B?cGJ1cUFCZXR2RlRvRkNtYUVIeEhEeW95RWF4dz09?=
X-Microsoft-Antispam-Message-Info: zy5L1zUJgf/J8AqKaP70fwwfiq8IErcRQxFHc64cRqcsi3az/9zNWO+BzCHjvCfizwOxznR/9aXvcJ9vH8PULn7mqk5SZ8EqH6huoy0XffwAt17XIerCkskJNpZMqZiuKUWH3IlIMGCVhsYpTgJVun/Z2CnfQax3BNd0yi4ZLuqgXUsrZ0v1Q8siLUuSM7qE
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;6:1Iu5XZu7oB8jDMsC1fxm0WFqUtoKx2cLDMd4UtKFo62VpRwH309motz+9woiWGCXAw8XWrGaOeLWFEaLU8qsaJsh9qKLR6E4dsOvZ4ZPROgGNfmHy6YP5CSk0xnK50ivE5Bp1/qlGaukZK2r4SGnHbhjx4AGjbwCPs+bt8PI4Ia6lhCxxs+p8OndG6oxcA/f6Y0DueHjuE1KzcManC40puXpoILumfyESZYJICE5g4E0OkyicOAeqQrCbaUuUMH4fhAjPs2ktXc9udAfLj5j+HZooHOS2gfAfll5wkPy/s8i8C9HM+Bf+WHjPkJm9nooRlQMXkanMU2SVfLWIV9OrsxkY6m1vHgRztCXZpFywNTy8ZsE9AgMJrRfiSocTxi5EjpvLrSSqUYLv7ozONnCK3GYslm+H8akszfDK9zK9LcPtwzhm3e0xMdh8d4nXRj2cnBKlMYmf/qPoJKdayfTew==;5:d0SLqQCNEZJ2blBzuvuIsFqw7ej5tW5XQpz1NIoRLOCxuOCB8q9boA5zK+gjy7Rb+WnBAkLV5L4k7rrunJrJqvY8X1ER8MAhOL9lsIhAH1sG3pgdT04fMMpks2tLO3R8UEavPBPZNioQxOnJ7brhblw8GNovJu92g4XzGfOkX74=;24:MC/FrnDOXMM9AIs4J9q6azN0B1irG8crBCR/83WRfBn34IF3bFB/o+nkRSeqYvgrQ21/8BsCdev2OngrZzS8/Z3pgf+1WcmUwJzPy+YJidA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;7:1QgCLmhPtcoXwD7oD2fU6zfuIXM4pZrZjfkYBIaxhPXm5trxQB6KkRtVBPJPumm5f3H3+WvjUZVPvOgvBiRqzmp8k82gfZk+7hCTwqNNM1BfU2r+3pKwz2doNQmy8OY593HCStmGiu3qcZeOUwCJZdZKpbc6uD7tadsgcKooak988p4rKfwbuoqI0k9oXw9c63ThVdrSLZKXd1WEbDQAdQmsjCAED5k1NCqCnvaCBpR9EtxhAd+2HxSLyBbGZi4e;20:LNiZXbGPGKq1YVWJcARS6z2w4tfZhywiIdaRG7zL6XMkhfWAzWsatZBAE8XONQPTqI/jsIzZZ/2Mw9X3krLUkocIp2EvwUiFLPF/HkSGWFfFNmB+w9J68uE7Xck/Z7wMZs2C5gWkhmVPwZbbsqqgKi142aLHkphnlxLGlT/NqkDNSxVNS0sW9cg3I7uK947gi05ngEg3xq6xZYKNxTWzhv8+OgJnPkPfV8CfkO3W7pQktc0CfVT/wtGG3fXRFOyC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 13:47:22.0262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619b0824-0b90-4320-8dbc-08d598a04319
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-30 12:00 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in DRM_ERROR error message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e42a28e3adc5..1df1c91b6ae5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1521,7 +1521,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		break;
>  #endif
>  	default:
> -		DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
> +		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>  		goto fail;
>  	}
>  
> @@ -1715,7 +1715,7 @@ static int dm_early_init(void *handle)
>  		break;
>  #endif
>  	default:
> -		DRM_ERROR("Usupported ASIC type: 0x%X\n", adev->asic_type);
> +		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>  		return -EINVAL;
>  	}
>  
> 
