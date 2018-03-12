Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCLOdG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:33:06 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:62455
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751238AbeCLOdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:33:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] iio: potentiometer: mcp4018: driver for Microchip
 digital potentiometers
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20180308195830.16348-1-peda@axentia.se>
 <20180308195830.16348-3-peda@axentia.se> <20180310161511.66d2ef97@archlinux>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <89822e7a-569a-43b9-46bd-d9b65b895cab@axentia.se>
Date: Mon, 12 Mar 2018 15:32:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310161511.66d2ef97@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::29) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ec2579-0943-448e-76ba-08d5882626cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:xjocFVe15Q9W2GbcYMakfX87+FdwowdHOoPpcLkX6500ZALuhkY4MEFAALQ1dthmcpcxAE/WSzb7VCwwzQfmLDGl9AcuzEWg+WGmwxc9wrD4CAByEA0BkVsJkGkOZKObvp9VrvjOvapwIWPHlgFTgG8uwK14wqC/nDNfBD+g3ifSazPeC5EWGHkKz3GcPX3ha14f0TPE18EhJAqssXV8k7eD+HIVYz3zWe4GTynttoBwUaGRmY4hv4ApurGd/+7R;25:C6eI9+0iZLoOfX38Vq1JllnTqh2qCGv4Wv9K4RxsiKvNJYsea2PSVpL/bYrvoagvfVM4s315yblwsdOXjUqxYrT7IQh+rpuqATrepIvCJNH0r0wGhvyDS8kiCOqv46D03/raXbF/MX7TU902eS/EOB0mlETrf3BXfwUDvq/sIQp7aUlNFAUW3P3x65eyNNIQ+SCr/nK/wtma413y4CgsfZWFbcVmpEJmlQ+R5DW6BAxG3hPJy7drG8iE+e0l8FumXrRDuCCWS44WdnWwdQ7b88D79e3whQTXP3zI2Ap1eqstUTT33NGM4IUMmUBeQK0QdLqPUGzi1aymPp9LGiGBZw==;31:4CBQdu396I7ya9G7dwqHtWG8OqrBFYw5baL5oVzCDR+r1Z6O2KA2bUSmTnMO2sKz1XebbMDbvDAP86sdtftyKG9Ss6niGO7rY4PMfE4+m7cqEn9LIPP8Xh/tLGSWOEDy7Mzwcpxcli8wChlXwbN3zn6rRnEUND4JSn3x8sE/8PqPKcYZaun1nzUaLHrxGyGL4MvJ8mN2A5CpeBokAba1jmOqiXaBHmVaK6zquDksBL4=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27750E81D6A5151494124067BCD30@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(152791735303576);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:4LWNMpu8uc+hpmDF/UbjB3sAJ/54MkpsdpZW3lQh/r+pqabIbcsml7rJZHliDTQlX60kvM5e0oOQO7GdzIA5GOKCWDXuNNGgEJcUJYjIslKHRHiGzgfmiKQYoUJLWnOih3w7kAnfQl6uFG5J9Kw21VtswyN8D+XW9Uz+nDfdOqk8XNGwe6qrQkGJLbAuDlNVzGew2n1wJaCyvCQD/WIsJL6Hzsl7Fq+KupEJskKWiRsOZ+B5nDMDpduHcjjKR1kdG5RFM+PW7SQrH8VdNCDary2hBCty0oE15YyveXmApgxYGrMetk8F2zexnrN+VMi2
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(376002)(39830400003)(346002)(366004)(199004)(189003)(377424004)(31686004)(52146003)(36916002)(4326008)(53936002)(2486003)(8666007)(97736004)(64126003)(74482002)(58126008)(31696002)(3260700006)(230700001)(16576012)(316002)(68736007)(54906003)(229853002)(117156002)(47776003)(65806001)(66066001)(65956001)(6246003)(6306002)(7736002)(6486002)(23676004)(50466002)(25786009)(106356001)(105586002)(2906002)(6666003)(6916009)(53546011)(386003)(6116002)(3846002)(2950100002)(77096007)(16526019)(26005)(81166006)(8676002)(81156014)(305945005)(65826007)(8936002)(76176011)(86362001)(478600001)(966005)(186003)(52116002)(5660300001)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6ZmQvdGxmSEs4bkdUemtscXJJazJiR1J6?=
 =?utf-8?B?WVl0am5yWXlyVVBHeHBNU0pIaGZ3QnhIVHN6VGVEdmRqNS9BeDJaQys1VmdZ?=
 =?utf-8?B?Yk1yUlpLY29nZnNveTFSQ3IzOXc1VmlpM2ZkUHQyTDNMZENKYzd5U3pxSlpX?=
 =?utf-8?B?citMMUtvQ1NFSXBMOXRGM24xMzJTdkpQQlZvbWl1OHIrSXhYNDBHbjdYRTBl?=
 =?utf-8?B?Uy9WdnRYOEQ0QUhhUy9LVXJPT1oyd2JPM2NKOG9NR21OK2d0ZXdnZzZqeUN3?=
 =?utf-8?B?T24wd2VMdk95TmJKdTZYc0NMbUJMNFRBWGFQR2lISmtENGd4bVB3T1Z4VW5H?=
 =?utf-8?B?VGErYUVsM0xHQWpGSUVjT3BUUEtxdGdxNHQwSXV4WmVUay9YamJISW40ZHln?=
 =?utf-8?B?cnVQZkEzTXlSdFJBem1lRUE1LzRkbUtrczFWZ0d0UUwyNDVRaFhGVEZmRmNz?=
 =?utf-8?B?Wi9KVVV0Q04rcm1EOFY1bnMwZERPaUtWRTdpNmdQNGtMUDFuSzh5a0xMNzFX?=
 =?utf-8?B?bnNtM1IxSm5odVZmdHVvT0huQ1RWMjNtZ3dqZGNGWm94Wm5jak8yMTVLS1lW?=
 =?utf-8?B?TWR2R21xR3RRMHpyMUR1SDhzdjlOOVJEeTFiYUZ5YzNjTUtNMEdpOC9ENWU5?=
 =?utf-8?B?Uk9aSVFwN3NCeU1QcWxFSjAxRjFkYjhRQ3VFYUJ3M0hWM3M3Snh2bk5LMVIv?=
 =?utf-8?B?bWNSL3Zjc2FxaUZNendua2RxVks2NHYwQjFETThxVzYxZGx2RkJTVHhCc29v?=
 =?utf-8?B?ajEzT0owZHJCMkYwUG1jSjBXU2RyQURBK3RCTFB6WEhBMU5VeHVKUDZyTjNj?=
 =?utf-8?B?SHVpaGxQc2RMQU9DMzkvamwxN0ZHNFlaNUZIV3FqajRXUnk3bkRLYVB1aTBl?=
 =?utf-8?B?Y1NyV1A4SUsyYklMNjMvLzllbnFRS0hjOGdoU2lJdnFLTG00QnUzWlpFRFF0?=
 =?utf-8?B?eExOcXNQcGgrbjhQbVgva1cxRlJzN3VialZQRDl6cGc3bEFNWDR6ZWx3SmY2?=
 =?utf-8?B?dk9hMFQ3c3Zvd2psREhNbDFRaTZPTFNvdERmbzR2a0JrWGtGbWNBNFlTM1NX?=
 =?utf-8?B?THRSaWVCRjI2OU5wZjlpZTZrNUFGQkZGbmlkWDBpTnZxY1NaVTZiZTYrbzFB?=
 =?utf-8?B?OFNUNWY5a3Y3SXgwdXVmT3JYQlpLQ2EwNkp2aXpaRVdUNWY4RGorOEtTUStY?=
 =?utf-8?B?emh5NzZoV0ExL3FmL0cyV3dUZlFoanFSL0lNcnJGWkZrSXpXN2tyOWtoblN0?=
 =?utf-8?B?N2dIcUZtL1ZPa1VVWXF5bHYrQkQ4WlI4WTZXWjFSRFlhVXRKaWdBanpTcjVF?=
 =?utf-8?B?bE43S1EwM0dDSHRWN04yOXIrZmZQd09JUGFRUDZjaXJJVVdYamVjSmNGSGFK?=
 =?utf-8?B?SHhkRlBsNWtVNnVjZ1lIUS84aVZRdkJLTm91N0dtNWhMOWFHSWY5S0ljNm80?=
 =?utf-8?B?d2RjRWt6dW9lbjZFKzczeUN2UE5pR0lOSWtFemRMcEFNSVUrUkpZeVN3M3cv?=
 =?utf-8?B?ZGdpcnU2RFU1bnVFZmdIc09LeUw4VHhGTlc4UHF0R0F1Uk94Rm1ZRzFNZHIy?=
 =?utf-8?B?UUVKQnRPRktJV096RHF5U0t0MDAyUERHTFNlYS9PbEFhbWdDOTU4dGcyVzMz?=
 =?utf-8?B?OXE2SXVxRy9oYmlxR0xmT1F3bjFoVzg2VUZ5Z3JMMWpzbFpDSGtXMnl4Zk1m?=
 =?utf-8?B?VDc1K2FjNTN4VHlXcHNENUJtVUtmQjlUelR6Z2Vjb2pyci9IYlFMNjN3c2Vw?=
 =?utf-8?B?OTRFWHcrRHZrVEUyaFQ3K2dJbEVIbk5HM2xtb2tzZDVadVQwc2UvNjdGREJz?=
 =?utf-8?B?ZXlTNzN4c0RqNndqaGp5RTUrYnpBRTlzZDVPcGJubnNRMDV2ZUdmblp5SlV2?=
 =?utf-8?B?S3ZQeFlHSW5Tcm9HT2g2WmdpWWxya3NrM3lvbmF6aUM0TFp2ZWFZcW5BRW9I?=
 =?utf-8?B?NDlPdWhWZmRBbE9RTG1XWFhtOUVNc29YV1laUVRlZkRKdmtHK1dCRjgxUnQr?=
 =?utf-8?B?WElEdUc5R0ZCQWIvQUYrOHZTbnJJNkIxLzhLT3lMS04zbHJCWlpSdmRBM3Zv?=
 =?utf-8?B?dXNtaDJoU2RWZ3FpOTRxbWMvbTlkbFpLSFhrOUhJQ1g4RTBzWGl3T3FvQU5X?=
 =?utf-8?B?enhDZz09?=
