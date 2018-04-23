Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbeDWOtq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:49:46 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:39698
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755414AbeDWOtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:49:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com;
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, devicetree-spec@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
References: <20180418222905.10414-1-robh@kernel.org>
 <152424282214.46528.2511757264045171935@swboyd.mtv.corp.google.com>
 <CAL_Jsq+1G61+E0wtVEkzann3Z=2Cr=2PkbDJ_OuaA5GysWZsXQ@mail.gmail.com>
 <152426770474.46528.1592920281091105196@swboyd.mtv.corp.google.com>
 <63a1c096-7d78-3850-83b7-94c6009e93f0@arm.com>
 <CAL_Jsq+te3o5=X=1n2QHfrLL_MtoiL92_p8jN2=UeFe3L7mmNA@mail.gmail.com>
From: Grant Likely <grant.likely@arm.com>
Message-ID: <e8fdb764-77f4-6631-c9b4-a6cf393a69a7@arm.com>
Date: Mon, 23 Apr 2018 15:49:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+te3o5=X=1n2QHfrLL_MtoiL92_p8jN2=UeFe3L7mmNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Originating-IP: [217.43.212.223]
X-ClientProxiedBy: DB6PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:6:1::15)
 To AM5PR0801MB1746.eurprd08.prod.outlook.com (2603:10a6:203:3b::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1746;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;3:WD8+XNGvv1mF07D2M82eQL6qEKoVXXAKQHoGuaEt5++nSh0KxWvR/2SqIA/of6mniOCFKyuhG6p95XJ9iDoxj/y1B2BeVefn027iePdeJUiE6b8/pE2kQFd11mpHvqCh6jLJAj6pAH/UbnyylDkHybeKfRO3FFGelzY9RTxb5gVUpm2q+liZXt7xqPyF/XztEBs3LcKFOu50+sS8B/nRs1SlPeQBNNLXhPrFtLXc+8UoFdq47O+nhlRqLnD5j40b;25:xkCN4+rlodCbR/V510dbKn7mijhhok6Rz8+qjSZcdQdvZU6riFNYL5FikILwxZyz5u2+jh++BewHNWR11aO3mUzmLkyrU3CIjmM8FtshNTS4YfqGzN3DTnRhNVAVKuxTkkSb30W816pckQzMvgNIrDuIEQ/d4TuQR/9nvTnLYb9SZQOhn7LYJTuE2Ih6ov5WhFHPDFivnlTwWSTvk1OU8bNa9njNTHJL+HIbGCksfxeeOBjsVLCLD5qqmnqZ6dEoD3Is7WsIn4ARF/xU064782CNbSsOvgWtbM8IDwGUdFMTP7cM5sOvbX8Jw7Eocfnfs8LNKVEramMvVT+UOwQCeA==;31:/ryuyc4zBYNHJLsBiXtW5N7UeZGTI40XP3MCWxJxTP99itzi7AsOFQCPTKaqB45rtqFX6Gdu7ikvzWHMAQKmgi/qzhXEExEElHYzyBb0vRUlq0M9Jc1E9Ni0XiMtLodd5OGaJf5QZW5VOSA4OWkKCxPANXkH8t9xUIgvr0B9i0Kj9u8Dg3GzvQdgawCSYs5vaEANrob2u5r7THw8oAddaXSbIFLqD5XSC4WB72q89cU=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1746:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;20:iOxUnI2OlmUHxgk40dKcwWjGlbRUe9CmcNKXfPnL3HjgWAcQmSTUje+JRIOm2nFAC8IKYQFTOAuXR0n22ckZBRaQOUctWIkGLgSOc/zvQyBke040lyPAhLDKKxwsj8Ft9UIo5CN8LEHAXPOyG68cjWc/LKlzI7t7Qpx2qTD5RDGGCDVhPbhwVpeXuMGXRWs/yn8G9eFn64fi1IgiSX3XOk1sufLHYBzbuDSb45w2F7vGsd3dWiXIgBQr9Mw8CNwpD8aBE6vK3S/L4d+0E/dQsUib5poF/ptmpXuTYCk9UWvLHm8CPm6FOY2R53GXtyWRb9Nmo7AooVlTKa/oYFlRvazKXOk7NAJOaX+EJfViMbICEmJBKM7dCXo3zj6ThYGmMClDjb9Oifc7owCCPRWgT0u+Ocva0RpVMJQIdFjcqMDpeN/n6WpeLLmnDfGQtQc+A2nxqZ8mkozF3OBzpme0FTHi+tCcCV7EKyqeFT4Ntw+UkMNad9lsATmMxV5gBGr9;4:BaQfeoBTPAdfB3ChpIcvXlWZV2vixf82C7vgRUMcfNItm/jc3ir/62KIDHesW1lalsuY/0EQZtQ5ujGfkImQALE5fQPMgumY9f01jSLVdc0pHiyOJkhEB7Rr3iNuCHP8jJL5D6EOhHe0Vz2aHMM+saeQU0/+J2s9W5AKjRgn+qL7ydmGi9U7aFosI1r11TblxTahqzSHSWJEfrpkudELsEMH412MvdiznambfDEvw6kRLhJkksw1Ik2JvyJXLXw/0KoG2WQSXQ4NiT0ZKJXJoBXxHaGcU3n5rARRCLpGpeTbxV2Xr3F4221W52JVLA4R
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1746E834D3BB1AC7D3255FB795890@AM5PR0801MB1746.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0801MB1746;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1746;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(377424004)(51444003)(40434004)(52146003)(39060400002)(65806001)(476003)(956004)(186003)(76176011)(26005)(59450400001)(6506007)(25786009)(6916009)(53936002)(16526019)(31696002)(53546011)(44832011)(65826007)(305945005)(5660300001)(7416002)(446003)(4326008)(11346002)(6512007)(229853002)(6246003)(2906002)(386003)(23676004)(2616005)(478600001)(54906003)(8746002)(93886005)(58126008)(316002)(8936002)(64126003)(81166006)(6486002)(53416004)(66066001)(3846002)(2486003)(47776003)(58726001)(72206003)(575784001)(36756003)(52116002)(7736002)(65956001)(86362001)(50466002)(31686004)(5890100001)(67846002)(8676002)(6116002)(58736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1746;H:C02T10KAHF1T.secretlab.ca;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjE3NDY7MjM6Nm9EWUk3bkpuODczNHpFNDVBbmxIdm00?=
 =?utf-8?B?VHVuOGN4ODE1SGtyQ2ZWSTNFTWxNbjlRNTlQOGN6QUVod1RaMHM5ZWt4akhN?=
 =?utf-8?B?aURiQklaYzRjSTlFYmRWK2h1SXNidkI3SWZ0bVZtVUZGVCtscm1oQ2dsL2Fv?=
 =?utf-8?B?bXRrdDBrd2VYak1nWDJLcUVyNUtpMjcrK1U2YWtTa2FvSnE5Y2ZkSVZYZUIw?=
 =?utf-8?B?S3I4d1JlT3J2YzFwZEwrOFBpZ1YxLzZ0b09HdlRuR3RwRFpTQnBlRkErTUtu?=
 =?utf-8?B?V1N5Mm1LckZ5Yy9HU0hLcHo0eEpuTGRDTE00bU1nUktBNWYzRDVIM3czd1Fs?=
 =?utf-8?B?ZVh3UzVBZHE2cDB1L0ZlUWZaWUhobnNTelUrSDVvejNQcnhtTFRQRDVBdlZh?=
 =?utf-8?B?Z1dkbnRhQytUczNGb0NwdDlUTnArN3liT3A5d01lRk91dTRZaDFwWXg4N09N?=
 =?utf-8?B?cHhCUlBBMWgvSmYrVS9PTnhRQWhHYjZSSGNuV1NBdUhBQVZqVzJYNlhrQklF?=
 =?utf-8?B?N2hvZENmSzEvc2VtL1lGRjBxc0RhbkYrODFacWtQTEIxd0xEYjArYkJSOUlO?=
 =?utf-8?B?UFQ5OTh0NElWNWNHam5rQ0tpRFFKbDNzY1dBK0Z5K0UxcHhSdkFmUVJoaDBz?=
 =?utf-8?B?VDdFVks1OS9DdDE2ZHhKTU96amJndDZOMmhXbGJYM2pSaGNYU3BxdkthSFk4?=
 =?utf-8?B?Wm9iVzNwNE1CbDRUNkdWdEZKNENRcEhSTTAxUnhZTGJrWG9UQTd4T1crTzRq?=
 =?utf-8?B?NXd0ZzVzaFRzSmRJV2p3eFhvT3hSRHFEWGQzVlIwMzgzbGNOTUxWMnV2MXBQ?=
 =?utf-8?B?M0ZVeVpZL2lrcW8yMS8wSUJObVI2dEpDL0h5aXArZ1dqcVVQeE5OYjZNYTVJ?=
 =?utf-8?B?Q2VGcWNaRHJUaUhZNC9NcnpFS2lqNjE0QU4xZUk4Rk5QckE4dVhuQ2pWTTlE?=
 =?utf-8?B?OXFKWm5NL1ljV1YrMFNaQXliSysveVBSdjUzekN1aTBpZ1BMaXpmL1E5Tm93?=
 =?utf-8?B?VlVmQlA2NFV4QStmWm84MUw1T1VxOSt2S1FWS0R2d1o2aktEVERMQlg5UnhJ?=
 =?utf-8?B?QjNIa3JuRDFoV2VJSjlZclEzY1BZMUhzK3oxVWdGbUNhMXg5YXE2TlRsNUtI?=
 =?utf-8?B?OVA2REVXalRiekMvZUpXT0xjSXlqMlFkUXpsSU4rbyswa0hDSE1YcDFOVkxF?=
 =?utf-8?B?VGlZeUFod0dhK2tXTmJmaE1zMzNnTm1KM20waWpwRWJrL3BRYTdrRFd1NkZq?=
 =?utf-8?B?NXVXZThLNmwzc3pHVzQ1L1pQdy9KK09qMnZnQ3cxUjJQS1lOcG5nbFQyN0lx?=
 =?utf-8?B?YWdMcUdtNmhONDE1T1FJbVJuVStUbDZESHdUdnh4OHdhZlhGeE10c0dOSnhk?=
 =?utf-8?B?THJzRlhMZFhIaVl1ei82ck9pcFNxbGxYNVh1QzhnN3FweDFvUnJISkVETVM3?=
 =?utf-8?B?N3VjejgxUjR1enVVWHVLazRhZ1BNMWtIV0pteWkyc0ZIRDR0dTU1YkhwbXNo?=
 =?utf-8?B?dHE4THEwS0J3VVNDQzNERVBlcm54d1ZJRFhkRG5uTE4xTWI5b09nTzUzbzNQ?=
 =?utf-8?B?MWo1OGZ0V1Nsd2RQRksvU2NITkpwbzdvRFk3WmxKc1BlaEZ1blViQldDczVC?=
 =?utf-8?B?YUJNdENQUXhoeFBHb2V0Z3U3aXlULzlhajE4UWh1TWpaVlQ0ejdzaHo1KzRz?=
 =?utf-8?B?ekEySHd3SnJZYmZwT2VUQ2oveEJjSzJCUHorN2xNWlFNQi9nUy9raG80V0pk?=
 =?utf-8?B?VjNWSnd4RjJnN255OG92MkRKY2JhNGhiMlBVWVg0eUJCKy8rSkVjQjZ2Sno1?=
 =?utf-8?B?dXhkVE9EMG10cmN2THkvSHg3TGtpUXNMMkE4ekdjc1ZTTXVXLzZlSE1sOU1Z?=
 =?utf-8?B?UThUclBlWlFpQUN0MDI0Z29ER1YvRnlZSnkzZ0lUdmtpZCtNNmFMQmYxV0VU?=
 =?utf-8?B?alFGbXRDZXRmb1lOUzFBc1JiQnF4VEJ3akRqbU16VE1KMGh2M0dGQlJUU3I3?=
 =?utf-8?B?MzRyQ1RtZkFVd1JpWDQrRytVV2VSaFYvbWdDekp1Tklrc2FwUmF4cWxxL1Z0?=
 =?utf-8?B?Q3V3UjJUNjhSWlNkS3VoU1hSL0c5ZDNCdiszQWhLR0JaUVlteTY1clVyUXha?=
 =?utf-8?Q?JOEfGL1+xWAKAhkfShOP0UcNI=3D?=
X-Microsoft-Antispam-Message-Info: mEmHhurHpsvBioqQQH0UTSYx9BatPcI00Ly/A2Q/GmmIQHHABy4F1jeCNjvsQgu/yzHoNsrtT/C6i3KNlOJfI8xgBRIK1yLtLxg9XE9dA6fZ9s+jugwt69AuOWUa4XR0Ctwomd2JTkDh5y/cHnUXFhPWWzWTBC+hQGGy7nRKzwt1j5BxKex/pbasfhrP1zq0
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;6:gdPZZaiqjBXxswKd+3ZLqNh+M4CQVwxlc1Qh80nIQNmc9WrVYK/obB2UKKte3+a6OXjLt5RQ1zbfWM18BHQ0fETdF04CvJFS1IDDsqYOFtt3hon5NyqK71f3M5htbsWO9qNKXyhACBcTL8RYm0Ds1eCr3BvjMHn3rr6cPMExt+7NDDFuxvkAM+AqwgZ+ZgOIrmdXcmVYxfp4lmeL9A29NNl8DZ9z7A3ffbAQ/tOznMX9UEytVUVyQ2RF0bfEO7yN9YKgKOS6PJr2s3PwbM60OgF6EJ17B7zQu8KXl2ZZJnEhin2+M8iHCR9TWa4GpiztvZi58ABbjhh3sav22Fcb7ZccCG2yiqGS8aI+YJO0l2VxQNyjRM8C8hixFz78Yy0MxaJbzI4bMU7OMP9Cyz0nK+zDMqIdLOgTR1mvmMbRsd0Nd4n/JWlwSyFv+Gp0Ip9RblTS4W6Up6TzVY54R2HNvw==;5:Upj35d2VXZ2Qs/DTLaIQ2AZ2cSQwslH/obqD8PPymAWV/NASLKCuECzoOMy7bEOmgLgndU/BxWDSQuU+UhXjBNCo/RO+2l77WzNSj4bDCRmuJKbaq0/L4jrQq2rLxzGJXaycxgRCwQy4rMT3Wh/q3U3m8RJFnrYau/j+oFAeXN8=;24:9PS7Fmn8rEosU6Z3lBnzQOWMvCuyjvP7w96WlHM6TeKpZVZNDAXeaQqnH2f5jLT61pKPXQ6khEB5cg7f8jKiE9VFBV1ele6dKi3A8FIN6Cs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;7:Ft6XE7JMpbeHvm90TEcK6RjHQoWetq/pNlUxePsB/XFjPeNh+Fxi+CmAdxSjdVMpfSj4IA6YuClZNJgkzKPgGkikVSGfgxFmx9SI6al1bTJmRFlmV39ru9V20IgN0/nCJtzEPktzD1lh8GTsJfvcaNrOMm7Gi8JD+HGErRgGg2kjPZEV0aDAGNa+v2iHe1JIMsz8ZG8ODMZ/v7oTSSiy0BULVVknYPgzSUNq1n1m0NTQ0ed4jLrRnnMdC6Tx3AKt
X-MS-Office365-Filtering-Correlation-Id: caf3942a-ba71-4910-8a66-08d5a92970f6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:49:38.8158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf3942a-ba71-4910-8a66-08d5a92970f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1746
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NEnrsK016665

On 23/04/2018 15:38, Rob Herring wrote:
> On Mon, Apr 23, 2018 at 9:01 AM, Grant Likely <grant.likely@arm.com> wrote:
>> On 21/04/2018 00:41, Stephen Boyd wrote:
>>>
>>> Quoting Rob Herring (2018-04-20 11:15:04)
>>>>
>>>> On Fri, Apr 20, 2018 at 11:47 AM, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>
>>>>> Quoting Rob Herring (2018-04-18 15:29:05)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/example-schema.yaml
>>>>>> b/Documentation/devicetree/bindings/example-schema.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..fe0a3bd1668e
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/example-schema.yaml
>>
>> [...]
>>>>>>
>>>>>> +  interrupts:
>>>>>> +    # Either 1 or 2 interrupts can be present
>>>>>> +    minItems: 1
>>>>>> +    maxItems: 2
>>>>>> +    items:
>>>>>> +      - description: tx or combined interrupt
>>>>>> +      - description: rx interrupt
>>>>>> +
>>>>>> +    description: |
>>>>>
>>>>>
>>>>> The '|' is needed to make yaml happy?
>>>>
>>>>
>>>> Yes, this is simply how you do literal text blocks in yaml.
>>>>
>>>> We don't really need for this one really, but for the top-level
>>>> 'description' we do. The long term intent is 'description' would be
>>>> written in sphinx/rst and can be extracted into the DT spec (for
>>>> common bindings). Grant has experimented with that some.
>>>
>>>
>>> Ok. That sounds cool. Then we could embed links to datasheets and SVGs
>>> too.
>>
>>
>> I'd like it if we can define the description text blocks to be
>> reStructeredText markup. That makes it even easier to integrate with the
>> specification documentation.
>
> I think that's going to require thinking about how each binding is
> integrated into the spec. We're only talking about common bindings I
> presume, but still we have no model defined. For example, with
> properties, I'd assume we'd want to generate a table of properties and
> we wouldn't want the property descriptions in rST because the
> description becomes just a cell in the table. So we need some sort of
> template.
>
> Also, how do we validate that description contains valid rST? No point
> requiring it until we can validate it.

Indeed. Part of that was me thinking outloud. Need to actually get it
working before adding constraints.

g.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
