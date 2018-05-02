Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeEBPEt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:04:49 -0400
Received: from mail-co1nam03on0067.outbound.protection.outlook.com ([104.47.40.67]:32858
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbeEBPEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:04:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] drm/amd/display: clean up assignment of amdgpu_crtc
To: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180502144316.32056-1-colin.king@canonical.com>
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
Message-ID: <fe695f10-eb1b-f6f4-ae02-c2f12225992c@amd.com>
Date: Wed, 2 May 2018 11:04:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502144316.32056-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQBPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::40) To DM2PR12MB0186.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0186;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0186;3:1BuCJzer/li9Cp2Kbr/VNSNccxbMy2NZEqBw44mB7yR3OcmhQ84fogKtYxgmJL81j2ncHYgNlGwwktIWULfkEupt6bJqZmnWE8xsIJdY/V1ilK2MHV6x30LkKRMca4eh1FTDjfdPfaAnlPWmK5x+oYrX8+8A2U13pfRfosIMnSZrhru9fv4dDzESJPt6ibdReG8yGX0vGEOKS3N3au4Y/AVja5jMZdnzDV2xKF/egWA9rw6h+NllVbogscB6oRHP;25:mrCz+xX+yTQg3UDpdjvGej8GNLzemmPPCIuhlLPV2GdSN7uFP8+2+WLv/KSP0eoqQpFty5BzowignoUOMfUPV4kohsNKuIjBx8QOnY5ucYrKpYPyRCbPnnlqt3BmWFMErF+6Y9l3WWwP/aEu+8z9ymKfu3UM9DqbpoGiZp+pVAj+XC1PxwRMp1FmOmuZ3vVKEPDP8EQuKCXixRNB0tQ0x2nTJpItlH2XII37NAQ1HAw7cd9dP/71psvlQXr/Q/w9ilRkmG48Y8oEEHPmfxvxTlKqeJ/e7ShGvYveIqnOTekAQGeMxTjPKnaVTWJJzPBaTU5nVQ9xNBKTbRUxDnr8ag==;31:8MfFfypKrdd8dzto1SzrMD1YsLUJbqxxQcROpOOWqds2mxL//RAM6JSgsEsFd0mzWbl4l04jrT5RBYbOTqKc+1eu6bk8YKqGq1hk7m6LRwYtlOO0iDJSsABE4JlvSKYBO9bb2erTyCZeFjszy7Rn/OZ9NSz2UwqD4S7E8FH7cyoBAhVAyJFpbJUtI6MO8wWRkdJPOU4D+E0sNCqUyF1QwtsI5ReQjRGQqqPvL9rj6nk=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0186:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0186;20:1/XmmrUrRh6p38389TcWuSDKSYVH+29kh122lvQpi6LfJvwBte5JcwVpa+zzD8J2Z8adVpTZIQ7yOzs3DKE4Xl96JfNYsHNxF2wpm06EgpytlymqJRQREWRpwrZoapLIpaSWIOklrdtvV9CATvep5I9ew+jxoCyqpznzWty8PxSseKP/01NRNoSZ19QcoFJeHCudz7QuHSUdtykZ5viqRtyKhnbiwXLAXpbocjp5o9CjWdXvWSxZWcpw1Y8KdYXAbwk9tWFzmQcsQWz4TKPiTwuGxr81TcUFcgftUKyfP9itZRSfWpKrAY43o9x/NKuuTnWHUW1n0e66jy5weHLBtygHA6lkSY5TLF2yPSaSoCU2tGEd5D+2AyxhPBOHmnHZbGOLgyrW9iOjmDrucf0JjwP/itz4KBBjhxjSmbMQF6ZKwhXMFkMk9McYZbSqbs7c3InNCnJQQCUNWH7dn7mc72Bhi7TKMn21hfy5nXf5ziup4HQqgTbP1np50HdYSRgt;4:bNAr94+ihZ4UKtrBPpAl0ScfmDLNsM3uB5/b1OkVzj8TYP4E9+BW2bidlH1x6tM2bV+KZ/2m+551D+iwxx1FNZp9RPp6NIEZY86h5po18jCfHCBjIzJrm6mWTXuD1SsLCvv8+COo34ENmxR79pwQexryAhLqQh5wagyw362ZbrIvjEwJtNRvztsg+Pl9vN0BANzWFV56rGjnMIFuVJ/3L+kxrfOnJ9TX53W3Q/K0VYm+fTrahPdLwvF8tiivty9jPU+/9lCHEhiBpMaVYGrVvq2i56betFiyNurqJfmykWx1P8bjdMFRAZc9IoCd4KeIeJgT0wAWfujYxqX5VrQskQ==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01863B91BBB85D3BDC9DA2FD8C800@DM2PR12MB0186.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR12MB0186;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0186;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(377424004)(486006)(65806001)(86362001)(229853002)(77096007)(230700001)(305945005)(6666003)(52146003)(6486002)(23676004)(53546011)(76176011)(386003)(97736004)(186003)(6116002)(59450400001)(36756003)(8936002)(52116002)(16526019)(72206003)(25786009)(2906002)(6246003)(2486003)(7736002)(16576012)(3846002)(66066001)(50466002)(47776003)(106356001)(476003)(316002)(53936002)(44832011)(2616005)(64126003)(31696002)(5660300001)(81156014)(956004)(58126008)(31686004)(11346002)(105586002)(478600001)(81166006)(65956001)(446003)(4326008)(110136005)(26005)(68736007)(8676002)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0186;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTg2OzIzOndFT3BabzdpQjIwY0cyYTYxQUd2TnZXTlQ3?=
 =?utf-8?B?amRiMGZJYW5oYkdjL3VMakl1cjJJSTAzdjRUcnVHRHFiNW1WRDl6QVl3c25M?=
 =?utf-8?B?Q2NyOGp5WE1JdThlYmhHaXlwK25wREd3VUdqb0JNQmpiQ20yWUJKc294S05a?=
 =?utf-8?B?ZUsrZzJGQ1YvaEpUWHRHNEVvYXN4WGdkYUpNSVJPbzV4TmNTRk1hdTFhV0FV?=
 =?utf-8?B?aFNpd05QN2k2L3ZjUGg2ZXRybi9LWlBWL2x5cEREM2dRUHE3SEl6ZVI3Qmdv?=
 =?utf-8?B?UitSMFFzWkJaVTc2N2RqbVVEaHNJbllmNkRSTHYyN0hzeUhMWWl0MGFpTjBy?=
 =?utf-8?B?cmZrTzJSVm96VW9BNFh4VFJ2bEhRQmo5dHpyRVZ2RnpwekdCODB5RTFhK1JX?=
 =?utf-8?B?eXEvSjh3aTRHYk9LUTNXV1NpcTFxd2ozMlUyN1hDK2crMjd2Z01nWHNYTWF0?=
 =?utf-8?B?a1RoVDA5UHo3R0N4cEVGUkR6UnY2MkNvMkJPdlZrc3VZcld6aE0zSFU0Q1dm?=
 =?utf-8?B?NFErV2VKQnZlSDJVUENmWHE0ZWpLY05iVndDNSt3OURFa3V1WHl5dDIvTDRo?=
 =?utf-8?B?V3lWbFllSHhiMWZUNFREUVdQeDJrTkZ0RGRoN3dRczZSb2U1TkVrUEJLZkht?=
 =?utf-8?B?dmNzbTRaQyt3TFlDY1Uwc3RXaHZ5dUFzQ2JtbW9xZDV5UmpQdFFWLzRENnBN?=
 =?utf-8?B?REtmVVFkZVZobzhYNURzcmg5Q3VubVhyb2xTRXNySkduOHp3TWpoVjBGWmR6?=
 =?utf-8?B?WXpTZnIyY3hlN0RiR2VyeUZwVEo2ZVhUOG41dmxVSUJEbHRvZGE3ZEJzekRU?=
 =?utf-8?B?S0dEbmpGMTJxOFV3THBwd2ZoVzVuVHJRdHZxNnpyVnhZbHFEd1o2V3FjMnBB?=
 =?utf-8?B?cTNsTHAzbVUrcXYwNDhVYzYzUlBMQWYrdkY3bjZCUEI0N2hlczZmdXljT1E0?=
 =?utf-8?B?cmtUbC8wcFUwc01ZbFdsdUVUWTNHSG1xWHhuRUIvODdnekZka0tKcDBhaEpC?=
 =?utf-8?B?bEZJdGJvOEM3akg4czB5di9kSjliVFV2Z1I2dm02RUhCQnlYbXFYUHpaRk5k?=
 =?utf-8?B?b2RNVHF5RXROM0pNRFcvL1ZNdnZXTFdpSzFTZG9yNmk0eUdPaVZoZmlBWWh2?=
 =?utf-8?B?eVJ1MmZCckxtZVh0UkdqWmtZWDZHb042cVlwaHVJVXhGbFZKcHplb0NJN09C?=
 =?utf-8?B?amNjSVpCWS8xeXRsOUdIS2V0YUl1SHRUeUxUbDFBUUpiZEVMdlhJYXk1K0VI?=
 =?utf-8?B?SEpHSllRZ2Q4ZWd2MHd3eXdFV2x5TThqdGZ1citaRWpvOVd6aXdHMStwelJy?=
 =?utf-8?B?SGNTbUJhUUJHdEMzQ2s4ZGpOVW1GbFhIeUd1SDBkdmRiY0ZXT1VUcDQvOFhU?=
 =?utf-8?B?NGNqUXltZlh1aWFla2x0OFlrUGFDQ3lRRDIwY1ZLS01KenltV3h1eEo3REpp?=
 =?utf-8?B?YVg0QmZEbkcxY3ZrMU9HRVpTQWxySHRrZlg4N09vWkJRUXNxMENwU1hwQmdS?=
 =?utf-8?B?YjY3bWlxT2JWTWpFYWIyaWljanRaTWFtSkxvUVNpZmJJK0xPSUtLeUhVWnVj?=
 =?utf-8?B?bnJ5VUtBUzUwWUFISHg0TnBqNFdGK1BKMURrZUYzQVQwUWlLR0JOWDhnTm1H?=
 =?utf-8?B?a0FKNktLMmIxODJQTFd2WUZKeFBNblNGS1FaZ0dudTVWVStudFJqR1ZVcXJj?=
 =?utf-8?B?NUVPNUZHa1c2RWNwNHdDL2RycmZtMjRTSkh6MEY1Vnkrb3RxbVRTUjZ1OHla?=
 =?utf-8?B?ZEF5MkdPZmZ0SW9kcmZSSnpoUWNXbldxdlROZGJVVXNqTnROQXJ0WU1FWU10?=
 =?utf-8?B?aHdOUklVNDJIenpxeXRLTG00K2VWSFlPV1dIVGxDQ3dlOGRxOXE4V21iTmFv?=
 =?utf-8?B?NXRZQjNqNjJHTHJaYVAyaG1UdFhjQzdzMTVYVzJwaEpuTk95ZkhXcmRUODlu?=
 =?utf-8?B?MmpKcE1zN3pYalJCWHFBWDlXTlM3V3ZTVlJMV2xqMityR05KdDlzcXBFZVAw?=
 =?utf-8?B?aDVuc2pIVHJOZ2Rabml2R3VHYkpGdWFYazhqcXdEVTNjZjAxeE9QQWNMOGtj?=
 =?utf-8?Q?gJeg=3D?=