X-Microsoft-Antispam-Message-Info: /zn9nip+Z+BLnctH9vTwdFy3P8L/vFx7YSOTHgS6rjq8iy2xIGt1K7nT9OPnoaP4KK2FZZO+aRzfUEBakgtcdtKeOaXMKnwogzIJMLT7J/8JGMa+Dvy53rzFztoBKcQYxUY9u6kuYddWn7ESgl8bh6sRTbPFaIVg9go/Yrz1pzlwGoJFNZwiXOleRXXxFhSV
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:cjIi8W8bwqMVZbjZZpQh/4nknsfT0DP8rIJHxwOQ3e7ZdzY2Z54URDxPOMXwyWe77w4gsP53beCv/YZdnMVh26KPqVnYpYxZLXaYlu2wlgNNcxVL9CO8xO7d6MciZChVhNBSlYwwa5eD3tnSEvh2EXFCISqzHM8Co5dnCppW6V88ef3TzBu/+kEhldrAo8mV1k9+wPzsL/XdDHtyt4xWuYTk66asyay0lYVAobdDpgfWNFRTNGLLbNgCJbe1bIRFdJid7wx0a+UqW9wZmee/MQA6LtYYSGoJ9H1yFO18CHkHwXF0WJAjjiUdNHiR1tEdkWiMkxLRVQIyf4qLX31V5VVmgMN6FVjPXwgAce4cB7A=;5:yMl/6xsGDgTY9T5S/we+1CslVclsY352WrBoDXst/Fp72Rdb3vRs9yDJ9PmoZCiUAE4RsZK0GYNpKXHxGyxq1ebCGjFQfEmnaoHQxCVXJqaBlBHqqBonGJojxbr+hwsL9wbv7quVEKeCm9YjvN1SvRBfQsPCTKan2cOULUAHX4g=;24:Fj3GttTkVOJfGncD2wIum3rrs638umRzp0/URRv1QME6qcBOK/KXuqSEkGw4coXa9TI/5I8OL/Sn0UYgVn+Mo8ZHzDSlgXMKs/jUPOkTmiA=;7:TmN++ina7es5kR1gKOuq89MzvxazmYLxS/eip3vTBn1YAO5Wa3lNsfNlcIf7AKM6LNEpiQZIV3LMbyozpYgsz/LODVflsQLxgSxvzx/zTqGdGTicQSGrLXcXw426tFedjU++ixS4974N1aDzMEA7gZuKHvE4ZAyNccCJiRsfYCRcGI/YN89XkuM8Qrr2JBbAAOdTrOByRoha+iwm598IbqOEpCE1LdtT5afNHSHdeylAhgE4zkSIHtMLG5UGOtL9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 14:32:57.4265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ec2579-0943-448e-76ba-08d5882626cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-10 17:15, Jonathan Cameron wrote:
> On Thu,  8 Mar 2018 20:58:30 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Add support for Microchip digital potentiometers and rheostats
>> 	MCP4017, MCP4018, MCP4019
>>
>> They all have one wiper with 128 steps and come in 5, 10, 50 and 100 kOhm
>> variations.
>>
>> Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Nice little driver.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Thanks, and thanks for taking it quickly before the bike-shedding got
started. I worried a bit about that, when the driver is so small and
trivial... :-)

Cheers,
Peter
