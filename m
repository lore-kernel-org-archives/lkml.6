Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935215AbeCCAEw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:04:52 -0500
Received: from mail-ve1eur01on0125.outbound.protection.outlook.com ([104.47.1.125]:17882
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933567AbeCCAEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:04:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 0/2] mux: add overview and add to driver-api docs
From: Peter Rosin <peda@axentia.se>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20171212084633.532-1-peda@axentia.se>
 <20171221143519.29ca0b97@lwn.net>
 <4fc09b21-6226-5b82-a841-cb4bf1334a5c@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0dff116f-0710-824a-2033-516a22a4d08d@axentia.se>
Date: Sat, 3 Mar 2018 01:04:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4fc09b21-6226-5b82-a841-cb4bf1334a5c@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0032.eurprd09.prod.outlook.com
 (2603:10a6:7:15::21) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c29634-9dd6-4292-c84a-08d5809a5ff7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:3eOyoe9ipblHtpN0lScI9A1kjI2Dh7ylp1tEChdQs0UgrQwIg9A4MnrotOkOKJIzg0vKjzCWTpulGr9ytAbyUfwqj1OysYWET9/3LZyh6kqL6WZ8VGK3aSAvVXiL643X9GEN7aBJtWTOxPjcnOmKsOcH/q+Gw8kkefAmG9EJGXGeWAR8dhvMPtKTnD+uR5hX+WOKVYLvBlBs0XgAqKSzf+LLvjZcsuYYbwmMzL0xcwFzm0mVhUbFh3mzFGtg26MZ;25:GlK/46e02RbNXtWJFoDE3JYKzFxaA9tIpNyL/7C1g1bqlklu7y0HQcUnOXp0ECNzJ7vjTgV77I3hnZpV+9riplhLxxrN+DIcXOY+/P0vJfIQ4Iwo/j6G+qGcWonAzxbUQu2FzDM6MVpPqrmoNBA3hxHxMj3Lh+M09Kj06q8uQHnVg8ySZlbWEHDpIYxAzLUkLTzPx0G75p3+KR780DjmRWVzazvrBbCf3E06rQfVVwXzlxC5nxpYJBsa+A6zXcREUP0xlHwOhqAe0+4hD+pU4uSwDeksRZsNiu9E/A7dBHvIpj3c3pMpDVE4kkb334aLQNyZ0C/50Mcwlyc3fD9m0g==;31:WH87oJWM5fIhgswRnYlQNiAHztmEY7G75MqqTbgKw4hbJXMgwsb4fv34N6/W4bRE5FchAd8xQ55CoZyw+dXU0DJC0PUSmTU+vNOmRbGxR/xLCavLTLXGuf/FHtUBoAyEOjGr62Jw3pCNB6Gpe9h+3ltC/tWOOtDA0aAK0HVZm+p6V0hJU+IAu0bwPkuHSMdSg1JGLVRRigJ0L3C4cr/lzo1H1+icHXRsmjAes/oCvsg=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;20:xQgIiOWHyg07P226X2Nv2+NjnrALQVUqvhpPjAJnz25VsMs/UtjYI3K576HszNubjZzbYktD3TDwIH9r79p+1ijEE9pV4VCFENq5AEb+F6WWVthd5gACqJfNdRyRKQKPZHw4mPefh90e1jFNd3m4cvdFYvnMLtsWpLNS64R0ALM=;4:fbo44rYML1Zqsfug7VJy0Bo1W1zVqD6VbXaEoz/zH32VhO7V369wD0fe6WKRS4DYnF5NFqOQWB8bZHSS5vbK5GwM3SSOMc1yfOGJeurVBi8l+EgRBDISU7oNoCF1Nd1GAn9aa8eP74mudcPMiQugF5xcAzA/Ze1nmthmFYODg+SUxAexbOaSYpoFcu/9iq69swkiLGKWylFLYph8ogEGSdxhchimBmOqVl7vwTIz+5TWriqxGneLdcg08Q/lB39mdC+EHiX2TmSETXD0d03Xww==
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770B94A1D08A4B099B1D371BCC40@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6041288)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Forefront-PRVS: 0600F93FE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(376002)(366004)(396003)(39380400002)(377424004)(189003)(199004)(51444003)(65806001)(86362001)(65956001)(2486003)(81156014)(53936002)(52146003)(23676004)(66066001)(8676002)(52116002)(47776003)(25786009)(478600001)(3260700006)(36916002)(6486002)(81166006)(6246003)(8936002)(4326008)(68736007)(2906002)(106356001)(16526019)(97736004)(64126003)(31686004)(316002)(305945005)(4001150100001)(7736002)(6116002)(74482002)(229853002)(186003)(65826007)(5660300001)(77096007)(386003)(230700001)(53546011)(6666003)(3846002)(58126008)(50466002)(76176011)(6916009)(2950100002)(117156002)(36756003)(105586002)(26005)(31696002)(16576012)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6QVZYS1J1MjNRWndRbnhtd3M2K3dFejdt?=
 =?utf-8?B?T0xteHZ3S05nWThzeUFLSWR0RXV3OTRPdm9hL29TVFh3bG01TmVaUnJvSHNR?=
 =?utf-8?B?TVNtRVpmaTlZWUhRd0E4ZGUzWUFKSDNjWEtHNGNaSjVwSGJKK0NZUURnMW4z?=
 =?utf-8?B?NGRBZjBkUDBhL3U5SldwcWh4RHQzc2lKN2JGSENJK0VNTEppR3o3VXFWbEdE?=
 =?utf-8?B?SGFYU3B1My9XLzNUYXdhQllIQWhCVXAwUWhXMGtuM1dJdXlVdlJ6YmFuK1BJ?=
 =?utf-8?B?N1RZcEdWcjBjMTZrdmhoaFlSTEl2VTBhN3lGM0NhSjBsRTNlS0JURkZrQXZB?=
 =?utf-8?B?MXQ4QjNqTDNVNnBTSmNvN0ZFNCtmbmFCNUREWXlNNkxpM1pEYkVKRmFNRjR4?=
 =?utf-8?B?ZVZsTjRsSmoxUHFDZ1ZNb3dGU2E4OHlHWjNQTEo1cHduNmFCZCtTbGcwWjBj?=
 =?utf-8?B?RHkvMEtxb2Qvd2NzeFVFaVVTMjlBRVdCVitRRm1JQy9VL2lRVXplVnZlNzZm?=
 =?utf-8?B?OGpRcVFCYnZVcVBlNTloQVJUYi9VR2dZUzdJVnR3Q0p1VzdLUUN2NkNPQjMv?=
 =?utf-8?B?RktqZ01aWk5hV1FXZnFlRTc5ZW9ZRU4rVm03NWFUNFB2OVVlcUs2NndHSHU4?=
 =?utf-8?B?SGlEUWdCZXEvSzd2bnV4R3ZqanVaNFZtQkVnRUNhZWRsVFZIcFhwc2VWaTE2?=
 =?utf-8?B?ZTIrcnRrd2hiOTZtVUZ1NHplRnhpNHdQWlY3MEl1VlhGMm84NGhFYkZiUjFr?=
 =?utf-8?B?eUcrVURBRnRqOENrbllhM3NxNzQzRFlvbUtsMEF2UTNnc3l1ZStkSnpJM2VZ?=
 =?utf-8?B?R0JtMm9PazRxODhnZW1CZHdoMFAvOXNoQUhBQWR6UVNhZXBLZnQrcGo3Tmg2?=
 =?utf-8?B?TFpkWlQ0d25KaGgra1dwS2IybDVZK2FJSFpTR0J4d3Z6c3lFN2lrTHRJMDE1?=
 =?utf-8?B?R2NJbzdpbk9GR1BLSHB6cDlJRk9vQk10aDBaR2ozZ3JzRXBVZ2hZcVMwY0Zq?=
 =?utf-8?B?UFRoOEM5aE0za3VlVTdMalZ4Y2N2a0pnTTB4T3V2RjVxc0tUT3czNWVWSXNn?=
 =?utf-8?B?T0I4bndsSjF6VUJ0aFBieDBDY29Fdkp3ZFNtTERUUmllbmw4S0hCSEpWMWtH?=
 =?utf-8?B?SmZFU3F2cE5HcHF2eGY4MEl4M09RME1LbUREQVpDc2R0QTFPYVFKNktrWlBF?=
 =?utf-8?B?ZVl3N3dYcHJwRmdWbzJpOHJNZTNFMzNDQldEcGJKdnUwb1oyR3hpNmNKd1p1?=
 =?utf-8?B?SGxSN01mOGhuTXRseW94SElnYXZtaGFBOTBkdEdxaUFFRWljZGJRL2EzTzlF?=
 =?utf-8?B?NlZCNHFvMnNiM3NsR0N3ZzFtY0dOckZvSldNU1Jldk45NTdzS09SQTk2b3pC?=
 =?utf-8?B?ZXp2YXpiUS9PQ2FpelhCRm1XVGRUdjNPVXFXYkNUd2R6YzArR0svTXFYSG8w?=
 =?utf-8?B?Z203OVZ5MFBteUZSRTczOEZjUGkremRsMzEvV250V0htaTJ1SzdRem1lNXI4?=
 =?utf-8?B?NUNSYkcvSWpWNmdGM2JKZitCSmxTc1hSdktCZlYvZWxxMDl4Z3VicmNkbUFh?=
 =?utf-8?B?TGl2ZjBIZXA5Wi9xTXRYVW16WWV6bEt2K3A0S0lnRTdTZS9adGdXUU55aHF1?=
 =?utf-8?B?MXRSSC9IK2JDWGUyWVp1V3FjSmg2S1Q0TUxoQUNnWHU5bXBkNVBoTlRnQ3A1?=
 =?utf-8?B?T0tsdkc3eElBekpKa0M5YjE1NW1xaXNLQ21JYU0vQmZXT29lWXdTejc1UFVI?=
 =?utf-8?B?OGVsZ0RIUWt3bzZtdnpncmRnamxjeHdDSWVzVFIxZkhQaHQ2U3crVitlVFZG?=
 =?utf-8?B?T1JWU0hqaStZU3VvYXhvSGNxZmZFaXN2dWlsN1pTUWtUREUvdks4bldkakJR?=
 =?utf-8?B?TGRsT0I4ajEreUZpbEd3blJjcncyNjB0eDZWWmJZZjgzR0RFVWcraHVYTHpG?=
 =?utf-8?B?YVAxeUFOakEwOURTSWZ2YUF2Q2dXS0FnQnR2L0ZJNXY2S0ZjSHdyWXNVQlI5?=
 =?utf-8?B?QVRxNW5NY2RKWS9SUEZuYzc1TVpUN3Y4aXRnTU94VHRpNmt6U2MwM0FYVmNF?=
 =?utf-8?Q?MtUz2ydHVmLOQqTxsd/+L3FwL0o?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:umrG7lFoy/TrklKr+Ax0sI/HQPbwFW/sC4cSxk9oZnUHOrdjrrNOHnDz5aebb9nzTStOp79ryEluTunktOyEL72ngK3+hr+qs4XK2RR2GxZjI0aVtqiGyBX8s3NX2jzQkQtkOg4oK+kDBZxr7WI70PrOrAEK3IXqCKLUEPUk0Ymi2Vdple9os33JtLnbPoTmd+ve7+SXkTWCDcILyO1LIH7rOQPR/ZoXIZ8EzySCvNe3t4dqXy0Yf406Rct0+6hxb0W37T2NNOTIzpPZ9klfGCz8Vz56E8vrSeHppVF4u/dOzgz8WI7q/jmRrnYMozmope3VC68mznZ8c1zRmR4VvHZ3xX47lZXNeQY4XVF7LO4=;5:xa/z6o5ghqnnm6hggkz3CqDoJ5if3Kp/+MH83oRjzywwBfQc7pQ3mVMFA+TyvTTSuK8oF4Rffxm1OWqvalznFHZZ4OzYqKuKiG+THqNgTzv/43dE7hwaHlZQcDh1hFRHanPNjWXxOCaEz3sS7sSpYPdDqeSIomIw2J0TyzTUaLk=;24:p+Tvu5kWKadIqaETQaMMloltDu17GHAYjeCT8agC21cpH+qXZ4fAxAUIhx3/d1Mg62UH0ybkVVwjyZZSj+dBODhhSB6/HdiK42+aBrm/IBE=;7:Cr/7jXAiN/8SsTGP8SNLUvboMH8ud3D+bp7zHWASWcDr8lCZRcidK7ZFkw4hiaElHKdC6bj7KhXDFJ/WvmpNjmbZL+eMm0rwUIW4l/sQx/aJuHxgMIvzRHe98P7pJtSnDv2twODip3iwl0+jmtyB4aHx5v0TxstwTdm3ygdnYtwtkd6TfLUJEYYqBH5Ye01JZlspWAWTbg+6oC+DNj3PW/Av9eeONkkJygp559r2JeDOuep5k8GpKG+0ngh4h5zk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2018 00:04:46.3373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c29634-9dd6-4292-c84a-08d5809a5ff7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2017-12-21 23:11, Peter Rosin wrote:
> On 2017-12-21 22:35, Jonathan Corbet wrote:
>> On Tue, 12 Dec 2017 09:46:31 +0100
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> Changes since v1:
>>> - added a short introductory paragraph to mux.rst
>>> - added an entry in MAINTAINERS.
>>>
>>> I forgot to mention that this applies on top of linux-next, I suspect
>>> there will be a trivial conflict with an SPDX conversion in mux/core.c
>>> on Linus upstream.
>>
>> Sorry, I've had this just sitting here for a bit.  Did you want me to take
>> both patches through the docs tree?
> 
> I think that's going to be easiest, thanks! Let me know if you want me
> to rebase them to something w/o the SPDX change.

Hi,

Gentle ping...

Cheers,
Peter
