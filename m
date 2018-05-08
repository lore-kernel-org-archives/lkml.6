Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeEHH66 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:58:58 -0400
Received: from mail-eopbgr50137.outbound.protection.outlook.com ([40.107.5.137]:8871
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753856AbeEHH64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:58:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 10/26] drm/bridge: panel: provide an owner .odev device
To: Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>
References: <20180504135212.26977-1-peda@axentia.se>
 <20180504135212.26977-11-peda@axentia.se>
 <5130ea2e-e1cd-53dd-25da-038deb91a13d@ti.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c446bdec-bf31-f192-c270-d672011d4503@axentia.se>
Date: Tue, 8 May 2018 09:58:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5130ea2e-e1cd-53dd-25da-038deb91a13d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::23) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:IYZJgvJ4pTfgiBybCwUo8f+oNFYoZO1wW+7oDyKFstGvhxDDcQKsnHRuwBMeSD0eVxAWjzYr3YDDy8KIC1946HpekQpAzKCB5yGqua6ea0DhQAqdF78bYR1a6KHhLE55VqpJGZAD1TZgwfhW87sBIQKwqsKJhcoeIZ12mCGIbpQdhvHCH5DzFtkkT/AEnA6Xkhi12I6QQXdnBhZAVmHKhccU/MXZJpCqxsxE02YNospXYsDIQdrOTYLxbKqi8BLW;25:HNMQXZnXyw1oJIDe1CvpU7rMMlno2s6DmzuyHaH/iuy3cQJVsTrxQ0kPx40pDnOc9tLu0yVSDfSan2eGlnj/XCFHI4cb+HEueY2kqD6AMwRlSeRW5jKefSCU28ehsD15TspZAe0ZP0UF2Wn31Qml48BSLDlVJ/vdLai/NAoD5BUAVb8z3YSwliyoc546sFD0QQAlJa6fRi3XK89VaGFWuKUwCJx5BbPzO6siPEHjwcanDXwJHQRky+k4iGeTJjiiFMuU/+182EC0ztyPkwzsIl5q01FnbObYlq3+Umo2vZQbh/qW9VEmC1RcWa/XOqyIic6naxE9uKdQIrti2dFbzQ==;31:MHwQbn/yeuxGAfnMUkjcpKr7dCruKm3t7g4niTSvecoB3IRnrnJWZG1Vjh4FEcoUmzgE0+/ioFHOl9MblpIJCXv4a9nYrBZiVcY1FoLjBYyHZp1MTgon9hbmWXNSa+yIWcOTYYMgu7AjB38HR/sP9JbY33+s2z8rMvGBaSy8mSidepuHKI7jvgmYesIKiBKW8pMEYBuDvel0+4zgBdloECxKYPvaC5CBYJSSE7y887Y=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775138B4439DDFBDF6C0D1CBC9A0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:dD5LijWTfdbj8Q3fDZrkhBt4lJVizJsYi32vLTNG1Sschd4WnAn2bIEpfHGbk7FndiOk4C5EXG2gTntG0oyBPA8L8bqznpK0DtoCHu6XZ3Rbh6dcgHz50PNrvwl6U0qf9ny7DLnn7PiWdvaZ2BuDE4P1nnxgY0qNs3qHk8Hy2txX1psk3Qqq8xbPkOvnU6WqpV1+EHOjmSK9KTbkIWns2fB0EAer7oMekWq9Ab7KefTnT2JR5zYq98aitXI7MvRZm77XBbdk9gXoSq3bc1GDG8Qyo4IklULg9YTlGCAhRi/BiRpFHGA4aCTsxELdhUZ8
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(346002)(39830400003)(366004)(396003)(189003)(199004)(377424004)(16526019)(50466002)(7736002)(186003)(305945005)(2486003)(47776003)(81166006)(386003)(66066001)(77096007)(26005)(52146003)(76176011)(65806001)(65956001)(23676004)(52116002)(36916002)(81156014)(64126003)(316002)(54906003)(53546011)(68736007)(105586002)(106356001)(16576012)(97736004)(229853002)(58126008)(230700001)(956004)(3846002)(65826007)(6116002)(446003)(11346002)(5660300001)(36756003)(2616005)(476003)(2906002)(6486002)(8936002)(31686004)(486006)(478600001)(86362001)(6306002)(4326008)(53936002)(5890100001)(3260700006)(25786009)(6246003)(74482002)(31696002)(6666003)(117156002)(966005)(8676002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6NUNHc1NPWkVQWUUrSkhzcExzdnV2QlZk?=
 =?utf-8?B?SSthb0JZRXVXcGQ4VjBvOUQrd3EwM0xnNnQzSUVvdmZnRmRTUVhvSFVuWUJz?=
 =?utf-8?B?VmRJb1R5QUdxVWp3MWRMUjVGSkorQ3pTTjZXOXdENTlhem84RmRuQUV1RThr?=
 =?utf-8?B?ajN4U2tXOWxUdUFxb00xcUhQajdCRXFRN09YWGpOOGdDdVJXQllLdlBlUVFY?=
 =?utf-8?B?NDdRR3JrNURIeS83SFpGbnhaa0Jjb3hmRHlKd3VPdVBTMFJydjlSQnFIUmN5?=
 =?utf-8?B?OEY5UTlxS1Y1V3BHSkRXdVRhcTBBUEpiblJtSDZGRjZjNGlBKzdvS3lKeWVL?=
 =?utf-8?B?OVJlVjZGZjRjZTVJODBFSXpQam1DMndKRUZ3UGRadjZoL2tScDhvV1kvRmNy?=
 =?utf-8?B?M3BkMkgwbnNwV3dadk96bXVVQ1BmeDE1NG1pa1JJdnFyT0lwd3c5ZWEzRlQ3?=
 =?utf-8?B?NHh5ZWJBNkxvNlFaVHZNWXN0Q21CZnVja3ZnVnFXcFg5dXlQdHhpcnNPQzMz?=
 =?utf-8?B?TWdiSUM2OWdTNnNiR2lxbmpNR016OVZTRnQyOTRCbDNVWW50Sk9sUGU0c1Jn?=
 =?utf-8?B?eVZhZXVScGhBWGNZNldBMnNlL1RtV1FUKzRLMmxOK2VuVm5INnJQVHgzSVRy?=
 =?utf-8?B?NTQ4UHpubEhSTU0yUVFVcmlXdWN5eG9YZm9oaGlncVFnK0ltaUtRSldKa1R5?=
 =?utf-8?B?SUhyV0JpTkhYNC9iUmdFN05BV1dOVTlZb2ZEQW1POCtpR1pqQlNwTlhJeDQ4?=
 =?utf-8?B?UHZhZGNoeUpoZDA5b1Q5U0xGNlhKSEl4Q0o5SFk5SFAweGpTNUFOeUFZTjN4?=
 =?utf-8?B?Y3UwYXVORGRQSW9IMTF6Wks1NGJ0N25FVXdqKzJPQWhBVnZlaVc2NktPZ1Nh?=
 =?utf-8?B?TFdMYzd6T0ErQi8vZHRqS3MvTHg0eEFyWi8zSlFjSWZ1WDQyVjRDVFgvVUQ2?=
 =?utf-8?B?YW9mYXFyUkd1YWdYTmIydXB1OFFLUy9zMEFJRm9XSGt3QTE4QjVBSWhZc3NQ?=
 =?utf-8?B?TDVTTDl1Tndaa2xFWU5oYlNJVkFmdmgxUE1wcUFzZDA2dXRuUXVjbURIb1dk?=
 =?utf-8?B?MVZsVEQxaUw3ZlhGSGlERUV3SkZRWlN5bnQ5dS9xMkJmQU5ibzZHVEtBMU1D?=
 =?utf-8?B?U3dzZkFkZ0NYVXhDWDdtVkMxejd6QlQzNCtXSXJONWpCZmVmNUlEUjNUdjV6?=
 =?utf-8?B?QkdxalN6SlBINnpkOW5lYW9lSm5odFRQYUJuSUpHaUJISmRrU1ZzY1JWMm80?=
 =?utf-8?B?OXlCTU5MaUZVaFJhMUo4dzNpY1creGJBQVdmUVhIOXgzbE1iTWw1UTcyS00x?=
 =?utf-8?B?bTk5TzJWYTNEOUdNQmwrckk1b0YwUU8yeENubEl4MFpzSHB4MElXemlRbUxE?=
 =?utf-8?B?YlB6TEcxQmtzV2pMQmpGUEJ3MDZJS3lESkx2UmhicUhPbXlNd3BkNkt5MzNX?=
 =?utf-8?B?UEI4a2FNWEpnU0h0dEtvVUh6WGtwZEZxVVRmeWlhZEdSU2ZPNWg4VHpXQlpo?=
 =?utf-8?B?NnMvaGdkZHFBN3BuQmtkNFA0YVRuWVQ1SElDZ2NGQVVnVHJzVnRPYjdwZ1Fk?=
 =?utf-8?B?bW4vWVh0RWV1WG0xZVdtbm5ZZWtJRHZMQWd0NVpZbkNxaGtrcXcvRmdLK3Nr?=
 =?utf-8?B?NzQwbU1XQTRBdVB2bDRSMjN2aFdnaGkzVUt2dmw2ZUpSYzBlbFhwQ2g2clU3?=
 =?utf-8?B?eVM1YmNwWGo0VFdyOE9keUM0RndXd3Z2czUwZFNjVFBiQXd0ZXRUeTVoTDBL?=
 =?utf-8?B?L0M5T3kxTU5hNkF2bmhUVWdOMzNoSlc0UjFScW8vdU9sdEM5YllzVEFxbG05?=
 =?utf-8?B?aDVSSEVWM3NMWVVZTG82ZDl2RTZPUjNSR09hQzFuOTdHOFFpVXBML2h6R1Bk?=
 =?utf-8?B?Ni92TEtiaEVPZHBBdDd1V1lDREJUNWtmRDZDVTlnRlVsYXRTK3A4NmJncXdw?=
 =?utf-8?B?VUlOc1lWRlcyRWFjN25GY0NiZXhlL2k4ZW1OTkcxRmtQY1FxblJ0WmdCaXpO?=
 =?utf-8?B?SW0xUTE1N3pZdnJRSFdsVFBpNjVvT1VLajJNY04zUTFOZjd1eFVsUjJRRE5u?=
 =?utf-8?B?enUzbUE3RW9Yb2RzR0hhdTNkNkk0NHpsditybk5hZENSdmJNaHpJMjl3TmMw?=
 =?utf-8?B?TjdqNjJ2MGYvNHRGek1EU1FXd1Z1OVpDdGNXU2pBek9RaDUrMTdMNlBUK1kr?=
 =?utf-8?Q?y15XWfCMvCCNXOmqu9gvifzSN1bXiDcEkqznNCuNItmg=3D?=
X-Microsoft-Antispam-Message-Info: WAcm+04WLgVSi64oWyMd9GjYJZcb51RQO5OJhZodHxXarynfuVClORHW2Wfi3zi02igalsz7XvEOOji7YtvBWFUBlT+o5y8nM/CTLjq0+2kjC2IMzGcHFzNQyylEdHLYl5KX3EVeI5Vnyd7QZMvIUsKFcfeuF7DEoM70PfMpoDP9+eKELvJE8q2QJ+Gl2JBg
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:e1OEsT2wsx9Z1nkKehezlGlMZWq1I7nkkMMvankrE9KYPl8dAp0K8lIo6yzf+rFhfmK/YRK7iAvf2UbKnsobrus2sWFh0Gi/7Zc+ix4A7BaK/ZVQsb90xuoquUt2nsjP5tl0MaQugyuVd6TmKKdEnDJ4wLvpvrhoPZYKg0fVeZkl+JNnlmzeGDWYGOxM1eAMKNC951Aft/9xFjGkzH3O2f5P67I/92wwYu2EJjLfpo3MlShzuPSlgV1WO//CfJvOGS5+ichX9/EZVrVKo5SfKmCgN40MGZXOoOM3wOKUktXbm8MFLoEyBt3XVmJKjhsHtPvpxNSRgul+568274YNGcwdmtIsgXKeKEkve96dUc176PYu1YKqwXj5ng/xF8SBsvQ0w00utAhV3SZYkgkbVet7gToiht3rx4egvOn3y+94z/2BbzD0RqdTqCvsRzkk8FQm0jVAlKF7WOT36iW3TQ==;5:lGzS31u9Mob6IYwTIboPoX2a6N+5yZtehqbK3cv/qUBfXEP1nj4T/+SoBJ1h7pTkf3uVICA5KrXfmBFVGfHAyMjZY9hq6iZcRsYAxQ2zONlpw6pMcDXWgOVvVZgKTPbB70INoU9I0nx8gALP0o7WqqqUzzJJxP2ZHhUiZPFMF2Y=;24:7BKFL6Vx+KysiG14Sknj1S/kmD2vXQNUwiqSMvX3yx/nq//edLxXIN9X53XvM7oQl6w8pNycSDYRCaYoDlcX4jqZQ7xzl3Mc5KqDNbKwEq8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:D8B9Ei28qLeZtyhYbwET2jnYXWXMbocUWjgoPLryf57kRqeM3FngWVhdgNNnuyBY8+4ebp2W3Ijvs5ZwmKpnLnAmWA9xqgqV1YdjohCWCCk0CVZM826nq1wDqIj2pqrynSDbGqbxLr+dcGRShMMJvZRxlGQh0WWffaMSUa/LqKvFscNxyBmOj1ngClMivz12Jvo+fubSAe4dsGeIcDdJCpLpLhWNKOaRYYMCrHWV7U2RXp+YakK4ovtJdxT5Snhb
X-MS-Office365-Filtering-Correlation-Id: e39b0b88-5ecf-44ad-66a9-08d5b4b98af3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 07:58:52.9387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39b0b88-5ecf-44ad-66a9-08d5b4b98af3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 08:51, Jyri Sarha wrote:
> On 05/04/18 16:51, Peter Rosin wrote:
>> It gets rid of an #ifdef and the .of_node member is going away.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/bridge/panel.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
>> index 6d99d4a3beb3..f43d77b5ed20 100644
>> --- a/drivers/gpu/drm/bridge/panel.c
>> +++ b/drivers/gpu/drm/bridge/panel.c
>> @@ -169,10 +169,8 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
>>  	panel_bridge->connector_type = connector_type;
>>  	panel_bridge->panel = panel;
>>  
>> +	panel_bridge->bridge.odev = panel->dev;
> 
> I am afraid this approach will eventually conflict with my lately
> accepted patch[1].

I don't see how? The links are refcounted. So, if there is one link
each for the panel and bridge between the drm device and the panel
device that link will simply get two references. If/when the panel
device then goes away, the drm device will be brought down because
of that link (with two references, but that is irrelevant). When
the drm device is brought down, it will (presumably) bring down the
bridge as well (which will fix the refcount as the bridge link is
killed as part of that).

Or have you done some test and seen an actual problem?

> The panel already has a device pointer of its own, and technically the
> bridge element created here is created by the master drm device itself.

Not always, some bridges also call drm_panel_bridge_add for connecting
its output to either a panel or another bridge.

And by that line of argument, the devm_kzalloc in drm_panel_bridge_add
attaches the bridge memory to the wrong device as well. Maybe that
should be fixed? Seems orthogonal though, but it would introduce a
natural struct device in that function to assign to .odev. I think
the device owning the bridge memory should be the same as the .odev
device of the bridge.

> I suggest assigning odev here to NULL or to master drm device itself.

I'd rather not use NULL, since it is nice to be able to rely on the
.odev being there, and WARN if it isn't.

Cheers,
Peter

> Best regards,
> Jyri
> 
>>  	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
>> -#ifdef CONFIG_OF
>> -	panel_bridge->bridge.of_node = panel->dev->of_node;
>> -#endif
>>  
>>  	drm_bridge_add(&panel_bridge->bridge);
>>  
>>
> 
> [1] https://lists.freedesktop.org/archives/dri-devel/2018-April/174559.html
> 
