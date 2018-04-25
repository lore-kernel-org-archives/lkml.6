Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeDYKP7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:15:59 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:60451
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751452AbeDYKPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:15:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com;
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20180418222905.10414-1-robh@kernel.org>
 <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
 <d2ed3578-ca09-15a6-e688-ffb9a097c2aa@arm.com>
 <CAMuHMdU8q0VUxw-EXDqjjYbjeCwCkKuDJUjO0vSaCVrYLXqX4A@mail.gmail.com>
From: Grant Likely <grant.likely@arm.com>
Message-ID: <3a4299cf-b737-8e74-2e9e-994f5943d006@arm.com>
Date: Wed, 25 Apr 2018 11:15:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU8q0VUxw-EXDqjjYbjeCwCkKuDJUjO0vSaCVrYLXqX4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB3PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:8::36) To HE1PR0801MB1755.eurprd08.prod.outlook.com
 (2603:10a6:3:88::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1755;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1755;3:4L/B2vWIreOgQ5NREBNSTa1gS8gVo52Gv8QymCsBdiXdLure89Zu7SWl9tldOWiynQ/kzN7RiECWk4ekEP6oVLIG0noeEcu3CVhZN7boMf7O1IHF+RvQvyCImeeF8noDL3inIYlVtYuDU5o3xOgXGp5F7JDbOl8pTO/cwsk8nooaiHJDRSSmoR0wFPSagP0/s8tuV4OizRFS7b15zCcLpkmTw2ACVVygxFtHfVV40xPwxwaMQudRcRCFwdPWfuxn;25:aoErt1gOtcWnpns9vcsmUQqINv8ySddL84uenQsYkLzAIDDQmkj58OJ2nd+UIWwRobAK+rnJkTmjNZT8eRW3w1hOMh0d5+TQbJ7Gd7I7wgNkDc7KxwRQdCQQw8CuK+9nMTSpuz2zmtTQbOUVNFEc6s/L9xB/21+SSobQ3HzqK53qJ9feDO3sCamllaXYDmUR+m+r1SE7H/l3mnmM+ngYu41NrQkMcioIp3Nxgy7+5CEaBY4Fx4z++NnWvL3hOuc89aeIZ/zvGmp6LUl+87l/TkrR7mWzY3+4W5m2m8gXfOzJbtRKBgtle+c6NQ4eEY/pLxSxM1PmBIr9q2zJ2j/gNw==;31:48TRdlubLZyYI76khD+ioPd70dA1JHmGRCJdfoJqaD7UYS87uAG3/zEfhIpOtPdVBB9UoEtYCQjW5oW0Dm7ljxXZb1M/Xy/J1wEGQP2Z0vnLMKJt5litupNUC9QUuBlhZFrXY3DnrHs9IgZI2Hf/5SSQY8UXTLx3YUJRPqG8QrbEW85KKyVhCU8u6OBrgc4NkZE/H3e9w2eIf20L6lPAYUvGIL/wR2ogVjAjFBfFN0Q=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1755:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1755;20:yTbGpNWS1MPeP90GjXca5uEnM4HRfq7+V5MRc4aSm9+RxjYd1PHgaZCnOLm8DvJ2rryz/lShgvozZZUHMxwBbvZho5HmPZThF/A5XtgmFhurW9AlP8LJ99+jB0h8ceg6brRgPll+5GZ680qhmRkhK541ecaNrRxyZj0YfZdhq8TAJGIKIf89Nm7+qpfaiEZENiN7XjKYPnwWW/BKyKu9hoo8jZ4avB/Y9t9ANT2KNnGzUrrwxt+/y6dYfhQiYrtVZnx2Zo4S90m7AajQRxQv1pYXjJZcpVQIKLGvjsy8KOP5QfrZyFqAItgkq8kEbRy5PFOqPECBEk+PjBPh5nwxUvRa/Kab4QXhcfh7auIHaOA2jzYvFkxaDrEbfCr4FBrrlvPPVIuz63vd+sD5iDLgGu+pxqpun6ypHfY9NomL/gvAAO6JeWJ3HgqqoaUM77xdsP8huA5PjEjB2IbgkodyNZtslj9aqdHQ4eVvsyVG2o/OXHGc7SwaebcgZeE2U1ZD;4:JZovI2SA6g0oVgUoWwkVZbx9TyvAv9Qw7SkG1bjqFvYMHHhDx5aghj/KtGhiHajWCNzeTDm4Qli7+pXKoIVDo4BTyIjh3GOP5TVV4Ye+ReyMV8odAF/FgY8HXB6BeiCkKzk5HohBZYGtCts0ufX3l2z8sIU9e50vQv/Vov/jI5TNGuErJadG3XniB1yaQPk+ItixnNRBiOohm9mmkImDfPRvJGmOXNetd9Qdv59+sd0+2N0ZlMj6Oq+s4PtqgxuF0EDZ42q/w/DMrc5rmrOY3gIxzRgiyVxhvdPJelje9LtfcmnNwH/bbfpwd24UW+hB/vfkapMHdiBZSxBaC7x6BWvGc/1XNCg/buzBewlUXSTCIG2oJIX1E6vZkykGVJnI
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1755782D1CBF1B9140AEF2C0958F0@HE1PR0801MB1755.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(166708455590820)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1755;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1755;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(366004)(396003)(376002)(40434004)(189003)(199004)(106356001)(65826007)(6486002)(68736007)(6116002)(53936002)(31696002)(65956001)(956004)(76176011)(3846002)(66066001)(229853002)(5660300001)(6512007)(25786009)(59450400001)(6666003)(386003)(7736002)(446003)(53546011)(52116002)(6506007)(6916009)(39060400002)(6306002)(52146003)(67846002)(36756003)(23676004)(486006)(47776003)(6246003)(2486003)(2906002)(11346002)(16526019)(478600001)(4326008)(26005)(58126008)(2616005)(44832011)(476003)(64126003)(81166006)(316002)(966005)(105586002)(8746002)(8936002)(305945005)(65806001)(8676002)(72206003)(93886005)(97736004)(81156014)(5890100001)(50466002)(31686004)(7416002)(54906003)(186003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1755;H:C02T10KAHF1T-1077.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjE3NTU7MjM6cUVyNng1ZHRMYnhXejlsRVlpUFVyUXZY?=
 =?utf-8?B?VzJxMHpsYWRzOUFSMlV0THVOOGpWWmR2TnV3T0Fhb0NoT0czNXd5czBMY1px?=
 =?utf-8?B?OWxoVTgxd3B5MEZxRWJSUGszYVFiN0FIVFFkZTdhVTVUV3RINlZnV3lhei81?=
 =?utf-8?B?NFoxVEpkaGZNTC9halJnZU1CanB2MTE1b3R2Q3RPcU5DTGticmZoeG8rYkd5?=
 =?utf-8?B?c1RiMUc3SUZ3NGhsTUlYODU1TDNTMUdKVld2VmFhZ2NSbWxmeEFEUHBQTW5y?=
 =?utf-8?B?eXdNREROYkttK1YrSnZmZmQ1L0hlTFFzT1RyRVhMVnd0elczajNidmRaR0hR?=
 =?utf-8?B?MHRqaDRyWEc1WUgxUEFsNXlCWGhMZzBzQ2FQcnM4Nnkya0ZXdW9GNUFzR2tI?=
 =?utf-8?B?OStIem4zaVU3M3N2RXFCNHNKNE1ZaWZ6bGZIcEpxeW5PdlBsazZkMWZwUk11?=
 =?utf-8?B?OEdtWU4wbHB3QWd3bW1WazNhNjM2SHNxMGk2T0ZscEgwZFlkNm94bWFLdXdv?=
 =?utf-8?B?cWQ2aE1XL3BBam81K2NnSzYyT241d1hrSDNhaFc5WWM3d1dYUGlScWNqend5?=
 =?utf-8?B?TFJXK1hiakR5aDlEK01SUWJyck5xOGZqM1hHa3dyaDlXajI4NnlDYlhKcHZm?=
 =?utf-8?B?U29oYnpVeEpMVlNnVkREVFJCNjJ0a09adE53Z21oUTdVQzJzVXVzcXNXL29L?=
 =?utf-8?B?b0pUZFBWcHJsMXdyaFkwWk82NTNpOGJaM1JzZmQ5ajR4V1ZjMnFDb3NHbmFj?=
 =?utf-8?B?NHRzTmxKdjRxM2k2UllRcXhUdG1kbEFxTE84N3ZVRlh2NHdCcDhoeTRhS1VE?=
 =?utf-8?B?UEFCcnozMmMwZTZsYks4MXhyRm5kaUZleVlQWmY5anNQUU43TjF5alNPSklq?=
 =?utf-8?B?YTRaZmpwRWkvNnhIS3RxYlVvclZ5djlGcEJ3NUtLNkk1blVyT3hscDMySkVO?=
 =?utf-8?B?MHZmcVB0cHpRdWthWVNya2NDSDhmU25FU2R6RHF2UFc3OVZnSWdtelI2SVRy?=
 =?utf-8?B?aXdTOVh1VS9mTG1ENy9BenpMRno1M2pKMGlReCtOZDE2QXBKaXJIVUgrQTlS?=
 =?utf-8?B?a1N6aGtNc2xKazdBRkMzMjFzV1gzaDB0OVc0bkNmSHFUSGhDQU5IT050Nms2?=
 =?utf-8?B?a1Z5SnlmWVpuNzduZlQxN2NReGFPelZoWUFndEJzeFlQQ0I2Sk1saEdWcjZX?=
 =?utf-8?B?THkwR3A1NnFrdEpMckovaU9kY1o5UXB3SUYveXB3UHltdkNqODZrcmY3S2xC?=
 =?utf-8?B?UXY1UHpxamFHOHpwRkxyTzViUjhla1MweEpYbStoREJiYUZCY21abWtMbE9R?=
 =?utf-8?B?bE5JdUxEcGdJdFhWeXVoZmp2a2FWeGsrVVh4Q2dZck1PTXB1RSt2REFodlVL?=
 =?utf-8?B?enZFUWFBL3R3Zlk4OEpaOGtRTDY1ZWM0YTcrMVRGa2hUL2RQZVVhb25PU0hJ?=
 =?utf-8?B?QXFkMTNJUUxKTzYxVmtudjkrRUtCSGZ4dkRHeHRvVDhLOHg2WTRCSmNKdW9V?=
 =?utf-8?B?a01QRmFMRERMTFZiNi9wdkk0STYwdDI4WEZ2TnBaWUtscmhLTUROTmdaSE04?=
 =?utf-8?B?bkxhNnV5QlNGWXk4dEpJUENVYW0wRWw2bVVaKzZDdWZBTDhiQkRJVTF3dVdM?=
 =?utf-8?B?RjJNaVNJV0hiNmx6RzZGYlpOV2pCTzB6STFYeUM5ZjBXRU1PcDVkcThtSC9p?=
 =?utf-8?B?UWJvaFdyRmFuV1k4bHVRakxvOHpGbEFGUUc3aE1nN0d6L1FXNVc0MEZtYUkx?=
 =?utf-8?B?Y01oSzFjSFF4ak1HcUN5UHQ0MmE0TklxeFRTeXI5NmxHV2F6NzF4UUE5amVp?=
 =?utf-8?B?T1dyWWpZNHFMSW1VOFh6OWdDQ3BlYm1TR2ZLRS9sSGhMajJaQWlwZ2hzY0Uz?=
 =?utf-8?B?RU5yS01XU1hUQVIxSmlxMWpWZkVMNmpqUkJnVzZuanFTNGc1ZWpUZ0FYSDAy?=
 =?utf-8?B?QW8wd01TdmNJd1FLa0NBellpNHFIbmlxbXVnNUFyTEZGWVQ2dCtRWGZkS0Vh?=
 =?utf-8?B?RXNLTHFUOU5WWE9CN2VkK2VxNEpjeVUvMklDOEppZ1RpaEtVTGtpQnZlN3Jp?=
 =?utf-8?B?SVpRWkZsRkpLeW1KZmk5dGM3UWcwcitZR3NGdXpvZnpremxXVi9yZEJtREor?=
 =?utf-8?B?bG9hYk9XLzFmaitFak5KU0lZMDZJb1REZDUzMEJyMnRTUGhIQ1E5b3FQMUJa?=
 =?utf-8?B?NmZ3UjdIdDhBU2RKeU9NamxFQ2tQSmg5ZjBKVnI0T0kxdVJtRUJ2UDIwMnF3?=
 =?utf-8?Q?iGPL55dR4n9HFZg4T5OE?=
X-Microsoft-Antispam-Message-Info: j/bjfMwysH4JsfBXFdxbJx5j/cbdtqo3r6tekxUJIx5/slSUQY7ZVkteT/hHOij3bxVKCuQiGuL/lSiwr4IwyRdNOMyM7Io4iWyrAcBU7YSJwUxbzezgDIQf5Whzk5uNNPEl75qjnz5x+exOiuE0Fz6VdXVdHHOL8KxQPUK5P2xyskr4w/luFrQCk3rLmVau
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1755;6:3UAFL2j2iXAHDEaEDakESGD//yQnkYZH8JdL3ikT9ik4NF3GEHJ55oVgrqFEW+5jFPiXTgdaNF/L6zQdu/TECU3tdJSDZYcoJD5ky/EwSe8nteJN9Ewp0X8/oDH3ujvvlhp9Mhx3UrckxfH6dXy5wrtkz7ZLxk1EdfZuSsDppR+UKrPmt4VOgYuq8zMSo9OjTV4b0uPvyGYi2Eg+pTno12uueoznft+smI4nh9Fqq67H7qlYQbOeWCwDrQxs3YveF4IWyJt2/lL7hXHYpCOwN+EqF1E5U2G9SBXwcP6BcUxzR9C8kIX8ZFgBajUB0oe974SkqQ4+fm+Fi72XI7fHP46p2vAkeHIoL+Noq+2BUikRSJS8bj4fuH8uDvmntojssasfLoJZ+rqbf2603GmY1gEKN62om9RTRaDbonNzcowW3QhWQ7SnV2pniZUh4EouZFkMSSZldNAkproOEx2RRw==;5:ZbwH33pSqamaoMIGnk7Qc3UWKQ83fWauhhAyOTMyPaXQj7eixd4WpMOiKHUD3fQ0Uat162LKiKGqZCflxZhdRk1PXOt8Z1dCn9TQxotKy+CzLqZL/wht8+RvE5uq/u7IyEjXm7ihpRnfVhRmDQzZ+4oqotpFMw3bUAcR8MVG/xw=;24:FuRifs62dUP3oIqheaSC9b4yQEaxK9EKGuhz+Y9qtNUcUPC/J3+Ill380Uc7Fj0iuZjQlN79iQqettsRk8WI/PembL3sEBfzELMAKw2S7vM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1755;7:2oXjjp/jZcedphCroc7uYSYDXxoaeTygy44qdl1vf/4HP/W3yklYfynVdMACqOsKzU0taiSICxBB7x8VqlW8WIjPiSUi4DNivzR8cC2m5ci1TyaAVU7SniWaJ3nb3kk3zmCqHEcY5OUu0hY8zWcj4ijgW2KaplTRvqh4B7hb51zIFsZfu5BNc87Tph2wFvXDmCycBwIw2UmOt+Fa8g/b5Tj8ntExxQfW5rr15oCyPoCkHWTkfgMFjimL0pEwC3MP
X-MS-Office365-Filtering-Correlation-Id: e4abb382-7ec1-438b-734f-08d5aa95845b
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 10:15:47.0384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4abb382-7ec1-438b-734f-08d5aa95845b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1755
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3PAG3n9018416

On 23/04/2018 17:49, Geert Uytterhoeven wrote:
> Hi Grant,
>
> On Mon, Apr 23, 2018 at 4:47 PM, Grant Likely <grant.likely@arm.com> wrote:
>> On 21/04/2018 02:28, Rob Herring wrote:
>>> On Fri, Apr 20, 2018 at 4:00 PM, Frank Rowand <frowand.list@gmail.com>
>>> wrote:
>>>>> +  interrupts:
>>>>> +    # Either 1 or 2 interrupts can be present
>>>>> +    minItems: 1
>>>>> +    maxItems: 2
>>>>> +    items:
>>>>> +      - description: tx or combined interrupt
>>>>> +      - description: rx interrupt
>>>>> +
>>>>> +    description: |
>>>>> +      A variable number of interrupts warrants a description of what
>>>>> conditions
>>>>> +      affect the number of interrupts. Otherwise, descriptions on
>>>>> standard
>>>>> +      properties are not necessary.
>>>>> +
>>>>> +  interrupt-names:
>>>>> +    # minItems must be specified here because the default would be 2
>>>>> +    minItems: 1
>>>>
>>>> Why the difference between the interrupts property and the
>>>> interrupt-names
>>>> property (specifying maxItems for interrupt, but not interrupt-names)?
>>>
>>> I should probably have maxItems here too.
>>>
>>>> Others have already commented on a desire to have a way to specify that
>>>> number of interrupts should match number of interrupt-names.
>>>
>>> Yeah, but I don't see a way to do that. You could stick the array size
>>> constraints in a common definition and have a $ref to that definition
>>> from both, but that doesn't really save you too much.
>>
>>
>> There has been discussions in the jsonschema community regarding
>> referencing data in the document when applying the schema.
>>
>> https://github.com/json-schema-org/json-schema-spec/issues/549
>>
>> However, those discussions are ongoing and have been pushed back to
>> after draft-8 (the current release is draft-7). We can instead define
>> DT-specific keywords and extend the validator to make it do what we
>> want. We need to do something very similar to validate that the length
>> of tuples in 'reg', 'interrupts', and '*gpios' match the '#*-cells' values.
>
> Checking that property lengths match the corresponding #*-cells cannot
> be done for a schema, but only for the final DTS, as #*-cells is a property
> of the target node, right?

It can be done in the schema checking of the target node. For example,
given a GPIO specifier of:

gpios = <&gpio1 0> <&gpio2 4 1> <&gpio2 3 0>;

The validation engine could validate that the &gpio1 and &gpio2 targets
have the same length as the associated gpio descriptor tuples. (ex.
gpio1 needs #gpio-cells=<1>; and gpio2 needs #gpio-cells=<2>; If the
tuples are the wrong size, then validation should fail.

g.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
