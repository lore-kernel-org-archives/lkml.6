Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEVPZt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:25:49 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:46208
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751245AbeEVPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:25:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4: fix spelling mistake: "Inrerface" ->
 "Interface"
To: Colin Ian King <colin.king@canonical.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180522083728.5874-1-colin.king@canonical.com>
 <77704a43-2b78-e88b-04b9-9a2623e8b5fb@mellanox.com>
 <297abbee-1f5c-6159-e559-44d83ddfb7ff@canonical.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <6e1c71f4-f2f5-7a84-7d86-13e660073f44@mellanox.com>
Date: Tue, 22 May 2018 18:25:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <297abbee-1f5c-6159-e559-44d83ddfb7ff@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::36) To DB6PR05MB3255.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3255;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;3:rxY9FwCVr+iy4Yoga7VjUr3R1hgLeCYCbmJu++xMBqUwKMd754MZnx05I+y4eNh3O4C7qIUvybTjTt7dUw83I+i2FeB9vPnmuB/kFWxhSaSMMkcP+u9HRMNs5KvlAxAkGm/Eb2NQEHahvKNDmydLI7xwzrRObYo7U9RPc430XFQwnTlQmUnfmKD9dd8Zrf8j7Wk9WCmovycxXZKkL+4OSY636ndCrqEiSOl3bIW5L5d14E4WMiQGUq/dyls99A0N;25:XVjbhbnG7uVGS9kfA5ddzLO8127HBiwlbsA7/x5s/LY74XcN+5QEpxqrkWLgE1U+7Q+iDtwE7c6+9iS7301sSHhrh/hY3dyz10K60yZPQcuguMn/htwMfwDylDP32Jh1isGscqlItjV2g7CoXjkuhXFWm2byMOCEWQmNqVW3dp7+uK6De3f7tkx8hoVQ++ziX2ABQZu6sqFXjWfq8ZflcmjPClC0lgSo00L3k3eFRSQvHPKDRNK72q/hHOGQNc81Xrt2Iz6OkNfXFlHU41H9MFTig4uxiJeo2QjBO/itGyiBsPxWkn0pJsJ8UPYuUGC2jK8ypKmJmnTmwsOuCYy5zg==;31:yLiZvpjrhft3HOr6wBYHhlpvBZeK7pydH/6xMqkSUADcPil8eL5M57bgRHC5skQODeF08t+E0brpYeH7e9PUHYtzrr4HBVYUwUo5BATvjUQwEJyAcFvU0bOh8UKoX6FHMCdLtJQFrQg5ir7Lqt3I1IKDKfDxOlHLxbu1DT8w+SVdfTIzQGkImGZGQCWbBpIZ80tjPnHspfo0aq2Ax2Kg11nwwctRgG2rjB64fEylRz8=
X-MS-TrafficTypeDiagnostic: DB6PR05MB3255:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;20:Yg1SWmFLehvpLDu0V9JLv4axv4jqJ/Aa1CpN33DZtd0Bk3UlubU1ChdNNMbSgG6GubsPlxAa/aBSOQrueXEtcCBpU7vWyPhEsz3Y10yZN66nEdl2W9qyz+BOmof2MmXwcBLyTscOvRZCHO9LK6sc9VjD35SB14uA+UyYD+U99A0rOI3x3z/3vx/pIg/Ciylar3irWUg6HiaE7Mbd6ClDEdSQjYADC5cLqawbSUcLzfkc2o6KwaE+umZh92n/Xx8vCzpZPauL6k890UUqE3FX4nFNULVguZJ4M7gerRwKyTRDjcnjCSp6EIuumFiYomyCMDPRFBseHALDJPb7v3f9Tlmt40mYkr/iTIGStNh+jw3pZyO+6bbA3mnrB6sOJWmk56hl5DSKGGGtZP44f7QhB9TKzJXyStlDcq/wVru/IPlY5TemN8QLmbgiKrakr7YfoIUzJE9WqapqcPc4LkbWGNP3Ix7mC47gCWwCGIDzlscr1PRiLjhf5hKc7QloHwRd;4:+MZSl0Zlk+RddVAwWNEEmNkDnM9eANpRYemj1hLQXjjexKHVt1YlESpLHq1fj6xbYeUsWlDsuvaBmCJwfYs3p9HtbOQGQUWyfOqS46OqLt043tFEz9RgLRClEHlVP3nSxrsN3rOkGF//p5z2B3qjq0a+HEfqK7A8YcLlYlQVcC6iC7trEp4AA2zxVluNMbs3sMGT+DWDT6KVrxhXL16gNBD2C5Gzrhr5eF6HOLXEnKDCAv45uefr5cjIQFCnr5jqgEc5IGqDphVQLoPa7wfdU+KOMqe3Iww/2baovCsxE5qUMWnj9r1OpI4RDWHk8RcSPHUX7zCz+upz5DRdwCcFf+AOCrssiGx4qxypIamshnM=
X-Microsoft-Antispam-PRVS: <DB6PR05MB3255AEB4A5FFCF59125AA3ABAE940@DB6PR05MB3255.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB3255;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB3255;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(2870700001)(6306002)(53936002)(64126003)(52116002)(53546011)(58126008)(2906002)(68736007)(59450400001)(50466002)(25786009)(8936002)(97736004)(110136005)(3846002)(386003)(6116002)(66066001)(65956001)(65806001)(5660300001)(65826007)(6246003)(81156014)(8676002)(81166006)(47776003)(16576012)(4326008)(316002)(52146003)(23676004)(2486003)(67846002)(76176011)(6486002)(86362001)(305945005)(31696002)(7736002)(36756003)(446003)(229853002)(186003)(2616005)(486006)(26005)(77096007)(6666003)(476003)(16526019)(478600001)(956004)(31686004)(11346002)(105586002)(106356001)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3255;H:[10.8.17.252];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjU1OzIzOklKVWZXRmtHVHNuZUhVeVhjNzZMSTRjRjJa?=
 =?utf-8?B?R0RYZmhZL0FJSVg0S25kWFVWekNVTlZvODJ6Si9QR1VYZk40ZkxZdVN4Yi9p?=
 =?utf-8?B?b2ZBT1Yybk5wRFdiMkFjdW9VR3pVZmMrenRYMW5Fdk9nOWlIZzd1K0ZCWDk3?=
 =?utf-8?B?aHlDWGZOV2FXb2c1Q3ZYMXpaYWFSNlRydENtNEY2NlNLQjVXUlZoZjZibG5C?=
 =?utf-8?B?eFNGdm55SERBZnV4RXNLV0lYL1hmNVp0N0ZqTWh3TXdBakh2YTZYd0pNOVhx?=
 =?utf-8?B?OHZubU5TMlVWZGx6Z0YyeGo1RmhYYXdLQ1JWNFplTU92QTg2Q2VsRERCcndt?=
 =?utf-8?B?M0ZmS0kyZE5GMEpRclpVemdTbEswVWhvZmFSZzI5cmxMTXJZcVJoRnM1V3V5?=
 =?utf-8?B?S2grcHNNcGgydlJ5akwzMHh6SzBpMklDYmNwRkVXNjJiaU8yMzQwbThxQm1H?=
 =?utf-8?B?amxpdkxBREtwa3k0eHZHNlRwMVN2aThFbU92Mlo3UEZDSkhPTk1xMTJxMm8y?=
 =?utf-8?B?ZXJhS1RoUzBTU0lpQVJxSTlHQ3ZWcEM5YmF5K01KN2h0cU1PZm1LQ0lhb3pk?=
 =?utf-8?B?QmJzdk9XekVadGN4bzNyVWliSVlGcnF4ekdXQUZETjZKN3ZGbXdDVkIzVVZv?=
 =?utf-8?B?bmZHUkxHZUNURzQyWlNQZEt5Vmt5Z1pkVVNLbUpSUVRKeW81djNpV1AxZzNH?=
 =?utf-8?B?TEJaK3pZVEQ1WWEyQ2s3dFRTd1BwLzR3UlRXY2h2bDRDaUM2MUd2NWN4Mkpl?=
 =?utf-8?B?TlR6L0piZXdwc0MvaXJXV0padzBvTXVVSnhEUWNxaXNSZWE3Y29GUDFzTTlN?=
 =?utf-8?B?aFFFM0YzWlc4YnZWMFM4MG96N2hhbnN6VFpEd2djczdYdVdEOTZ6TDUwYzlh?=
 =?utf-8?B?Z2UrQmR6elM5T3Y2bkNqcGVhN1JVaEN1QlozVkFaS2U2ZFpRVEFJMy80Yk1M?=
 =?utf-8?B?NkdIbE9VajlWTkVwd1g2eHpRUFlhajFFY3ByNFlOYTFKNUVHbTN2UW5kQkRs?=
 =?utf-8?B?VXhrOWVFWDFpOUZGODJZZTV2N2VHd1YvVzU1L1NEZmdRcFVTc3plNE11a2Nz?=
 =?utf-8?B?cWs5V05kNUU4YWZTeHpqY3pUYUZYUG02SEgvMG9zTXFXaEZPSnpmNXJiYUtP?=
 =?utf-8?B?MTlWOVlQaGNxRVJuczgySzVZQis2L0lkU2QzOUdRbFZIZ2Q4WVI0bUY1L2Rs?=
 =?utf-8?B?ZHBGTDBuR0pkOExYYlEwR2I2TDFsSVZhazBvQStTOS9YSzl1aXdiWDNyUDg3?=
 =?utf-8?B?SjRMeVJxQW5ma096NEorU3dRTFZhc1VNVlJscFlLTUptQ05obVNoNTNPL2Yx?=
 =?utf-8?B?U3hpWDF0QXFRMGN2R1ovYllmZkFPMGx2TUcrd2RhMlQ1U0NsQ3hGbURYMnNU?=
 =?utf-8?B?ZENkZVdFK2JXdXBiV0pma1YxTTUvQys4WlYzdjNFN1NUWk03UFVqZmVtTEZQ?=
 =?utf-8?B?dEM2cHR5UW1sZ20ybnRieG9qd25HOGRPZVM2ckcrdFhUNkhWdk9aZnJ4cTJm?=
 =?utf-8?B?cUpVQjlpaHN5ZkJmd1BiMmhVc0FHVzM5bmM2Q1FOd3E4UUdhcGJoZGgya0xw?=
 =?utf-8?B?RzM3SWE4QUhrQkVnUHc0V2t3ZEZ0M3l5azE4UkN3bGpzOXlPTTU3Q2JMV3FV?=
 =?utf-8?B?bTMxbWFWbklrMUhydXl3bHg5eHlpa0dxa1ovR2RRVGZzOVdzQ2xJQi9TU2RQ?=
 =?utf-8?B?dUQ1MS9mcDlBMGdIUHY1dUlqZWRrUVVINXh3V2dQVis1MGhWMnB2SWlIa3J1?=
 =?utf-8?B?U1R6RzRFZXN6cldmbm8vSFFuZG5Qd0JjM1JpaFV2UTFZdzA3WiszYklVdEEw?=
 =?utf-8?B?cExLZWUwTXZRamV5SHNxcGNBRFlIaFZDbmM0U3lnRXZoUUQ0SjZYUUZBQnVI?=
 =?utf-8?B?enQwd0sydE1UVkEvSHErZlc2L0RpME03QmpJQ0pyWitVS1h4WlkxQ1NxL3VM?=
 =?utf-8?B?ZXRHYUFlNWdBNXlteDZBTXg5ak9kZm1PaENHWEgwV0RlSkJSY2lDcjZ2eFBu?=
 =?utf-8?B?MEtxMVlCNUduMFdweGJzNDZacEJIa1FDOEVybDdiR2hvWFlUcE51WmJ3NE5S?=
 =?utf-8?Q?jz5s=3D?=
