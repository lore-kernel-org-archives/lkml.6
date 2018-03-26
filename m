Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeCZQt5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:49:57 -0400
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:12779
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752346AbeCZQty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:49:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v2] Documentation/CodingStyle: Add an example for braces
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <152114372879.3142.8833111074324091904.stgit@taos>
 <20180321091701.7d56445d@lwn.net> <87woy4iide.fsf@intel.com>
 <724fc548-0e40-11a3-2a9b-3dd0db0de880@amd.com>
 <20180326103249.42789cdb@lwn.net>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <6f5c2c61-7c58-ffa5-2063-1ead3f7f809c@amd.com>
Date: Mon, 26 Mar 2018 11:49:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326103249.42789cdb@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:3:16::32) To BLUPR12MB0692.namprd12.prod.outlook.com
 (2a01:111:e400:5951::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5c38b8e-021c-496f-8aa8-08d5933998e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;3:8zETcQQyT2/Iao2uWAt8c9ZTdXO0xSk53GTyJ1lBMvhgIWzCBZ46l8gqquiIby7+UqrNPxRcaQYqSJjyl20zk9VXAoUY0L4nvvO1RSpTekCumtdgk1vcX2eggVugURfNLeaCHfEgigOl/vNqnoGQiS51cbZb5mxvGw/WVlDew55LmNDV9/DuTbZ6fTTpnwWrLlFdxU9BdvoHDu4PR9oDmauTNXUjFnHYbZmICwBoUgQHEenx9DkYrBTgHxJ4FgTc;25:bGoTioSw8SPu1/9IMrFGrjBz7WSJ5pPxJISNpAbrP7e3reOceYx+WyaUeNREpD4J3/6nbiARExhUv5bZ6SqRdTzYp0O/FHYWrCFSrgZFygOgTRDpPeGJXbV3u0GWjuPXMFoSedSTBVViCeS68rAMFVpHoUuKDmHffIm8YAYt226f/IldfgNUoABkwwS2+magMcX1Lm3rdWlzCKSX7PP4jkNHGeSvmsVUjcv8/05in7zjYF3d4i/RWUjS3xbAmGWJ2hmPPO+9YjqltNjsKO7+jsfBpeyJd2H+qOJjrITj0aGv5vFEKqOq6LjOEjL7y9jctr3xWvvrSSLN6rRu2c0GVQ==;31:Yruw2DnICuwCOeJakESIAsQKQ7xIOC/dalKYZ4cRAWubAZh3iR7/CesysJRYGQbVoN6KT8968VkvuMDdVqZGWukyI2WRoG6zSiWGPSy9Dsn/qIdEwTJp9QOwKZ9F/VR3okXNpPir3ttqeSPk19LLYvLP1lYtKBfUQbEGhMl+jOiL6vtzLCCTLegsfGvu62CS2Ruco/90H91f3pu2XFoWAPRSPXHD32Wzqk+95asLZEM=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0692:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:9KzGTTUkEs092Iar4KB/wzLJS+7YnnufulkWVghRUwtbBRG0luW8tsPZ5XOVxqpHoN1+0qp71XcE9V3XcfIR095RF+ra6Xyu7a2IR6JdsfRr0P3FlMnYEHteqkGscniPFNX2sKoY/6XT3oGOV3YTKn0q5A0SLoNI9dfHJXW1DV4aEKWb0CikeDaOasC3EU/1YQlP0u0w6vO+Ak04KCdZuhUigcKoCgC6e5DxDHtVSxj2HCdLVK9aRES1RMfBerXFqlhwlGhz55HgRurhR0PhC+QVx9DzRWgNwlPZGnFmYN1LbH+Es6p5M4z3TIjfcZDotYI6kPVWhi0vDsVgWIBHjivEPK2sSbSmFFBUcqlW2/9qHKFk1zegRbpzSD4DDGOJkk+Gqeq0PHi5L7sMeUnEh9ktV0zkJHjZ/pMwTocxKCnSClWgA3PUnnR6cSChqRh144ZbXQ0t5Crx8x7pm4fkcsvNaFZFjVnO+Kf9M+4dzPzla+xj3WDGKvRt272Vj6Ae;4:IHfp2Tm1GWqqC8OyzQnXz5zzM3n+dBQCOhVjv0vvX144ZeMeFeLF6AHKLer42Q3DyUIMHkBBNbEjkqYdJEjVignv0co8QnKQTT54w63dwXXsW0b90MfY9YlvP63yQftvzfXXjhlGB/bHGefEdZ2Oj/yEQBqEn7698DO+x5IS1Gwy12fNqitDeMRhXGuCW6im/P/N+T9ZkizpbZhbkX0jKnrdNFq9oW+y/5A/sElugMm4O+eaMbbzKgae0SvAFbObkX82BUFAophZ84+9/SZMEwhedaLSwERwmSDATpCAiD5V0recWngpouRsdL/qmfoshuJLHGnqJsXI8rB72ph/LQ==
X-Microsoft-Antispam-PRVS: <BLUPR12MB06925764CD53EA3DFFC68267FDAD0@BLUPR12MB0692.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BLUPR12MB0692;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0692;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(39380400002)(346002)(39860400002)(396003)(189003)(199004)(4326008)(65826007)(81166006)(81156014)(7736002)(305945005)(8676002)(316002)(16576012)(50466002)(3846002)(6116002)(2906002)(36756003)(230700001)(106356001)(66066001)(25786009)(476003)(65956001)(105586002)(65806001)(47776003)(31686004)(64126003)(5660300001)(93886005)(2486003)(52116002)(52146003)(23676004)(76176011)(186003)(26005)(77096007)(67846002)(86362001)(386003)(6486002)(8936002)(68736007)(16526019)(6246003)(478600001)(53546011)(53936002)(31696002)(6666003)(6916009)(229853002)(11346002)(446003)(2616005)(97736004)(58126008)(956004)(72206003)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0692;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkyOzIzOjhLWmVhdjBQRFlMUVZPcnJzcWxpWDVRdjhD?=
 =?utf-8?B?U1prbnhwK0J0SDI5YzNDLzMwd3FjeWhpM25NVS9keE1QMVozQW9CYzlVc2tj?=
 =?utf-8?B?K0ZFTWhRUU5pRUQ5SnJjNEFwenY1RStrckdudWNIVmxKdmgrU2ZSZTF1c0JF?=
 =?utf-8?B?YXNIN1ZVbGdFV2FvZCtmeFl1UEMxNlMrMmlmSXNXVWhBVFJoLzhHTzR6Vk5D?=
 =?utf-8?B?bkVUL01oQmVyaHp4Q2tFM1R1aFBuSXhnZ1ZLVXIza2xmVHVNUnY5WkhqeHBt?=
 =?utf-8?B?L3ZjN0R3eXp4Qm92dTg2dkJoeDNnU0ZBa2xldE9HbTdId2JvZ1lJVHRBRS84?=
 =?utf-8?B?NXBYUk5saGN6bER3dHFFOG5tbkdrbTdkZXZnZDUxckF2WU9vNFcwaUc5NjBs?=
 =?utf-8?B?Zk1xSlBnUXltbG5ac0ZJZlpxb3hxSStoTnl1eDV0Y0FCdExUNXE1Mk9ZVDVm?=
 =?utf-8?B?RFVCTG9vUk84aXpWa2F6QnNWbmUzczZnS2hqRXdWR2V4dHdQM29TRU5xZzFv?=
 =?utf-8?B?MHo0UlN3c1llUVdLRDBOWWEwTUsyR2ZnNUkzYzQ1N3loYnNFeTdsQ0ZhbGc3?=
 =?utf-8?B?enpKOXNlbkhrYnpqcGxrelZocTgyYkJwMFhTdmdkVUNCUjlFeVgzVllnTTdS?=
 =?utf-8?B?b2NtalJaKy8rblc4cjVqeXBYNWcyMjgvbVJOaDM4OVRSS0tuYmpldmVmOHg5?=
 =?utf-8?B?KzhzbzBqazIxWkdpQytBMHRicjFGQUpMRHV5M1BLOXRKNE9Qb1NyTlhmSmdN?=
 =?utf-8?B?OEhoSjBoQUxyUGgxRUhGSExtdlBmd1JsbTRHU3A0TDdHMmdDbEhCSmJUZUZw?=
 =?utf-8?B?anBUeEdxWkRyOW9Na2ptNm50d3NVdHk1Q1NyeG1ZNHNOSXYvbDQ5QjczeEIw?=
 =?utf-8?B?TUJKK3o1cU85M3JwMmdvam9kYVlSR25IdHRXNm83SndMZW1kNTY1NWY2MmRI?=
 =?utf-8?B?SmRGaytqWXU0Z1Mwa2o5SUhWSlhiWEVvWmJPakhnd3laTklpR2p1UXFrQlFR?=
 =?utf-8?B?NklSODAyOExsS29FWHp5UkJ4ckpwanRpTytRWDBhYWpEMm8xK3MzTmhaWUlG?=
 =?utf-8?B?TXNSaUR2WWRHNjJVUU85VGVtNVdqclN0OHl0dENRMkw4N0pQYkFLWmV2Umc3?=
 =?utf-8?B?QkNmRkowL01rYlZQUTlUaDJSeHpGU1pIeWJJNVdFb0tNMmRGTEIrY0pqQWJH?=
 =?utf-8?B?bkV6M3VRZWF2ZWVCKzdYNUNmSlhQdEZiZXNUUkZsdUdxd2hzY1JuQTZCUU8z?=
 =?utf-8?B?R0NUamN6RytnVTVkcWFsbHJMMlBWdzducjMvL0JYQy9VNFNtL0lTY1AzdXl4?=
 =?utf-8?B?alQ2TFVMYmhQRC9EM1h1VnNhSGJFdTNYY21vWTVCNEJLeFAxSHlseGhkMHJm?=
 =?utf-8?B?T3REMFA2YVYwRGdKczZLSDhnY2N6Tmpva3pXeFEwZWZuTVlQTTNpdUFValNa?=
 =?utf-8?B?bk81bjdCbEJ4L2pYQzM3V3hFNGxRRnFUQ25KR3JDNmczWENpdGNGSXVJekRP?=
 =?utf-8?B?MUU0Q3B3ak8zUFZ5SGxNZ0hWR1BWZ0FhNm9NT2lkNEtuWnJnektMTDlTWVhh?=
 =?utf-8?B?dGVaMzJQQWxkK3U2emdhTVFNRFRTU2NRUDA3TmQ5QW93dFBRdDA0Y09Dc1dD?=
 =?utf-8?B?MWs5VzhpR3oxMnB5TVBCV1lRRkgyTUJvZGJiZnBTMTBONU82MURhQWx3YWls?=
 =?utf-8?B?V3ZwYkI3NXJBTTJ1VlhoNys1eE0rUDRzcExlNkoxcFpTaUpOVTFyZysvR0U0?=
 =?utf-8?B?cUdoSmR6ckdXOG1uU2QyckNhajNSTWUvUGZ2cTJFbVoyMmZmTnliWjJOOFJ4?=
 =?utf-8?B?b3JmVERvN1BzNUEvK2JBRUZ3cG1IWVhPeVJuZDZVaVp0aW5KUTlCYmVKZUVO?=
 =?utf-8?B?cFJkdTJDenVUWG9EOUJ6UjBoenRLeDBxWUUwMFhEU2V2SzRFRlZuYkUrRzVN?=
 =?utf-8?B?aW1OSzlrVEZldmxhS1BZSmZIeHQ3R0hXTUtVMllkWWIzU2JxM2pjei9lT2dZ?=
 =?utf-8?B?QXNUOCt5bG1LUmNocjRXQnl6UDFkaWJyU2tyUT09?=
X-Microsoft-Antispam-Message-Info: +2NvwnoUbuCyIg84eim4InO8MaVoSvTcrzep6EZjD+Yd1V0z5ln+5+K2vli0rx80R/MJD9WA4jKi+Z2ON9c4jFO2VjF4FMEjnzT6rr9iQZiaTSoOKbLWVubUdtcfPxwwrlkeSEHS/agA7tA4e4DbgG60NyR9c8OE3707TAGwGPeuoY54CqlZvp0mEzHVtKTs
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;6:gm6ZJSaBLTocM61r+TER2BizD1yAn/qW31U4v0gAyQxfdbFxsZNvPRpO3tLi1qqhOoF3+DvpXQP5etuqEwy2QKDITohq+kyDhoIh1Nv4UAlLgpt9rcVrIuDPaRQcOAxTI4Lc8OqUlLLk19ljZi59HbpYR8NaVHlrl5C1p/adhH8pZzFYGRAO7nQA1LF6QkFDAMIJr5320bxac7pvBOdIiOJ4+wUqCe9CyCCn3b2fJ9i66RJOm7KiHr0V3ExZ4oXa83KhMcevn8FoSlPCOHOmpzGAk7IC4AdREpjDZM7QNByWkmZlcPNEoJGuXz2fUbTo/LDReVE9EuG/lJbzY7Zhhga4PXGc7o9cCvvaM4FXWzMhd5Xq48ZT+p4Ky7meRKeYLsgOeTppOGmW9U40Phy9ZPZEsuGDXvZJJOtY55jSxsd2Aq9AtKsLDDumHEeM4JyxQSIDGuTKncvbu+3Kj72msA==;5:5lzmvyy5hnL66yLoBHE7hSAX9X9S0nMu5SKOvYnvzM9ogiIapFfDOksJ2jtLu+ZsM9ysALpxdTD3GDqaVrDp94I1nGUiISxvLpjVMDIRYJSX7Ij4T5rtfHAKsrClibd//81OzlENqaryRVowE2u0/LHYDRHNw/TvNBrL5mJ+tos=;24:uXlQ55CJkSVfNS+SjBMtJk6Klv9Jlcdi43X9uidbPyqt1Uw7PbbLoXsjJo6Byn2OwgT1GMzZ8bZdVphf+eiB6udEtOL58ai97RtJuYwOBUo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;7:qoqLCkp9KOsP93lTgyHRH+FKl5a7gNqoqG+BCgDkHilTvXf4FVNrVXyU6I4dM/QGNSmMRuUfMasoFbeOwrD59vKvD1nQvj4qzJdei9LZLACHvdhxLOUF55eOygeRArANtjxhSLQ9XHpqPga3Os4crdz8U6ykwGbvY0y8rsLtfRPwCedP15isUDwQjNX4quFMLjcz3S/oF5rLTCiIzUkorZW3HjSPQ95sIwqXGCmrftwjP5Vt/o6ZoMAMxWWib12c;20:k0T6zRofMu2zlmOT7qMLdIxR9hFTgEmjkzkBfJ2NRbdg5dq42/ZDtCKTZXw7XmsoyUlteDujnvIRj/hQkHJjgTJYF3wxxuWvX1QhlkAUYDocbBaa2+QJ8zoxB1tp3/igUGR8hFBkBqIvkyf/NaoVisPR53nucXBPd0xD0A/0w7IipR/MokVlNRFJBRT7kbvVewhcV1anbTfdbk6IeefA2PmJ47CsNgjwWiDCorH4SuuyMRd9c1FieQ2OajI35N0E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 16:49:52.7241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c38b8e-021c-496f-8aa8-08d5933998e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 11:32 AM, Jonathan Corbet wrote:
> On Mon, 26 Mar 2018 11:28:03 -0500
> Gary R Hook <gary.hook@amd.com> wrote:
> 
>> Submitting a v3 because the example could better illuminate the options
>> by using loop construct inside of an if, addressing Jani's point but
>> without opening the door to later criticism.
>>
>> I also like the verbage in v2/3 better, but I'll let Jonathan make the call.
> 
> As I told you, I was applying the first version; I did that last week.

Forgive me; was out of the office. I've seen maintainers comment but not 
necessarily execute immediately, and therefore I try to learn how each 
works, but here I made an assumption. No worries and sorry to bother.

> 
>> BTW which tree should these be developed against? I used torvalds, but
>> I'm not entirely sure that was the proper one?
> 
> The MAINTAINERS file will (almost) always answer that question for
> you:	
> 
> 	T:	git git://git.lwn.net/linux.git docs-next

Good point. I should know better by now.

Again, thank you.

Gary
