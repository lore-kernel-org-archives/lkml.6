Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeEWH1W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:27:22 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:27360
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754235AbeEWH0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:26:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH][V2] net/mlx4: fix spelling mistake: "Inrerface" ->
 "Interface" and rephrase message
To: Colin King <colin.king@canonical.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180522154251.16789-1-colin.king@canonical.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <cba3d286-3e89-3d58-a55c-de0107b3abcf@mellanox.com>
Date: Wed, 23 May 2018 10:26:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522154251.16789-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::32) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:omMBJmcrwILQtn5TxzgWeSNdLVttu3KNgxdlh2BmTdIkWa2G9s7efPqsziQtNrTZXfAB84Y32SUqmWmcLHleiO6AWAF57Y+pkWwcFqn1E6N8Qy6indUVVOsQftAG6UrpSRsmwBYXKzPvGQmdvE43FlvYjXAtTGiJr90pKGazlTPDB/4c29+uU20p9L9ft9Tc4biHMeE5T2/1Ql1AOaL+IvslapTbHBxgFyjyJh6SDBwGRP6Vz4JWqpsHNUoap6cD;25:dv7WNkldneS79MOqYGg8xzSzdVeQdkzJqykl+FPZViSifhQu93xOTvJBIw0HTetA//KG/q+uUYVxFyVCImjAyzYWNY0jGoBmoxbAxsBGs5h6mm9zU9tjvlBEv6U+4Le5jp6V9A1tgJUSJI6Sjy8CxSmcQYN8hCPFWo+GVgb3ivgzx9DCNAhjcTEZtKtdvEG1iZlTisBcRwXBbZNOpJAxSCTPaYbN6liKcBhsLBqxE0Zp1ga2Hb6BbjKh7p9aeAsWLHRb0u3Djwz/8T8A7l4j+0fLulrx7WGfko7ocgqkC5qsU+c7N6f2YVurLV2f36n9e5N+gh2XuIpDlLO8Q5ZvTw==;31:04fyRCJD34T3Hpble82vM8NT8OR8eDLGuj4pvSlQ83kR6pj+n8FqmGKCmvhYCUboUm1m3W6HpS4q0xa8hpDJf41eFOfxHFikyP3m2IiFcDfSPEzf7O6Bz8reD/eb2+eOIpSQT4qvjHn0o68/xAQdwGA2U/dlghPOHuNXVHL3xSgG/VExnhfuTaigG58h4WTqqX2Y8NYwMprhPYMjZDvZMUTyNWpK9UqszsGCXHLsMtY=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:+7Y7Clz2k19qncM2hZMgtd/ZQ9KxPr3x+bePSVSaPywdhJpSQod3IEPuQ5XCKirmhP6+2FNVNku3EBtuYdV4FnNN47BYyxvDdBXPE7H4Ou0/VNjc5csxrA10ULUjlgQJs1BS1FAETTZfMXRMRaYtvHE7n7SfbDMWmX/LBCO/a98EnTlsYBw97BT2yKso7AGrYFzjXWWAGZq+/qCU4itSx2aT49JL1Aj/xvNvt5zwDy64gY1/S2Oe7lBTkYdNHIfYDcGYwXmIyT340aUDyW7RLvKVVLOnymBgzjLggWhsCjEYj5YweLnHAFze18FxVz/7Or4VDcmr/mBBM4WyiOuE45QMR0vPWgjxNqHWF14phEYIaij1yM0h83K4cG11LF37ddLU+panzS6NAzsWiEvH8XxYYojD7WzEYYfU6wVZubJ4X7uZD26vV9lxG4E1ir50A3L3Gr2EGn6eaSbad2uDkO++Qx2323P8WBCtXQ5DeroyV7HeuPHRdSzbMC2EAEla;4:OAESRZHMdOsziKD0YBwRg8KF15vW9wk61e71ACZ4EJs0xZXwCiSwVFEeghAGd08tGZqmfjehVzftW2SZki/CdX3HzO3tLnHs+f7cXT8G/98rga3EsOrupHopcoOo2XoDb62ma1iJ4mU4HAba6gMH+Xaf6ALzLDGxTuwgS8IoQOw4Qzg7qHRI+UdKCjtU9cODg/JVqJHc/IaxuB9ub1th4HjSMWbzMQJWc0ok1gC3QcyPVivkPx+VPVFBz33e33mSWXmo98p1ZJXdVJtKE8KeT2493VIuacdDC9XFYnQJl7kmTKb1+c9O2AXz+vo2GJ+N
X-Microsoft-Antispam-PRVS: <HE1PR05MB3257C7484639C9BA7A20CF5DAE6B0@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(386003)(52146003)(50466002)(2486003)(23676004)(5660300001)(186003)(77096007)(16526019)(26005)(53546011)(67846002)(230700001)(478600001)(66066001)(65806001)(65956001)(65826007)(105586002)(59450400001)(76176011)(52116002)(31696002)(86362001)(3846002)(2906002)(31686004)(68736007)(106356001)(6666003)(7736002)(25786009)(305945005)(6486002)(6116002)(36756003)(2616005)(64126003)(8676002)(486006)(11346002)(110136005)(956004)(476003)(4326008)(81156014)(53936002)(8936002)(6246003)(58126008)(446003)(97736004)(15650500001)(316002)(81166006)(16576012)(229853002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:[10.8.18.17];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU3OzIzOk01NGw0WnNKdzZpRXBLTkVLWE1zK1c4SURH?=
 =?utf-8?B?aXJrakZYU0Nnb0V2bnlBZmZSTkxFaUZhZWRxNUN5L2lEQy94aDB1bk1jcklq?=
 =?utf-8?B?MFZ2a3ovUVFPc0piWEFYdDgrZ3Q3ZnFsVjRndWtXSGdVR0h0aFc0WnpoMUdp?=
 =?utf-8?B?aTFjeFZJMnVpU2w0M0Q2aENxVWFheGZOdmVoWVRVZktEbWpRejV1QzNIMWE5?=
 =?utf-8?B?WW5DNmtDVkE4U0VrZGJoVHYzT0g4T3ljNlhzWEF3NitzODQ0TzNCVW9hekww?=
 =?utf-8?B?SUxHM09qY2YrMUs0K1VBeDloTWZsclZ0ZE5pRUtoZ1ovYjdJZmVyVU1zY1hX?=
 =?utf-8?B?SXZLQ0ZPTEdGSDBla3IrWjNlcjNPbmMzZGwwQ0U1Y09aRmxvWFZaQ0F2WEFC?=
 =?utf-8?B?b2VoeGZLdHV2Vi9aWmxXL2pvSHRWdFpiSHhuSlBDSURYMXNQRUFOODFMU3h2?=
 =?utf-8?B?S0x6T0NCUnlKSjNCK3VLQ1JVaHFwdzZGMklFWC85L1kxeVdrWCs5TWRTN0ly?=
 =?utf-8?B?MVRtNUtOVy9wQnU3U3EvMk1xZkpqajFRSjgzYXk1d28yeHNFWjJkVWIrWHVr?=
 =?utf-8?B?M2ZqOWJZK25nWkE1SVkyU2hIR3dBNlk4cTgybFFwcUU1TE5VSlNBa2w0N3oz?=
 =?utf-8?B?MmtPeFlSbUd1amV6YkpMc1liaDFCZ0hPOXd2MUtwY3lwUTdBSVRnWVZvV3Rt?=
 =?utf-8?B?bUswa0hHR3dobFFNWkM4elN0aUV4OXJpYVZxNzBZdm91bGRReDJ6S2NQMlBt?=
 =?utf-8?B?MUtkMktEUDJsOUpVMjVsWklFcFdycEk5Y0s3UWx6S3c3VkVEYVNKVzk4MStn?=
 =?utf-8?B?M21RdjBuaDhHcWwvektjcTdVMklwdmIwQ3dkWkxvNXo1TkRSUVlhb3JEaWNC?=
 =?utf-8?B?NVlOQUVTVEhSTTB5TS9rSG5yWjFsZGV3S1N2bmFJNGZpejhrYjhsRzZERFVq?=
 =?utf-8?B?aDNPWGFZMU44VWVVdVhEaWNqNzRkYmNzK1VJajVsWWsvYmw4QnlCN3JQZkpV?=
 =?utf-8?B?YkRXMDhlMC9qSG5VakVtdmNyRG5uUHhmU3VURnVNQnZ2Uk4rWVg0bnBiU3Fw?=
 =?utf-8?B?c2FxS1MxUTI1TXFJenk2MWR1OWxDdE82ZlZsR2xEdEtjNFFpYjQ2YXF2aHZW?=
 =?utf-8?B?ZC82UjZ5YkdKSkNJM2NSZ2FUUmhydUM5UllHR0p3NmZ3c2NwRzRmR0lza21K?=
 =?utf-8?B?NXZxNjFiVzErN2trd1d5dEdHcC8rVVpZUk9MNmpJeVB1UEFIeFpiWlFIZmhk?=
 =?utf-8?B?d2s4eW5hdkNFbzB2WTZJTzZjclNuTWYzZ3Y0bHFBU3NscUFjTjNlM3lRMXpX?=
 =?utf-8?B?bXl4MXV2Q09MRVF6c3h1d3hkWTdkNUJFK0J4NUdhR05IYjZOMlM4d1A5SUky?=
 =?utf-8?B?c2k0Vk95QnVzRVliaC9nK3ZjY2t0bEtDRXoweWdONXhMMXdPRWJnZHExOUhx?=
 =?utf-8?B?Uk5SUFZNSHpZd05LdngxbklFZUtEcE8zTDhjU0k5ckp1TVRPUllBVWJUVmNs?=
 =?utf-8?B?QWRpRVdra3lxOUdEbDlWR2QwSzkyRkpjbkxPa3JtTlFKeTRDN0FMc2hqeGNq?=
 =?utf-8?B?OTdZLzFGM1lKUE8xQWszekRrQU9Dd2xIaEFxckUzT3R6d1djbEViaWhmaXVa?=
 =?utf-8?B?enlzb0ROL1ZvYWtrMVVOTXVYaHhWeDlnVWo5N0hxTFdkYXB1aEd0S2daeHBr?=
 =?utf-8?B?SFVxLy9MeUV1c0cwSFF0ayt1TXVsN2ZjdUxiRngxOUJnOG85VEZLYUlMekdV?=
 =?utf-8?B?SDg1dkdKaXZJSFhVSGphV1c1S1htcElzcXVTV0ZnbE5kNVFReUsrNDlUU2VE?=
 =?utf-8?B?bHBTRW1rLy83OHZOKy95UytoVGdQekZSTG5nVWtsMjd4UWNlMDJ1V3lrTUxP?=
 =?utf-8?B?VXdZVllsbnFYeUVwQWkzUzc3UXlTd3JqdlZ6RFJtODlmQmdjTEVIcVdyakpq?=
 =?utf-8?B?dmgyYlBWY3g1Q1UxVTQrOEM4N0FXWkFEOVNzVTB2NTVMRnAzN1RTK0IzVkZI?=
 =?utf-8?B?R2NJZWw4dys4N1NGdy9sWVZ0V2ZWS3BDYXNDZz09?=
X-Microsoft-Antispam-Message-Info: +/lR7A2oI3e6wtFn98nFbtiuABw2XDpVkmj2td4RF/sqfAZqqYyz8qDtkw8m838HwNQF0Q0/SlGvorH2mpPRc78WaMoWoYBwkZVhWpPG4AprqMwNNSEjbDiV3y7wKop7yP8HL8tTaYRW9K9eBGCDBs4I8luVNT8DNutUf6b35QY1CsKtRJP5K1GLUFqvrxyD
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:ocwMr58uuMlHG8O9skYqeVlsyJAo5wqPm9Uy7kkwxn4wnf0ibCo6mrda5lX8pLL5oOohBBzCMcwWNJ0yncwpsaJxkfaghTVr2h/VK0wWk6r8aHnSZ0BTlsCkEorMAMtb/ym6pb7Xg0+tIV2ufNxclM+bGUst9gDv33h/fs9ycyWunZKCuv5v4+gnPPc5TX145Wi0+GiOAUrHGR7FP0AhTiRNHiFiNxP8tTC0+/sKZB5ccIR/8IScrGA2DgecLhTal62NoguncSxpCK+0QfqG5W37Q5LkDyysYAx/K3Nno7IfKeiqWpAb5gz1PYwpUnqDSrxKtl5xr+vozNtjpkcRNBQed9CHhMgyyySEhFTRm/klp+mHaAEb6AyLZiRWUnK5XGiSPA1BcHMlZ3uZmWjmuPUt2nH8M7HF5479dn7xrUkyPhFZk9Iq3SuagU+4iZuBtXztBhA38PuIMgWQNB6j3Q==;5:L1+FiTpOlW8xMgCn95jXSnpzZ1N6djmMUUIDpyPNOmZoveCR5sAF0f43pi7c81bfeuFEBrolUBropzB0tRGyhXUz0z41O8bu7LMWhkg/YC/0DN0O5g3c5tfEvU0UTBRdwAUNvaU2Tsyc63OxSH7zvMsGQXfkVswRf/7A/gf0Dv4=;24:KCXWZwWpEhK0CGqZKsDlsOynUD4buN3lGKSb47Hw8fk+xy+kYzg98ySd4jmLhc+Mrx3YVocYvY1malvVrgL6jN//x7pmhLbQYyri1dFI6Xk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:O+TLZs0nD2yJvoLrLfGw5T18OsmcbRqK5UWxIOqthVNA3LA3/3sAHaqTMkMnx0NtkHOuZ+PhiOqvrEdgaiPhf6D7wxUWNuJ+HrkQu4jtJlh5j9/Vwq6NaloDVDZKSBIGteKhsRVI3Q/AMRLOHfoJqzagQyz9LAjSBHPqOdSLuk4KycNxtBTWflqFzRZm/Y8y02xOi7/IACnPqlBmdEO4ObqoqPJjWW/Uhe7fwW69d6GQYizitl7Y+6NusRITjMe3
X-MS-Office365-Filtering-Correlation-Id: 11b4a38e-09bd-488a-56d7-08d5c07e87ac
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 07:26:40.4455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b4a38e-09bd-488a-56d7-08d5c07e87ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2018 6:42 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in mlx4_dbg debug message and also
> change the phrasing of the message so that is is more readable
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> V2: rephrase message, as helpfully suggested by Tariq Toukan
> ---
>   drivers/net/ethernet/mellanox/mlx4/intf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
> index 2edcce98ab2d..65482f004e50 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/intf.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
> @@ -172,7 +172,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
>   		list_add_tail(&dev_ctx->list, &priv->ctx_list);
>   		spin_unlock_irqrestore(&priv->ctx_lock, flags);
>   
> -		mlx4_dbg(dev, "Inrerface for protocol %d restarted with when bonded mode is %s\n",
> +		mlx4_dbg(dev, "Interface for protocol %d restarted with bonded mode %s\n",
>   			 dev_ctx->intf->protocol, enable ?
>   			 "enabled" : "disabled");
>   	}
> 

Thanks Colin.

Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