X-Microsoft-Antispam-Message-Info: 063GT64GxZo0PV1Zije5BUpfbTc/gC4o8r0J7GyNIoaIKqQT4U/9Vj7PwNGEqZaFsbHtNVSvfDL93TCbbRfYgcZoIkYZO5f8VOZbP9Uia8AaGJDvHtY6y1/aH1hCsNJgasQBp/f6cZldogJjvF89xg2PullrSWa+Urd+PhELmEmsLf1yFqxG1eqV0OptmFJr
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;6:dR8JX8kpo2Ni+9b/Gnd0aO/uG6WlPKmyABAM84yt6MHmSdnvXZjUY4TM5vUq/0wCDoB25wqmE39OYdfH8EzUAbZ7Ql44KWQMtDJBUA3WZAgwKf9PwL9tT4XrepmzQyd8eI8PwzPNsKFMv47JkVJ5r6Tm5tDIEw4yXn0GkBrq97871o5j0FTsOU0fi8lkdpHCd4uVWIXptO8K8AtP9iE7bZeA5PuFNV1fU3yQRXaGVf1nCIP/nXJs2ZZUE5NDtXo6pO4VprEnGGOBlx+wKScXhX6r0EFVQ3hsaOu0a16MYoi0WFbEpJgWUkCmAziB7vrQTn3VYNa8jDMu2ODrANImX8WQiu2paq0M+nLoVDk//5cmz4WdrIFP45ngq/eu7J1Rm5pSg6yDaPUS2Y7l+cnXMvB46Ae4zEOsGgCT/gr2kp79R6ufqHwoTEdlJhK+70vjNHRTXaw4shmOiOfQBiMGpQ==;5:o0jZtt8z/RnC858MTTZocqmOkDx1QWRluc966fNmzp102aPrQIgvJTGRKZxsioiXzmzNS2GAbn2goNAED6d7pkrTDFRxCTNIKvbSON7zqNbE1wKtGT+bQG5NqSZLL0k3QtX/pphS/6tSYcMLjma9g7YJIrIrvAh62v6CWmn0ZvE=;24:l2VrQf8wQD8IRTfmmt1D8Wn2x2uCN8YS1HqYk/YXxGNYxjOebUOO1WdT1XNb/Ght0+GT7MLwU7CTOWdkWN/+lqlOlnxjm/kX0RgKVMAP9PM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB3255;7:lwYxNQFpU7EUUqcnQbZAbTXSoVrIiahosv/51N6jyoSkbE9R/jq2KcLAVv/KUyq9Ob0onCMssPPZDllpxpJGEpnqygTGPzF+63PH0HtTPPz9Zk/5SbGjCOO4cTyIjf2mTRnpyAtyOdXM2Htwxf4j53vQPaPxCxK6kJBoOahKY8aLmWtrRBrG1MFYU74xb5RdlR9BK+eM3sY8NGSLJR8EUmQ8K2Z/b7Nk/1lcvlbU4RMF2BsfnlVa6g9DXm8pVHi/
X-MS-Office365-Filtering-Correlation-Id: 0163d3b1-dd99-4ef5-6a69-08d5bff846f3
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 15:25:39.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0163d3b1-dd99-4ef5-6a69-08d5bff846f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2018 6:23 PM, Colin Ian King wrote:
> On 22/05/18 16:21, Tariq Toukan wrote:
>>
>>
>> On 22/05/2018 11:37 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Trivial fix to spelling mistake in mlx4_dbg debug message
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>    drivers/net/ethernet/mellanox/mlx4/intf.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c
>>> b/drivers/net/ethernet/mellanox/mlx4/intf.c
>>> index 2edcce98ab2d..6bd4103265d2 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx4/intf.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
>>> @@ -172,7 +172,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
>>>            list_add_tail(&dev_ctx->list, &priv->ctx_list);
>>>            spin_unlock_irqrestore(&priv->ctx_lock, flags);
>>>    -        mlx4_dbg(dev, "Inrerface for protocol %d restarted with
>>> when bonded mode is %s\n",
>>> +        mlx4_dbg(dev, "Interface for protocol %d restarted with when
>>> bonded mode is %s\n",
>>
>> Thanks Colin.
>> I think there's one more thing to fix here.
>> It is redundant to say "with when", it was probably done by mistake.
>> Let's rephrase, maybe this way?
>>
>> restarted with bonded mode %s
> 
> Sounds like a good idea, do you want me to send V2 of the patch with
> this fix?
> 

Yes please.

>>
>>>                 dev_ctx->intf->protocol, enable ?
>>>                 "enabled" : "disabled");
>>>        }
>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe
>> kernel-janitors" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
