Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEVPV6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:21:58 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:13184
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751196AbeEVPVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:21:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4: fix spelling mistake: "Inrerface" ->
 "Interface"
To: Colin King <colin.king@canonical.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180522083728.5874-1-colin.king@canonical.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <77704a43-2b78-e88b-04b9-9a2623e8b5fb@mellanox.com>
Date: Tue, 22 May 2018 18:21:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522083728.5874-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWXP265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::32) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:Mey0MzQWMrmH+ibPThS7gpE7EdihNf8CQmhZ7TM3Fpec6Ej80TafmG5XdA1ySjRbyMVJ9GB2WpbhtNvSdybaChv1a8TcLwwxeEds/3tVWjzqQsML+zOnd6iUWXkMmyXEKbdLReoKXo7Vqiq4v7tdhjwWHl0zGYhfCdqx/2+o/e6iPzFYAPZ7L8Q8QuLsc13bupDrNnOoMWFUr5ro9gEOb6/t7Lcb5dw4uF1XL0lksBNggWLOOnDJpXLtLast1iRm;25:Sy0v+wjnadAavzzFZ6fYfxvb1KzycHqsuJkvbwOYvtKq2gjixccaJ7tH2kQ11+UGnxy/HaWWr8qqI1j3gytR26aQtfsNA2upLyQWvosTfDoqXAP0+hnzvqpwuOIlk3236sw1K+ZVTx6GBKhUu67PzUjgDk316Ls8xBQYCKltSs2WG0+Hx0Bq9wB9PZ9LOo5kKgHSLtGEttPvHu3ndUuh/1PIVC0YdpvJU9NbPmBJv6kKgfEA+8HWs1tqNdsWxhk1dUc1rnwF/HgvRKZ/bgJlkFdGRgJ/qrCMQqyaGDeV5RDffwOEV3/6FDkVmuoEJ85IA/i30M2U5dQnfb4gr09ytQ==;31:jiM34aeNCOB+E45b9Ssy2EURvNosABKhT2fHOce08shOt57R3zb/sBpWzCZ2khyKaFGERAT6326GGtv11IeJY8KcvhPptdypBobvbd1X5g9+ZpgiTljvPkx3c7a44ndDjJE2l9GiQShjWBnLE1gFaQhR7ygTKaHfu73XpyfdJjsp1s9dgBXjLQ+LY+tZH9nYk9FNp9LoC0unCaX7UIHu5hQAqNshDdJBvX3ZSvbsMIA=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:o+Y9XihCZOd9W+nYVJH1EvcC9oSlXruXtHpeANvE2j6Peofccj6RJYBb8Um8JR8MjtDCEIxjWdp3gCNt1hRVPY7NPChlaug4Kr2Awfr3vfiGkslICxXFz+Cenkr1Ex/MKIfvXjG6l2dVJB+7VbD5QFu+7CTmhLnplvdsdCK+8B+v+TlyeewZY40qQkchrwBGA9KPIttT8WNZSRcRTIuNXkL9O09vL4ug8tfewgOVhyoed34W5U53J0BeRKNGfDqt+GMCR8q1eIeEvTqq/bww/I+Z+B0WnvU45RkruoFcMLjMvK7rjD9vwvEPvkcP0kbics5ImJjLk2mXNxBmHleqHG9JOKbsfqaBuFuEZ3G9cCUisRDs7D2ZWSkcTvtS+XonuNWgH1zyQpwjh9KX8h1s31fn7Z1oDCZ6aEECmaYkNUFsUawDUU4Rg/Sr04PH9721cC3I6QfoXJzO5XHKR2Ha3r/dfeakPCgQlU8i9px3huiYmOBHUCviM/a3+8J2//w9;4:cJprgcZPj4KAJQmlzYyHTitBwo2iw6ruMnkwf8qKeJi3atGspfKZ/SNdEp/NUoI9PcaahLmDXSJLg0JCbsZm0pXiPtj+4biwUGTQeiOvPgPIDX5mnnYQgzvA8sk7HUPMVvzJmMwD8jot18lBZCj0C6DEFEYMR4KYncke01OGNEmhdRzb0bY943jgLxANR0aDiGcCDyCxI42tWHvZu5rfphCdC95g4M1PilT8rpftrnLV4MkbE7xzLtGthooCBhg0nEyKgaFYgVxADVt+Y+qAtjE5kNxl806h6zfrs+aF+VZjo18QVrACpiZuJVNqAI/M
X-Microsoft-Antispam-PRVS: <HE1PR05MB32570B4DC2196A35A0287341AE940@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(64126003)(8676002)(4326008)(2616005)(956004)(486006)(11346002)(476003)(6666003)(25786009)(110136005)(7736002)(6486002)(36756003)(305945005)(229853002)(6246003)(97736004)(8936002)(58126008)(316002)(16576012)(47776003)(81166006)(81156014)(446003)(53936002)(50466002)(478600001)(230700001)(66066001)(65806001)(65956001)(52146003)(23676004)(2486003)(5660300001)(386003)(16526019)(77096007)(26005)(53546011)(67846002)(186003)(31686004)(2906002)(31696002)(68736007)(106356001)(3846002)(52116002)(105586002)(59450400001)(76176011)(6116002)(65826007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:[10.8.17.252];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU3OzIzOmtOZlh1NjF2dTlCT243b1dRcGxpNWo4VEhm?=
 =?utf-8?B?bXd3RW0yQnMrZGFEOEZicEpLNzRJOHhXQWZ2ODljdGtoSnJIdWRsMUExd1NN?=
 =?utf-8?B?SkdZN1hzRzNkZnhTL2dkRWtidGZrdmQrYjY0NnlCT2Z0K2F2RzFiY2s2ZllN?=
 =?utf-8?B?ZXdmcFhhU0pCRXNjVFp0eTEveEpoT1lzTWFCdU1FeEF2ZGZZZjFmMEUvV29I?=
 =?utf-8?B?di82a01BY2xBSWNTVWdlblJNa2gxeTZTYjV2ZkFnNTF3UWEwOFdwdjg1cmFI?=
 =?utf-8?B?SUV6Y3BDU004bjExVVB5UXQzTFBwUTZCdVMwTXpHb2I5S2ZHa3lXME9iS1RK?=
 =?utf-8?B?aWJ2Q1I0VXkwa2NzTXdLblBzOUx4TWcrWVR6eGg4T3BxSzQ5WFhnb1BkNWFE?=
 =?utf-8?B?VnAvNG5rMUw1SjNROXovS01WcHU5R0cwQjgvamFiaXlKWlNJWDByVzNNZDR2?=
 =?utf-8?B?OVV2ckNoZkt1VGx4ZFJpR2xJdHJaeWVocVQxczM1WC9od29HTklOY2VEL05D?=
 =?utf-8?B?eE9lTXhiRzZCMEh0UFB0cFBtODNnakMybm9LZFVza0N1c3V5VWJHWmU4bHRv?=
 =?utf-8?B?YitkcmVNbGVrQ1QzcHRPVjErclZ6RmJRMXNQbXVsT25IZVRUYjM0cVV1TldC?=
 =?utf-8?B?cEdoZW5UM3ZIUStmeFpEMEFqSnVkQS9xVWVtc2J6eXB1eDJ2M3pjRlVoaVVN?=
 =?utf-8?B?TW5wUGtnQWJxUnlZNGhocVlJRldnei8zNWtiQjlxT0RUM3M2b3dFOTR6a0gx?=
 =?utf-8?B?VmlIeUh6dGV6c1MzRm8yR0U5MXZMQ0N4MTlJRWxyWUxQbjkvQnBoaEgxaXlz?=
 =?utf-8?B?bUdXRzZFWXZmSXk1Vk44U0VRdlZYcGNmakUzaUM1Y2dUTnk0UUNqWklOZjB3?=
 =?utf-8?B?V2lsNGlkWjV5bTBYVmF5T2dWL2UyOHpSZ3pJN1d3UDZYOERLaGxPalBUUmN2?=
 =?utf-8?B?bWw0N21ZVWhKa3F2MzhIYTFTUUFxLzA0Y3F1TXROclZtNW5MdUpud3UwU3V1?=
 =?utf-8?B?eWtQQnVVU1BTUzhFQU12enFJUFBGVDZpUEtQUHNHUFB1K2JRMW42K1BIekp2?=
 =?utf-8?B?bGJxUytzQ3k3aHNQaU1wRmE1M2RzMmd0bWtyNVpJVjJQazdCMklvQk5lRW1j?=
 =?utf-8?B?cWRWczFTelU1RU9TeTgveDhWeWd5c2ZvU1ZwdlJpZWJVc1hLdCt0bkltZGRu?=
 =?utf-8?B?K3htSzBPdTVxQkRMYmRzQXNaRHFjVXhydXFQVG9vS2NRclA1dUdsOG5oVmtu?=
 =?utf-8?B?YkVuTkJQcXpmV1VyVzJOK01sMFZaZ29lNFJEYWRvdU10TTVoYzcycnhMZGFP?=
 =?utf-8?B?dldzbUtoMS9wT0JYOVVyQU9Wd0VOUGFybHNmb3hUQlVMeDExdEJlSy84andu?=
 =?utf-8?B?ZUNDVlcwbStic2o1aStVTHlpK0g2MDlOOFpHZERMVUpvNkM2K2N1VVNDaUd4?=
 =?utf-8?B?K2ZlVUZScHI4bVNCdy83d3dzRlFTL09Sa0E3dnlXS3lRZVg5VkMzVkpFUmV4?=
 =?utf-8?B?VDN1aURncWo5emFVTzcvQ042aG03bTlPbDF1RzRWaHFDNXljS1REaTdvM1lG?=
 =?utf-8?B?Nkt3SHAvRzFIVURBMFJQd042QmhJR2J4ampQdHYxRlBXajMzTTdMMjQyMFdT?=
 =?utf-8?B?ckZseVBzMHdpM1dlblVtMWxNbkYybWRTbVBxOVdmYzVub1h3cm9uY1lMWFdi?=
 =?utf-8?B?VlhUMFdPWDEzSTRteDVXY0tTOU1oZGJpb3NqbHlCL0IxWktWaiszMVNqV0tu?=
 =?utf-8?B?VWJLb2M5NDNWdVpPenN4eW1Ed3M4LzUyamZ4cER6bzdtdS9ld2hkY09YQUJ6?=
 =?utf-8?B?b3dhL2diZkw1b2NXVExOWmE1UlhRb3dNdjI0RmhmSjdwZ2hlTFYrM2lTK0lt?=
 =?utf-8?B?YzhKVTBkQ04xYXJWREZvR1lLQ3owb3JTRTh6bzB4dWtpVmF5RlJuaGhqaDB4?=
 =?utf-8?B?RkFqWUc2c0FUbkc0MnJseitGc0hobWZ4TUk0bzV1eFQxeVcvQkRIRGpPSGFJ?=
 =?utf-8?Q?VW4C4G?=
X-Microsoft-Antispam-Message-Info: agRtYIhAugGsgaBW4KoU741ypBOIuTBhO40CE59i+UgRwSAQ1I64wf/l8ypgJg+P2XBym/s2PDW5r06D8xf9iSoHTj8P3j5IBd6pPXWSZuNA/CzvwnIVn6iXMwLxdzIseEcFN0Qm5nW+gZ1t7wyHIfSNMs45BDUwAS+AGzYIWj1YYIoUoyM0JT6AiPs7EHon
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:OyszR9qfyOVdyqLvzcuhot724IvWBFRBp+I9oCaXTSst2WqTDuuhZ5FWCJLDklPdyv57OQE1AUVVuXSEVT6DUAdylj64MLzVl6Bnw3z7zvCTUI6F6PUKhZPZHmCG/s5kXLZ3hnbVDO8d/8medvYZ8W27yR030ouqmIM9UBuFFEphNx3+9FZskFUtKJZbaa7AedrDPuecIgHSdWhMPpn/xr4YOb3VkD94p4blvING3OBvU9CP5I/klyk17QGoNwEPpiOHqKcnIabBfICC87SrAC8rwyj567HgXqJcEKEdRYLSKlhHrvoE1JyeoBqSiZBmW1sz3Px1XlJnKshAaeGSYRyfkwNiyBYRpl9a9mE9oLp+X1KMkYUUc56xntJnO14J2aTmM8RIioVFI5UsfRfygZP9Kq2WJYCRQDEfVpeeOeNUkm+YMC3rIRWZezFHTq/DjRuNpEmUQkt5Iu2yUwqbRg==;5:9oJD8KbKwJEe3FnSPu5zszSKpvCco/VFn0dmcnExvPK7HBh7WPly2KPAqHQIy9Y6YnXbfNYTDU+YJlaa/NnJLDmKwaL6rKiPotmEDUiIt4bxl2krxuoDsakggPlcst5MyvpR83nwCHu0wSrsYJkSoX6Uh8JYdKGaFBVPnchPUd4=;24:E07YpBei/GzlPxqhqeTP52wdVqUaaNbx1v95gBQX64CGKaV5rxq76tY4NUbA1onk+BkYJh26kfxhmhI99/VLfPzQnPXGrrLCSU6FGnJ9w1c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:pf9wT0QsH2M8/+4Y1QdOw00Xtem/c6OCOh9wKUGRsX5Wl/2rwgZswsgI0cMudiITzKQx9oSk/HgMA5diNBQtAFEbpURafDLKQKKGyhomO7DOF0EidwOnXyO76bA7I4Q+saR7AxJk1Jzwa6ERdrUlSsRDH0ubZSPJ6gQKJobGr2gf6VW2W/vrOxd9GKJUUi+ky0FHRDJs24JfHRL6jZGqsInu+m1/xnmnE9FUOt/xeqlXy+OrgbpM1aAij9+Cq4VE
X-MS-Office365-Filtering-Correlation-Id: d130fd32-9979-428d-ea91-08d5bff7b980
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 15:21:42.2385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d130fd32-9979-428d-ea91-08d5bff7b980
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2018 11:37 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in mlx4_dbg debug message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/intf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
> index 2edcce98ab2d..6bd4103265d2 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/intf.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
> @@ -172,7 +172,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
>   		list_add_tail(&dev_ctx->list, &priv->ctx_list);
>   		spin_unlock_irqrestore(&priv->ctx_lock, flags);
>   
> -		mlx4_dbg(dev, "Inrerface for protocol %d restarted with when bonded mode is %s\n",
> +		mlx4_dbg(dev, "Interface for protocol %d restarted with when bonded mode is %s\n",

Thanks Colin.
I think there's one more thing to fix here.
It is redundant to say "with when", it was probably done by mistake. 
Let's rephrase, maybe this way?

restarted with bonded mode %s

>   			 dev_ctx->intf->protocol, enable ?
>   			 "enabled" : "disabled");
>   	}
> 