X-Microsoft-Antispam-Message-Info: 28ZmJBkh8UFdqDTt9xKJScpAadaZvzMRyyP/G6GafqJgxbp6oDHzaZ5NBeyeHmC3etNmeXpFuNyEOqKFhoR1ONUw7Tc9lGVn/DO7M8c3AI3YafqhiUg9b9Ko6wYDIrj4P9sVwI5gM2Hr7N1ryaATrJt9HvGNdzVjcFlVcVBJv0wIxkLrAXSBchSdDfdMHDzb
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0186;6:x2/HQPgOOLMOc6FPzbRecNzO8QYMTfwtsGlLUzUpSFy7C4JGInw5ldRkjkrOV6NW3Hc8T+05+eFsogk6IvdMnO0Mmmlt0Go6CeqRzjqXs8cm6gG324OfwqiUBAMpWPxxCeDBFraknI0wQpqnZHmjlZyQcz7PdgUy+4q89eoCOCmrbef622sHRQDdFoh9694rgwZXk6Eryh4eYOMvkduicYnfwH7DozM69VQc4iXSrP/+DDRpfA1j/FpWqmBZmZ8BrX8L9rl9RJLXIN1fpHSwVwnVD7d1XbOnk54hLdJbuNQX7A5asOuMYt1Et+tgTLLetoNymhGwFGmqqbt4M0OKlv6zDVi5oli3cm3WLCxbJJVrZSy5rcUugWXRDrLgeuK5bejDlh1qP/4NQOPpxLYlRAM4O0sO6B8PlrjwNQg01W+5W36L8FH+fiCsD6rFPC9oC5Ed5Oq0hJe1AZszy/cCMw==;5:MiEe8BdMij7OLK5q2rI77Y7b4aEo5xuD+TCzvRh3WMsi0geqB0vxHkydyyD8dny81Aujkb84KTOhhCZq6cAE1jZiYIgd5ZxBajzh/uoVq9V4G1pAl3AdoQnOKZZXJRRgJBhogJZPPdTtrHle1ftS7Y6Hs8zqDh9Pn9cM4f+qHVE=;24:0UxVlowvf1K7e0S1uhWw91yCXNiUvtwk2PmHCiq9WrrBhxAiFc/lnlNn9+qImZHtsKFEBQIb0wV5XRJbkWFaAgHxwpSM1fJupkyFX4oaKuI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0186;7:h8LqSzsOugwl7zFq8MgV8o8vioLgF8UwF5wYuuByqBdCJDYW4UE55f+5u4+IUVAq9uy+ug0U4gvCnMSvkfFyeHNyM+Up8RGlbNpzH8C4AP5iOsm5Tb5ccOsstAqs6FWZmMPTwwSBBazWA/n+6cnBs78vvXp8F6nZukc6jJWFUhFjGO/La5fZIQ1fbLPxY1vlmpxIiU4joIRsf9/gqlSHY5dwFCwnqXFoVXev16XluYc08VP3oYVkko+17qvNnag5;20:zVSaWTV7ryQ2g6q40ZeyXrJNFhTtWaRdCgmp1LYXiYSdDPE5psvjW1Vp8pow1TwChCtzQlckzxDXwCwhp1BM/i7xsP3NBspTgPDvU/aoBU2ZiIMcu5Hg1wZB5ve2WOgOBARbfRHtl5TPJoSCVvfZ7SDlJqZ2r/GLYrIrLQ3500SNekd/qQKUmvLR9a0OAG3a/bF1+tDIIKy3otOwQUFDDz0Z0p80lnoYeE0eSyUKoZ4RlU97UaSaj9027i9LLpMR
X-MS-Office365-Filtering-Correlation-Id: 5927a6e6-2b66-49f6-51dc-08d5b03e03ea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 15:04:33.3879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5927a6e6-2b66-49f6-51dc-08d5b03e03ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 10:43 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The declaration of pointer amdgpu_crtc has a redundant assignment to
> amdgpu_crtc. Clean this up by removing it.
> 
> Detected by CoverityScan, CID#1460299 ("Evaluation order violation")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks like i goofed. Thanks for fixing this.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1dd1142246c2..2beb8821e19e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3773,7 +3773,7 @@ static void remove_stream(struct amdgpu_device *adev,
>  static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
>  			       struct dc_cursor_position *position)
>  {
> -	struct amdgpu_crtc *amdgpu_crtc = amdgpu_crtc = to_amdgpu_crtc(crtc);
> +	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>  	int x, y;
>  	int xorigin = 0, yorigin = 0;
>  
> 
