Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeDIMNN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:13:13 -0400
Received: from mail-eopbgr10092.outbound.protection.outlook.com ([40.107.1.92]:58272
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751676AbeDIMNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:13:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 0/5] Add tda998x (HDMI) support to atmel-hlcdc
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409111733.GP16141@n2100.armlinux.org.uk>
 <bbc7a992-5f17-c108-2b6a-01a585e6e315@axentia.se>
 <20180409120217.GQ16141@n2100.armlinux.org.uk>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <56a4e7ac-62b1-9f0e-5d30-cfc9dae0fb2e@axentia.se>
Date: Mon, 9 Apr 2018 14:12:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180409120217.GQ16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::19) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f0b8ad8-2e9f-4a35-c980-08d59e133d45
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:5lrrgCSLXdyl+fqU6tf5Mjp8uRPvuJKNRz93ZaatsN3IBy/IfXH0809fNwYGdNPvmQRVuJoSG3pCCMg183KYA3L6m4SvcXy3gc8nTwqjG3Nxo9jRbFw/BH6NjbxSVu81XmhHTJ4sTbjdLGcpKaJTLHbmWvt9Hfd+gEB/jdaMSSmWh+NWpCnWe+huYoTYsrXjNmdA7FlLxtyHWAjqrRP43TlYJldsjPot9Cp2Db/PUQPh0UFBD+ytz4KnKZNGKTgw;25:41V6E+trfIwD64XZL9WvU/PZ7uQ9cZZ29Tnew0T7TgBLc34rOVYIm18/C1ZklFOlLVTIYcrdbO2CB0UdTJS5iryk2wKwk+1cc1AvqcwljvE4hqqjfSFVtN3d2QcUY7XmbIx/xgOQp71YS3SbeHB1zYZ1wMo0xkfY+le43Gve+YAoAkH0ehzEhPNWEErMm07yUYDB/UiIQpxQYM/klXHr4CalCBG/zCGqQhZXN/QvTTT7zEfctGF7TvdR7k1WV3SafFO9zirNdIYOdUclDmxLvrZt78MCj7o5clHvtzAKbUHJsNgA1ngNAFAlOH8pI2TeHUzkpVsGNLYoGn78gZex1Q==;31:arJQJss6AezJvmE2mhU8fnigIFQOHcOunHC9bPbQMGkLLpiHdkNrLfaIJDWVuK5YxdWqgPZocMHCBUVqkCuepJvau2WSP4zZu2zF61hxHra0fXZEx0j6TxRcDhHKCLX3tEktukXHmuONOyTGiQLy7EdZAipMYuCcXBLOPOnKk203Xz7Y8iGebmIS4uOOx/e9ngzYa6p7gZZuWeMW3pZUevV5nm51txTkk0smDBoCXC8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278415B390DD5974192C7F21BCBF0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:2OoAbaXWdDMDWUirVs1w1t0QSOp7uQn2ExHnDZQnH5zYhQ/u8/ZiL+rpsa0U3wsCMZ9JT5Iu/pFjmW74rUhJogc+Q5U8nbLJiTuXaUmH0SpqjN/8QHGaH+akmyzMd+afPSOmYsW8Yrbn+DhJSs8cGMEyMzblgRKEn5CX/WHXwqPawKhgq7l6Hdr6d21+IjasfKvHqa3HydFoyv8WiBh6dN9A4EDP+mem7AS6hjRGi0+aePzeDV7dMRz+puOIVMxliLO/+WkjZWw9wGcfpbIGfw==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(376002)(366004)(39380400002)(39830400003)(377424004)(189003)(199004)(54906003)(105586002)(36756003)(6486002)(7736002)(31686004)(305945005)(478600001)(31696002)(4326008)(6246003)(93886005)(65806001)(2486003)(52146003)(23676004)(36916002)(7416002)(5660300001)(66066001)(65956001)(230700001)(53936002)(316002)(59450400001)(68736007)(386003)(53546011)(58126008)(76176011)(65826007)(47776003)(16526019)(16576012)(8676002)(81166006)(81156014)(117156002)(446003)(3846002)(186003)(6116002)(229853002)(52116002)(86362001)(2906002)(6916009)(6666003)(106356001)(25786009)(64126003)(11346002)(50466002)(956004)(77096007)(8936002)(74482002)(2616005)(97736004)(3260700006)(486006)(476003)(26005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6MVlWd3U4enpQWWIvbStpWDBOeE5wNlRs?=
 =?utf-8?B?akswVWZYYWo0blU1RW4xVUVaQ2dzS1VNdE9FQU1vdElONTBKN3FSWVg2N0or?=
 =?utf-8?B?UnNmb0lqRUdTbXZhRFNJSTQrS0x2WmtmTFdodk5jZEkycm9lMzRydzNoT2Nv?=
 =?utf-8?B?dXpmRHUwSUV2Tk5aSEpLS3lER1VCOW9nc0RWM2l1N2NraCtiRWZSc3QxSkoy?=
 =?utf-8?B?Z3cxL2Q5ZzYrYW50TGZpZGluK0ozeHVYMEZjUUxWTFk5RCtLVGFiV25UTmFo?=
 =?utf-8?B?amZGZURIUWhyaEdJS2pvVytIcDh1VVh1Wk11R3dQQllodVVmZ2JkS09VaHhT?=
 =?utf-8?B?MzdYVU1nM0p6T2M3dzJYbHdjVlpZcEVrQWREZUdLSXBGbkxSOEJWSWsyWGtM?=
 =?utf-8?B?S3RMS1V0dVQwSkJleWNaelp2bUlicWMxN3JBK3lwMlUxTFVLWENaTHd6OEM3?=
 =?utf-8?B?UXBIS2s2WDhrdktIME1kUXA1cGloOG5iUHBCSlhiekhLamc0UHRSVG04Qldk?=
 =?utf-8?B?RGplcUtJR1RLUEZQTnNCeW5iOFFyOXdudVlKaHdMT1REbmZEcW9uT0h0SVhO?=
 =?utf-8?B?VjM0NVN0QUhicUhLNHllK3ZIa05FN1lTd2swbHRHTmxVbEE2ZEdPZ2pac1d0?=
 =?utf-8?B?a0VENFJDNlhjUmlUclNrbkIzT2VwNDBqcFc3cFovNTNnOU1Vd2F2KytyS1BT?=
 =?utf-8?B?R3E1U1p2ZVN6UUlVR3hObTQxMlVMN1ROelpNdEozZjEwUDZvMXdwSDV2dkZ3?=
 =?utf-8?B?MW9QSG96bXRDS0NOaElMMDkvemFwcXlBb3A1OUYrOWxTdk9VbWpndmlHclRl?=
 =?utf-8?B?RGZYeFFpUkMrS0IyQ1N3Z3BQVnFHQ1NxdUhoS2prOFJub21sY1I0WktUaS9T?=
 =?utf-8?B?enB4dkVPSi9mU2dtblZQNFNLN0wxWVpnUC9BdmFqRW5VNmRBVnZjMkJQc2Rn?=
 =?utf-8?B?cjFYanA4aGVReU9mYXl0WThsVGZieDJKS1hlZDJxUTdLWFk1SkNyY0d1WEpz?=
 =?utf-8?B?dVVEWE4zdEtlSDhrQVNpNDJkRzdndWVTNTR3MkZUTUJTRCtpQzFObFVPSUk1?=
 =?utf-8?B?L3ZQSGcyT0hDVmR5MUtRMk9TU1UxQkp1eXVuTlNzU2pxdmNHZHNHOXVZeEd2?=
 =?utf-8?B?MnRkdVF3cm9YN0FhZHg0ZENrUmt6VHlFOWk0dlV6cWMrM3JGMU90OWJDSTBt?=
 =?utf-8?B?ODBXS3ZPdmJIMTJxeXg0SmVzSjFadTJtU3dHc05paE5nemxDS3h6RVpIdUdD?=
 =?utf-8?B?SVJJSWdpMENpaGk5a1lCSHZtV0w2VzIxYnZMUkg4bVdoSk5DQ2FyZDM1WUxS?=
 =?utf-8?B?Q1hJR1pHYk1zdzhJcHlML1hGOFEyZXZpMDcvdy85OHVoY0Q0bGE3SnBLTTN0?=
 =?utf-8?B?UWsyWE1aaFhSNGFUZ3FWblY5TkhBaDNETVFMNUZIKzZ5YVNyODJBcldtWVl4?=
 =?utf-8?B?UlJodEJHVFpVTHlyRDkzQ2hjUzdnOTdjcGJ0aGREdWtDODZBMGRpcCtkUnU3?=
 =?utf-8?B?S2VhSzlPcTRZckJraitSbDlOTmlTaTVjejJIa2Y5c240bjZ3R2c5ZmxNVVVC?=
 =?utf-8?B?dGZEOGVtVk0zKzh5OU00K2tOVDlaZzBmSmlSdGI1K1lTSkFrN3dHNFZ1Y1JI?=
 =?utf-8?B?YVVGaEJKQXVDOUxVWG10dnFtWVZpeHJ5ZGJ2S2hrNjJZSjRvWUdZekxmNGpy?=
 =?utf-8?B?RVMxdzRqcEdhUGZuZDg3YnpHck1ldUFIcG10T05JY1ZHU1BRWlkySzl6OGNU?=
 =?utf-8?B?WEJ2NnhCUktCRDdyT0VVVWdPRDhCT2Rkd3Bidjk4L1Q5OVoxSm1ES3R5eUMv?=
 =?utf-8?B?eWpUVkRsTlBhL2NkUlFMMmZmd2ZieG5CSVZTU3hyUURWSnBVaVF1UG50b01P?=
 =?utf-8?B?b2RzeW00NFZNQlhTbnBxUEJoS3pHemJVcEhRZyt6cEJYN2Nld21TQStqWEFC?=
 =?utf-8?B?a1BnUGpHbHliclJFSEVxWnBPVTI2Um9Yci9VNG1aWEdyNkVuTU1McFFIb3hN?=
 =?utf-8?B?L2NNWkdkZkxZSGhkSmtUR0thWi82Z1N1NlNiZTIzWVViSHdOWFJ3TDFXNFZh?=
 =?utf-8?B?ajVHeVp5d0hYcUZTVTBtQ2FrdlQ3NzZMeTZ4cVhFN2dGZDZSaEdFbnl6WmVT?=
 =?utf-8?B?TEVubCt0ZUo4VzVKWkp3KzR6eFdPa1FYYUxSWWNSRUt1bHp5VFdCSE0rQ2lH?=
 =?utf-8?Q?zdisNv69bfmG3qJ4WOQwKTW6bHko4utgp4SKfTThvuLE=3D?=
X-Microsoft-Antispam-Message-Info: bgAuB2mKRdAOuexk5LMeS1Cqql2tZET+MCEb8dc+Cwekjn+PZVVfBK55iAY+Js+FvyI1MGe7NhnnuImrIp30M3051TVCidZQSmRCnEEAMNbHanuX4EwbhuuHYTzhVuVz/MVz3/nz3wy/gO+Zy1MrYdJ52Sp4qO8mIl8mWqyMiDel0sN0hGDcXaEoDBC7fcgw
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:hp0OPXhIBa9f5GI/jtrPEaL7070LyegvfHgkLLE93ZyikAv4L59qMWD6WDYqKMjtz1hPVh8u1LhtLj3lebf/ZPCyztXCE8QW62Molg2CYGKtDhrh1oSTqx7Py0XJd19rvA3Ekkhau3GxKI4fCb3pmiW6ilALThRXkAHti39J9FzZoRe9ODXS/qB6QkqKynTjdfInCvX7jXeE3Dt/PZM3tKI/y520mGqJohzVUITNLmjmt4YgKMFST1Gz1rEmMLthP6VkDW6iIAd6gBzsW9KF+Yn0wvcUXk1XlLKSqDnVhLiPFqwpGt1FbP6hH8CI012sSd0FFdlUDDrIXsCQe3a3WnPGqPF10z7fiqjS9bs2FXL1gSNZBAdwxtGXbBGENK6rtI/znW96RL1e4rPNci+2BRZHape8RnlErPM565xFNN41jyDzsW70hGHOwbC8KlTNS7jl88xkKZDEDepf14otzA==;5:wn+govTUwLBge/BWogM7sxMPro4CCZzi5DjtneVR65V/ZhAH13J9TtilIsdzKZgyJcT2F/FmK3vJb/KpmHDg4gZ4oT3a71aHbMZ8Klsp8SOVGrue3JyfwnJZS9Yv0vIDt7wLpU+R0MmtLHg+Cb0L416jjOsXn7KxrXThiAGchAg=;24:p0oLtsrmi33jH+QNw76s9AaPazBkfQY8ZouEidw/Ikfndzkp3KgXxNg5BUgC59QxIu1EFckSrpp4OpJR32UEjDZbl3WUOygA0bdDzRiu0+c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:phGCUbPhEhHp6sEgfF4Bgc9a+LK4zoByzLq+GtG9YCaZSO7JuumvdPprSdvVJUzInFPFGkvysCB1gm27uV+qVm9jLztJYbcIGE5/jSemc2pZom9tTt7JyQvXFn6wswQvKxRMWuMz13MaAAEfIkxZZohkOEULmFMXYEaaTN6Go3R10N0d3B1BpHMSXhSwIFNrwIKj4vOf8N3xBOC9J9CVw+wX9JZtFTJ63g5q02V2XBKKN0qLNyNNuigUVk73YoxU
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 12:13:00.3750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0b8ad8-2e9f-4a35-c980-08d59e133d45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-09 14:02, Russell King - ARM Linux wrote:
> On Mon, Apr 09, 2018 at 01:44:22PM +0200, Peter Rosin wrote:
>> On 2018-04-09 13:17, Russell King - ARM Linux wrote:
>>> On Mon, Apr 09, 2018 at 12:59:13PM +0200, Peter Rosin wrote:
>>>> During this, I found that the tda998x driver never sets the format in
>>>> the connector display_info. Thus, the atmel-hlcdc driver fails to select
>>>> output format. Since I had similar problems with ds90c185 lvds encoder
>>>> I added patches to override the atmel-hlcdc output format via a DT
>>>> property and things start to play together.
>>>
>>> That sounds like a hack.  The tda998x driver doesn't set the format
>>> because it pre-dates the addition of this information in the display
>>> info structure, and none of its current users require that information.
>>>
>>> As you're the first to require it, rather than working around the
>>> driver by adding stuff to DT, it would be much better to improve the
>>> driver by adding this information.
>>>
>>> Thanks.
>>
>> Even if I improved the tda998x driver, it would not be correct.
>>
>> The background is that while the atmel-hlcdc driver supports rgb888,
>> our PCB is only wired for rgb565. And the tda19988 has rgb888 input
>> (we have the lsb bits tied to ground on our PCB). So, the tda998x
>> driver can request rgb888 and the atmel-hlcdc driver can say ok,
>> but it still would not be correct. So, where exactly do you suggest
>> that I model the narrowing of the display format?
> 
> That isn't described in your covering email to the series - instead,
> your cover sounds like you're working around a deficiency in the
> tda998x driver.

Sorry, my bad, And sorry for the confusion.

> I think you need to make it clear that the reason you need the DT
> property is because of the way the hardware is wired, not because of
> the missing bus format in the TDA998x driver.  From what you've just
> described, the missing bus format is merely incidental to the issue,
> and whether TDA998x provided this or not, you'd still need to override
> it.

I'll reword if/when I send v2.

> If we were to add the bus format to the tda998x at a later date, I
> would hope your driver would ignore it in this situation?

Assuming that by "your driver" you mean the atmel-hlcdc driver (which
isn't mine), then yes, with the override in place anything the tda998x
driver says about the connector format will still result in what the
forced output mode says from the atmel-hlcdc driver.

Cheers,
Peter
