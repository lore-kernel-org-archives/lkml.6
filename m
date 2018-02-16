Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeBPVTa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:19:30 -0500
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:30592
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750730AbeBPVT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:19:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180216194415.6103-1-david.daney@cavium.com>
 <CAHp75VfRDWC1DAhHK-B_2rGLdLGG_FjHmYAmRS5ucspaUoJygA@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <55b1edec-f93d-a25b-1736-d08783576424@caviumnetworks.com>
Date: Fri, 16 Feb 2018 13:19:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VfRDWC1DAhHK-B_2rGLdLGG_FjHmYAmRS5ucspaUoJygA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To DM5PR07MB3180.namprd07.prod.outlook.com
 (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b35a78-4036-4ad2-ea47-08d57582f47e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:+WmNauvXEahHfbDv9rVaoBeLyyb9/y7WmSCyIHCM3AsG0ueIoLtwcwtmB9YKnrKrXANKlvcAcONZ7TPr7Lw/rTK5wNUvTnJKRorRr46n+aswkSRBKEe4QM5SD3dhWlb2mlqtT5qlnj2T3zp1W8nfJbNohSA8CTXll1cKxvJszqHHwjCMX9v51ZHpZyuejgNvsKFPMymZUBwN3I0yrHp5K2AdfwBKAbVA4U3OUjurAOH8ZbEdNK7mrptu92xBtz4Q;25:qeafAFYuYDSZKRh5tETwAyeirpDUcMC1gkfhE1bWXgBg72cpH+DK18s8ey5jwCALVaF1grgUTxoi4nWz31zn6hsVsgSR7hKFSL4qOCADTmqcBrey+bZfqptJe752kD0Eu4+7Zs5UWzlp3wj3q5I0/UzuTdwwek9agjesaT48KeUapBlZjGmc/5eRXBslMaOom/3wsQx0LUUkkn1S5QQcosXdaEyVBpQKbSmm9gJmrNRe9AWMs5a7Tz7+RLJd6zxE/65ifDepQAwpDwopdrov1TnpNfLuwcj4P8S6txe2J5IdrhXNE4tSChWDJJn7Va03fagh9TbKFm4dHvJn+Za6TQ==;31:KbgJuMOW0n5PiVhNy0wdkkJIQjz5wC63TDsQ5UJG19z9vR/RVNll8bsIGSNi4TKkPRv+uKsz3JTGM8YvSitXOh921D5gTzqmrAYjoT9fDj+3GBCzgh6bx4EVPC+eq1jeUC31gVTy41ZPjqsOBf+g6GCgQK0jiuKXXVL6KuMenCkqgGb93ddynZwatdZ/DlXCA6yfMr97VSIUQB5Mwgf1h7lCU5FCryuPoDtlxwX2zDo=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:Y2p1MPjCL5bx2ZtHfdAD6MRB6YDyjfpnjPUQXevVsjsqjm6hQJBuGa0ptlarqi4GsbJyd+jtlwBlhTXYQg/HbgF+tvc6L3UHXzM4lHCEuLlbX3E8hbLUXs16kEw9qMnXPR80dlr/rXeaYIZw6JtF6hadlZxhNfAiiQQUQ1QrJ+t/dHZYU4DRWFWoAjwf6RJBxxy60UYubnaWW8XDnNex5omd78XKsXpm4PfBrEq1AOi110ZOLlIsBWjS67/NbM85idnvW6KV93oaYuvgXa4ep4/zG/KqM97sF922hBfLQCetrxI1XVZZft2QfXHKMqxK7AtEUhrF9faNtIOR6e47HVV+utKH5mb5c6xVtYzfcgFgM2d8PEnXEJTHZOu2ZFpTe2p3DD2JkneEshIh+EYPpPfWajrZGJz5pVJMHaU2LHkcib9CQdUFTQ0daGZUpIDm5Iw3urQfROg4lWM+9MLQqXSyoWA2jsYwJhYbXj1nYPkO1vHp05RtQrMoYABEnQ7wNZWq5/hRcdu6YqC52t/mDAyoU7MpewmjPRr/hiPe4JStDlKBKXzGveeZP0XGiKdkcb0CH95XtNhuwzWc6ln2Sb+VNVjXVjHux04O+dAAtQo=;4:caXRp4cS0okjYqQTprwsuuzqnschglFfqkIJjx51bkPSHRr/yXL6hPLuBENcIMsu2qhKSQhLEM1oL9cUi5QOaIfI51DxCKyPIQCQDA7QVgsdWXN3Dcc3sj3YdWDaBT29wZavhWE9tPguoOwsB8mQ+eyITyiinPzfp6i8FZu7ivgQLVYTQiUT9cNdCiZGmYZqCjrOs9yJgemcNoJPYZ+O5Od+OyoSfqHrD+kVkRzPc4BSMbVYuF3NtfMSndLkOoHhpaHCQ3SCcx61aZ4gquQ4/w==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3180F9CB8B00B7066502C66297CB0@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231101)(944501161)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 0585417D7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(52146003)(58126008)(39060400002)(5660300001)(8676002)(8936002)(54906003)(81156014)(76176011)(53416004)(4326008)(229853002)(31696002)(81166006)(6506007)(106356001)(31686004)(186003)(230700001)(16526019)(386003)(110136005)(83506002)(2906002)(25786009)(26005)(316002)(6486002)(23676004)(65806001)(65956001)(2950100002)(47776003)(42882006)(65826007)(66066001)(69596002)(7736002)(2486003)(72206003)(305945005)(53546011)(52116002)(67846002)(478600001)(50466002)(64126003)(6116002)(6512007)(6246003)(3846002)(53936002)(68736007)(97736004)(105586002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzMTgwOzIzOjFIVXVJbFBlQnJoVzJlRU0vT0dlUFVVS3hW?=
 =?utf-8?B?bmh4MVZrR1pPRXZEaHhUUjVPUkdIMlp6UTJBNkNrS3ZnOUtXVzlKeERtTEJr?=
 =?utf-8?B?N0tNNlJyc2RKUXlZVmNwMTV3Wk96YzlrOFZTOFJJc1ozWWMzbG1iQmdFbzZI?=
 =?utf-8?B?cnMwY1RsY0NJN0pzZitRNEd5cy9KNVd6eHNxL1IvdmxrSlU4Y210NmFrS3ky?=
 =?utf-8?B?VW43aitpZGI1emF4MU40TjJvTzl0Sk9rVVlTd3pvdUVhbU5IamFud1NpWHo0?=
 =?utf-8?B?UlJMd1JtanZKRjFoU3Q2WXNnU0NtSzRKMzZOajdDMDdxMEoxYXBlaVZ4RVAz?=
 =?utf-8?B?VVVRNUhUYlBpZ1pVTURPa3JkajVKeDl5TmQ4YUNZVklhNnM5bmRydGNMT09w?=
 =?utf-8?B?K0FTU2FSL2syNG0zd09EeTNPK2Y0UEEzWGI4bWZnSGxwdUlqWDBPbzBTa1Qr?=
 =?utf-8?B?S2JoNUpXdWVRN0dQdzNGSlprT3ViTXg1VkNFVy9LbEhNYXBiZjRBMCtRNkcr?=
 =?utf-8?B?aEhiejM4U1NFZ2NkRmw3SCtmRGk1VFQ3L1Btc1BzUSs4eU9BSDY2QW1lZHhS?=
 =?utf-8?B?eUlhMkdvQ2hNTmR1V003N2M5eXp2WTArV1hWOTQ3NGFKMSt3T1NQYWFybGlZ?=
 =?utf-8?B?YWlZcGJEZDVPTUFWZno4MzZUMFZlejhxeFFZS2tQMHJLSTVyamh5TjkraXYz?=
 =?utf-8?B?dXFhaUFQRXBDbTlMNytmRWVvNFlySGJiS3dreThQSnVCaFRJU0hDK3FJZUlG?=
 =?utf-8?B?c201ZGVWLzNDd0h0K1kwU0dRV0xCc3ZiRE53K2tkNmxQbytvN2JkdlZxUDNm?=
 =?utf-8?B?aWZFQTk3QlREbXFBZlVUazBrNkxWMG84b21BNjNGL1V1NHJFQ1R3VGhuUkFs?=
 =?utf-8?B?bDZwaEFPZVVnemhGcEZLS09QOE9Oa0s4a0dEWllFSmVKc2tkKzdjZjRoTHJD?=
 =?utf-8?B?d0FzK09xOVNnc0dtRHBEVmlmZElwc2hRSFdnOHRyaVl2d2dWS1hISi81KzI4?=
 =?utf-8?B?WUowS2ZhbUVIZE5BWThtbDJqMkw0ZjREN1dGaUozNW93TWE1Q3VHYkJVRnQ1?=
 =?utf-8?B?TmJPMXJnRlllMWIvdVJ3NjVZQi9PTTlkNTIxR0d5UnJKUjl5dzhYUGx6UzdB?=
 =?utf-8?B?Y1R2WkRzOWg4REJyZlV0OEZzM0VaV3NzbnJGOC94MVFuZnFzUVEySm9qWUdi?=
 =?utf-8?B?Ly9UV3UzaVdwYWxDbTMvWTdaUXJIdmkxMTJYL25zMU1pRzlFKzlDMWNxc1VQ?=
 =?utf-8?B?ZVBKNEg0MkpTNWZXZWI5cm9iNGJTOVB5M2RROFF0K0xYbGxlZFFWU1JmYTRN?=
 =?utf-8?B?T2pBN1NuWUZoQklLNmVPTTE4TGFJbUNPYWd4OHVFVEMyM2wrR3NVR1hQYXN3?=
 =?utf-8?B?eWJKVUNNeVNZdEJmY243ZmxaNWtRUjEvN25kY0NRRzVSWnRVbFhlQm9rT3BG?=
 =?utf-8?B?cUg1T0RzbDYyOXlRTzMwZXlyd01HRDg2Qm1hWTQvY0oxQUZqL1ViM1A4dWJD?=
 =?utf-8?B?V2VMQlZMWWpLV0VMclQ1V2NTcVNJdDRaRTRBRlh6MXZ2TkdBTjlnTEk5U1NY?=
 =?utf-8?B?azJwMGxMVkR2UG1rL1FPZXhSbHhlVDdkNVl0K3V2ejAyNUZFb01KckZML0JW?=
 =?utf-8?B?dE9VNTlqSTZmNzNlaFIvcWp1akJ5dlEzOGYzM1l2TGtsRkpjRWxaNThnaGpz?=
 =?utf-8?B?dkhaQmIwdmk3OFllMkRoZ204WjBzZ0VPNWt2SnZVbFFBK1ZBdjlBa0NoeEJT?=
 =?utf-8?B?b3laRkxoZmFaVm1hc2xIYU9hNGo4Rk4xZm9EcDVnSXovWmlCamM4a1JPcW1m?=
 =?utf-8?B?UzVvMlRSaEozNWQ0ME81bm9CTlNxb1pndjh2VHUza0NuaEM1V3F2VW9Gam9N?=
 =?utf-8?B?S05QZzBYNExyalMyYkVEaExUOXMzbjNQT25ZZVdaY3d5REJJVGc3dHU0TnFD?=
 =?utf-8?Q?bly0P12JHNbesRccWrigcpoa/+rmBU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:aNX6axZXHwkerOQVIlnU/mumWrMpY63b13xfmwr8PEEX+3t4ShTysOaoGB6/mPceIG8GCXWQP1fRuha3Tqi0F5xUB0RAJUrRHvKsclScwuqipJepS4L2MJkBmJbIUp29BIeAOEeKNEFMosoZeI1MaS+1aZTZNSQSbAHP8jMsbWY9vomIL8i+b9psTNfL4IzDbIKIGPXpKwCCLS7iwRaJ2Idm2C6kGOWv2kIClhBoMWAU7jx4qMBD/zF+haDgtNCNrU+U8sD6JVLO/NoJmIJ1GXc1GpeMXXwY1MuqhmWMCAOSapowfuIDIOV+uHm6EiZdeGmsI8aCr1NQ3bgYYcOa4Qc8D2INQUWTZ9HR2ukQIbU=;5:96FqLVdxS0iSfKAqFigvqRK1FkU3aou5omwHkCUeT7OBxYmCnJhq6HlfDTt1r2YQFw4MRrNsRI+s7bZpMdrws2pxlZTTucyZE6w3LK/RydiD64G8ugeSJs0+epx9pffOrbJBX0+/mzCFWfIiTn1vGw2nF9GS0LUpiiXdaY2GxwE=;24:RnfQ+C0TsCHYz7c5KXlNJQGXQ/cDbyJUjJVNCdOlx00M/ivIdkIzFREPWyHXTXRC1d3B0nsCMfVlIXFRSL9+c0Vkp+MVuhrFwjtdWrLKU3s=;7:tQy0Q9U7E9suqPAMIY/mNqfKDXl0kd5VyENPoVGgjey4caiZebJBmfKaDvw28RYzHFH7V9eNetuwI3rp2dO35r7OqoZxWezsCh70ix2clWSXh20JezCmfK1pDrFczCpMVaF6lEQbwBTdxMqMy3dW9CrqGl3KN3EziOHRRb3zrB9+67g/wbnRQwRzHpCIs7oudmzu8qCXKWIoGEBiG5NHL7gIO7gLE6eC74ooILN3hiDfimIoSqOutjAJtOnMX/7/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2018 21:19:24.6262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b35a78-4036-4ad2-ea47-08d57582f47e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 12:13 PM, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 9:44 PM, David Daney <david.daney@cavium.com> wrote:
>> The ISL12026 is a combination RTC and EEPROM device with I2C
>> interface.  The standard RTC driver interface is provided.  The EEPROM
>> is accessed via the NVMEM interface via the "eeprom0" directory in the
>> sysfs entry for the device.
> 
>> +config RTC_DRV_ISL12026
>> +       tristate "Intersil ISL12026"
> 
> depends on OF

It doesn't depend on CONFIG_OF, it builds just fine without it.

> 
>> +static struct i2c_driver isl12026_driver = {
>> +       .driver         = {
>> +               .name   = "rtc-isl12026",
>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
> 
> /of_match_ptr//


of_match_ptr() needed if we build without CONFIG_OF

> 
>> +       },
>> +       .probe_new      = isl12026_probe_new,
>> +       .remove         = isl12026_remove,
>> +};
> 
