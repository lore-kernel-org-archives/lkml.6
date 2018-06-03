Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeFCHPV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 03:15:21 -0400
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:52690
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750846AbeFCHPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 03:15:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net: ethernet: mlx4: Remove unnecessary parentheses
To: Varsha Rao <rvarsha016@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601020049.3704-1-rvarsha016@gmail.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <afe2c643-ba7d-5bf5-11ce-7e13be1bee4b@mellanox.com>
Date: Sun, 3 Jun 2018 10:15:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601020049.3704-1-rvarsha016@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::34) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:hyHgtya1GBlovptr5I0323O+Y6re4rQaiAy4QR9WgkD6uBmbyWAYMo/OSDp/fjGQaL/+v9pcecIdZcXwtcpW07OH4BCDYqYrRx4LkKniPG2RD6rAQ+0nvtrVgQiSXRBBDqGye/HseR1HXgDaFKWsRVNjPL2s0qZTHSyApp69l4Hz7uNe/PNY1ArGuYt01QnZGSofpAmnqh1nU3AC2bdO0mRPzY2KhVeHzHw0FMOeAvuY6fW+TcK0hMLlJ37hqdxC;25:3ZqQLj1d0Wu446WMfMxIQgptGi3v/6G5XCk++GcL2mSgX6GLL+YxD854c8kDYsGa+2vRa22Ea7YaTbH3kNwWTckOqq+EtsEh+sdXc2qDuzoJw741XtXhHZ9SEF2T4Wzqd7PYEyaR3CyhMBJn04B1ZmSpJyfVsg4Tx3zF2xfhqTpUn7jPKU4o5cdgdAuHJEPHzzbgyH48OO6x3u30mH4xz85becK2xenuDkabgX80gI3cY6YwIB+ZpXQxmiQKvP6d7e1JGpFx3G2L2sPRdGds0E9rboLTmesnLGI3GDBAykSLmsANWaCYroGmDdfd43GNzfdSRITBhLyH/i+EVBnP1w==;31:wzdFKkRda0wg6BuTOJ8Km2dvvV7CXl9GABa6tYChD86CS9/H6rFe6DT+y/X4jQcvHDt/qxZgm7+TLHlEawwtekWQiB56sFXMpDnwg+ZE1jhWgjmx/KSVw6MAvTtDKouqDa7NeMAMqWQJDIkoSEucs5Y4DM6c0v5+dtKLi2WPNNnHVE34UQByQHe9hg4bscFqiHI45DFrWyEfRBpVhun+bB+3uFHrmaVmGDDb9y/rDuM=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:tzrmG+lryXtoXrqyc55+tff9TmeNj6jIZHdUr1rO6kKAqOK70m8KO/yuCEUe7FYjMOvGHdZTmdj6O7SS/Lq41XI9XL6HlxazVXKcIuedEhCz1Q2b+jLocQ9riHXfs5WIpesdaJuawGcB99zBaNd3pgVyBNboX3yWAX8iT5nHuFNYy5O5nWra7/pR245xTNoN4PvlSfYO7HpoAOo5Ww0COQBw3MZGIFrFjsBZ2nn1DO1v7Yadq5+TPHhUDCNJgUhI/28wF82o5ziFnC8g7bEzruhyzAW3IWQhhgXO5rx++UUm1eGedatPN+UswcsP0Jm3LrRzgqw1KXdeXNc3/cPdlZ9B/n0wHiUCeP10iaecyH2feDTPliKe7XOSU/UO87AwRekC/YOsAVBzOpQRYWp/RB9MAzNTzIAKmH9uDNJ0/nv8COgpdL33N1VJlIK880G530RSxYB6gXiejgjLAobvS/knTad5qkMUDA75PjCDeEw7bDxTFpnCVYRnSlrxwJJX;4:UWhj+H7ZCrua29ZCVATvEbaCt1euQWTQmV4X126Efea+ag2lQXUkCWHTudXgfYGxbjylYcS1qx/6Jwlpn0tPmfNEXk4sRpkTnfxCSUb0Ti4c3lDrwsrralvca3Msav8EOT2KAmK1yAxzHBVejMVzR2JfS6jzA3xqRHcH5aezpJ4mdJqD+xal9Am8GaNscB1Lvx07/umwgDpNqfrFJaI6Dx6qnLq0TDCk/kUu2hNXlQ0AUF00ZTyvNjWuCbBQv8nivfwI5rwEUNM1ekzkKckCOjW7zFNQftMWfXDJW4qrLrCUZ5PFfgZQp2jAECZHMiVR
X-Microsoft-Antispam-PRVS: <HE1PR05MB32574D42C611F7757CE50E82AE600@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(376002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(97736004)(8936002)(31696002)(86362001)(5660300001)(25786009)(305945005)(486006)(6666003)(476003)(67846002)(77096007)(956004)(26005)(2616005)(66066001)(68736007)(11346002)(65956001)(47776003)(53546011)(478600001)(31686004)(386003)(81166006)(81156014)(59450400001)(7736002)(65806001)(16526019)(186003)(446003)(230700001)(76176011)(23676004)(2486003)(52146003)(16576012)(8676002)(2906002)(6486002)(52116002)(6246003)(105586002)(39060400002)(229853002)(53936002)(36756003)(65826007)(6116002)(3846002)(64126003)(106356001)(316002)(110136005)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:[10.8.17.60];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU3OzIzOk9WWHJ4NFk0SmpBdXF0elk2Q0d0cWNQdU91?=
 =?utf-8?B?dzlvRXViRjBQQTFzOFFlNXI2aXc1WmRKS1d6TWplMGQyZDhGU1dUVHpHeCtn?=
 =?utf-8?B?SG9WTldMdG9udU0zOUoxOHdIVEZROGI4RHdFSmRrbGVyMTRaSTRjTVRVZGdr?=
 =?utf-8?B?dWJhcHFackx2c1hiamtJUFgrUVBJQWw5ZGVuUzJwTnA1dzFxZzBHNnRNd0Y0?=
 =?utf-8?B?eFA1N3NLVXBjWVMrb3ZwbzhTMHE1SStmNllWNFBGNkJ0UE5JNldFcnVXR3dS?=
 =?utf-8?B?cHF0RWpmc3JZZ1BUWDB3VjgwZ2RxSjJLWGtxU25Ba2JHV3lDeUZqcEJTMGhv?=
 =?utf-8?B?cHVzdExXek9sUHNpK3YyaWovNStSN3N2YkRLYjZxTDB6Y0ExV1BSeDVMQm12?=
 =?utf-8?B?QXh5cldVdFpzTnJublZVYjVVU2FwZUNheTZOcnN6UDFaUTBwTGR0dS9LN1o4?=
 =?utf-8?B?elZDcE55bS9CbWFzUWxxWVRBbHNWcXYxWHJ6ZzU5aFpiOS9vd09oQnpxZTB6?=
 =?utf-8?B?RGVER3AyMzMxNDhnSXNJNGdkRU5tUExiY0NXNXJTV2liRi9FZXRtSGJIaEta?=
 =?utf-8?B?cldVUFZpa0FkdmxpdGxhN0pqNytJVWVMZXAwNmsvYnBWdXdseEd0T3N6S2xR?=
 =?utf-8?B?cHA5MXdja2psM21NaEgwWDlWVEFlMWE5eURaOEU4aHBsREh2aWhRRHArSmJL?=
 =?utf-8?B?TDhSaW00cnlKaEpGRi9vYkFmcmhma3h6dVR2Q1JKeWE5MStHZlpGemVuLzh1?=
 =?utf-8?B?aU5IMnBKSjBRa2trbnlTK0k5Y2dsVGw4ak9wbkpZa0JxaUtzZHNZUkgzMkZJ?=
 =?utf-8?B?cFowSHdOL3dhS1VjMGxSbUxPKy84UFBSWDJ5QWwrVzdVVHdNWFdIczlIUUhu?=
 =?utf-8?B?YTJzUWJvYmRhbFcxUW1OeVVJNHU5L3h2YW5wYjBRdGJuWS85ZGFnYlpjL1BR?=
 =?utf-8?B?c3NzYU9BVHU2R0d0ZlkrandXdGQ2dVM5RTdFVjlFMHBwOFF0ZW9iM3pPQlI1?=
 =?utf-8?B?UXE2YzBIek43azRCVWtLYU9VMFVBZUkxc0oyWmo4aEpTUkFHU05pcFI2ZVVE?=
 =?utf-8?B?bmowTVh0UEt2UzQzZElXYlRiT0lQZmRKb3Nwak1iSlRmR1ZRRk1ralk5OTJJ?=
 =?utf-8?B?NkxVcThQbkZSTVUxWDJJT1pySk5xQ3RmWU0zN2NFYjZrUzcrUUVhR0Z6NlJV?=
 =?utf-8?B?d0wxWW5tOTlIcHl0SjdOQmFzcU4raTQ2alNZSXY4TG4xcW5wYlVnM2JZUnBY?=
 =?utf-8?B?TVI0L1Rsak9ENldXNEM1S1UrZE9UV2Qyc0wreDFLRGc3dWxIMnBnNlRobllv?=
 =?utf-8?B?UjJoaUV6RW9oT1BkVmpaVXZpdjRMdFpYYktXZWFCbkFJVCszaVRxc3pWMURk?=
 =?utf-8?B?dHB2akZDdHc2Y3dlTk12cktaVVRnUjBEMGw4TTBxUEpHZFg0ZHJkOGcvSjFs?=
 =?utf-8?B?NUVRSTJRL01qMzkwdDhZY2Q0aDc2aEFGbmVKWlZBN1B5MUFMZi9qTWlHWm9X?=
 =?utf-8?B?bmZ6RUd2TzFPRW5FZ3pzYUlVd2FWL3dBYXdld0FhNVREU1NXVlBSaUVTR1kx?=
 =?utf-8?B?dG1xd0xZemhNWkRaMTd2ZUFpUHNGQlYrODZtK0xEOHN2Rm5PVWNmUGlxZDc3?=
 =?utf-8?B?RGp2YUMyL0twb0FCaENUREVRTUl4bzl5MHdNWjBjeEtUU0lPYmZsMThubFNn?=
 =?utf-8?B?czZGa2Q0NjZqODgyQ2pCa2pjOHVvRHFUNndQOEZabzJoRE9tMXV2bUUrK1B3?=
 =?utf-8?B?c3BOTmpOdkExYnYzSTR4Znpsd09TUVlPSElUaGh5OThBbDJjWVd5SUVlSTNJ?=
 =?utf-8?B?OVdnRDgwQVVTZEYySkRSU05aeDVrMnc3bHk0TEJSTWZhTDRFbUw1WW1VSFZw?=
 =?utf-8?B?QVdXZDdUL2ZlTGxHRnhkeVNXYVNPQ3hsZXVRVWtyb29aajBpRUpmVHdRUkpQ?=
 =?utf-8?B?a2g2TmdIdkFCSU5YaUh3OExMVXVMTHdjTnovNnJJN2JzMlJ1amI0K2ZjRUwr?=
 =?utf-8?Q?jojpN/?=
X-Microsoft-Antispam-Message-Info: XJkxYbpkvf6uMPr7w8RuNdMVrMsxzPa/vIT56l5yJOvWjj0zc4Z6DrntBUnM2CrC3mQJGlUq/iw31jlhzb3v61AYlmwhc1hM6yvIqc1bo2FeuMTkjBx9MBLZm0bH0QQ0hnTI/kUI+UTKVDcikU3Y11vp0x/LcWTI+eSpOrTfCp5hFUcV6Ul7oztmZsBcd4Zj
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:l+lGDIghjPqLBDrUn3I6gGv0Sh1AakpxA99eEsactizuSDUPYdfNGdelzABuLNx/DoB/I74Lyk31tI5nfbWUX4JVcyKnR+mb3DO0Tg+SAaV2pOg5MjRq4uX/wFONsy5wQ2YshRqHB/qxEAVcWBQbZNMvULlOfTclXG8ItSnTCSUL6BwZueTLXaZavikGFUwjV5J5AO8LoGxCSSW0bkBIvFU8eyyY7umN85M3xkqKYHXvhYfNYHFjIy8MUYjuUSQhXf9PQiWOvftvfIQ7QGn5mfjRLH3xWReljBDr3r+wzW4swQifr47E2wzNqHV0OSvSG07ZEN+MXeL3Bu85KTndxTMUN2udoTs2kT+oa8un7DvnFCW/FmnbyUCnO1ySDt1GIQhR4JpedjWx546X+tRTiLbXB2B5WaLwRTiB47FNO/wSvNJ6GEu++sC5wYZrYdoaGZmj/0Y9yNQ8Y6VGsCEGzw==;5:syj0EhTC63qYB1t/R3GOSDutjqBGaJZKMIXtynoIKebMiK267h2Pb+IY70X0KP+r0aAKsWCJSS/6p/HK0ZHOqAYMO9xJNcA1Zgdj6CPemtn2VuFHo7Q93kVq8841QxbgBdCt3qCWahLmYmxKt2+SFlC22Uj3Mu/E0ewSpOuDzRk=;24:rc5kXFk00xunjEuu2BWHUgmgfA8o3SQfgApFV6agbqP7tWgvZoOzWIhbbxA3XjwSeq9/F7xS30gI0iFHTjkdeq7V42tg69h9sSjqpccuhy0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:rYNl3A0yiebCFzlqSzWweN98LUZysjTm2wBsVWEAyw5m6D6R4HuRIDtmFtoiTnum1DGi+GfOPQNfbxW108MA0nQXMOnmGB90ilP4GC/SctA1CApUjTKudRSNAOE3T/moenmD8tCwM5eE2khr37uzqWfzt1YX/vSvZvHkMp5u307hg1liYADUrcm8LVPzTkjZ0dnSu8IJVFfHtW8+10Eu5rLbfyAgOf1/uIOQ1a56b2m045TxkSK2Cu8Tm90H8/i/
X-MS-Office365-Filtering-Correlation-Id: 024db6db-23e4-4278-1aa5-08d5c921c0dc
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 07:15:13.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024db6db-23e4-4278-1aa5-08d5c921c0dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2018 5:00 AM, Varsha Rao wrote:
> This patch fixes the clang warning of extraneous parentheses, with the
> following coccinelle script.
> 
> @@
> identifier i;
> expression e;
> statement s;
> @@
> if (
> -(i == e)
> +i == e
>   )
> s
> 
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/port.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index 3ef3406ff4cb..10fcc22f4590 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -614,9 +614,9 @@ int __mlx4_register_vlan(struct mlx4_dev *dev, u8 port, u16 vlan,
>   		int index_at_dup_port = -1;
>   
>   		for (i = MLX4_VLAN_REGULAR; i < MLX4_MAX_VLAN_NUM; i++) {
> -			if ((vlan == (MLX4_VLAN_MASK & be32_to_cpu(table->entries[i]))))
> +			if (vlan == (MLX4_VLAN_MASK & be32_to_cpu(table->entries[i])))
>   				index_at_port = i;
> -			if ((vlan == (MLX4_VLAN_MASK & be32_to_cpu(dup_table->entries[i]))))
> +			if (vlan == (MLX4_VLAN_MASK & be32_to_cpu(dup_table->entries[i])))
>   				index_at_dup_port = i;
>   		}
>   		/* check that same vlan is not in the tables at different indices */
> 

Acked-by: Tariq Toukan <tariqt@mellanox.com>

Thanks for your patch,
Tariq
