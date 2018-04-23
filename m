Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755464AbeDWOBd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:01:33 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:2464
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753999AbeDWOB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:01:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com;
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc: devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
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
From: Grant Likely <grant.likely@arm.com>
Message-ID: <63a1c096-7d78-3850-83b7-94c6009e93f0@arm.com>
Date: Mon, 23 Apr 2018 15:01:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152426770474.46528.1592920281091105196@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Originating-IP: [217.43.212.223]
X-ClientProxiedBy: LO2P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::19) To HE1PR0801MB1756.eurprd08.prod.outlook.com
 (2603:10a6:3:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1756;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1756;3:E9UoWaF8lQRu/SV4dRDUp2jifjw0MPhoDQcj5WUDSAeiDjvG8gAKO3Ex4F4ze2pXHDkZ1qiiQiVM9sNJu4z01IBgTJVdRO/S7QFyRbfuEAUX5K8JgJOEXc+tMYi0Y6+AxD45rZ3932oj8rARDIRVF4nRIUSMf1utpGGaKFnzhvXrv3+AT+VkdoQ8xROtojnTj0Yg+6B6rNMlptue4mFK3sczif1Wnq49zKsVcMIVkq2HVXcStaxQJfvmlN8p/67L;25:+dwO/Hz6PMAdAnmUXLR9TVCS5w9kmnl0/TwK0ZRdB/V6yyDiUqvTy1Lw43lVkO49a45BQhpMpd9Z8TZcUKqJfDdUslntLzHupHxyfWUVSftALAR/byjshBTCx5JsPzLcJ9muoyPVmjo/XwYYmg8qff7aYH4QXOFwdKmc9vKyqILBJhHo3e+rgZ0Qomiqcvp3li6/Y+JCOmYKlupE1B4ON07+7/mR4dNUF0ANM4nf6LdU7Qgmok+B1aUoMEZt1gecyemUZQ4KcfsZcGmwsP4fqeM3qvrsITAMWJ9RT7nmXcziL5tSfD4RmBKw3mBkVDeu1FsAkNRMSnHnfv1nXdECkQ==;31:EL8j6+8H7W5pWhoZfLGHfhytKPHJ1PMCEGi/20Bl2kle/IpXgotOotOwrAZ7s4JwI8i+pIPBHKl9OZELv0EO3Rvu24q+vXBr9FtXqnaFQ+0JaOIKBWu8EhVpvX0Zw9c3k+29iUR4SYpwAZKI3MttiiVBO27jk1vRuE+NUruTvvhhQiHu5t9DV00fe31m2kPE8eEj2fgfXNEtxf5QxiqFXZ/j4uHI6u/Eb2nIQEYlCU4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1756:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1756;20:WjneFiyEE1c6QnHPeTOqx3km/FGepPOfb+UhvIFBxhAJkVCSEbt7OwoPmmH0Us0Eg07dfYxMp0mR1spUwjHkBgshC/zh6cqJWrhrxzcHmKsI1SytOsDNe+vrWf+zoVwuNq99L4a9s/s+X5FwS7IAvuMr6aRR9P1AeZziZIokUvdC6IzGCkoPzjC1D+hxnGJTMKIpzkdppZphpPbqYl130tmaNI65vpoP1kEOzapgqAjIG2X5VUcLWHcVZ2AlI8Fjz1mbqEbaMSNB/MMjIl3eg5AGTxs20/Zdh6HkfqJAMFXrzbuPkbFMoqKtAa7TnQSqt2ug3FIeRIE/nOyYaPSe1/GeEgPcqTLPp6ne/wKh7eV//FpcCSFFDuXIliL6geuuph5FRVEGg/uJ49yyWctDBHwwfADMvQ4ZtdUkiYxsOr/GK703vZhzkXxEXNl3q8EmhJssB8Im3VCn1WNRmeVqC+HUJ59DLRfiRnLi4WkZTFyxdjgabiaf9egr64gSOH2K;4:mr8hw27rK7o5gdKODBoo0keXmwSok54MhcV6o1erPG5nO69pvRFv9RcjmpiaxpiYBAoSJU66hT36rKPKEdqqZ96xQ2CAWlSpGAyxFIcDkSYaJ8Xnro+SsLUZNTB4YwagvYNLTWysN8Hj+DuME8bwr81zF2IwTSvIHiIIxqk4YSy1D5adN1MmsU/3sLRYSo167F4dl38wkZ2G/hM+zzyx+vrX+AuWFV7M2OohkAdPB2R2/sZJoVv1Ss87ZEY77gw4vHHJWc30I3McFQ/T3HAZsQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB175675801EBD2A8E2DE581AA95890@HE1PR0801MB1756.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1756;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1756;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(396003)(39380400002)(377424004)(40434004)(8676002)(446003)(81166006)(4326008)(26005)(50466002)(186003)(16526019)(3846002)(229853002)(6116002)(5660300001)(6486002)(65826007)(31686004)(53416004)(93886005)(39060400002)(36756003)(2486003)(52116002)(52146003)(44832011)(23676004)(6512007)(58126008)(67846002)(110136005)(386003)(6506007)(59450400001)(53546011)(76176011)(64126003)(8936002)(53936002)(305945005)(956004)(54906003)(316002)(476003)(2616005)(8746002)(11346002)(25786009)(7736002)(7416002)(575784001)(6246003)(86362001)(65806001)(72206003)(65956001)(47776003)(58726001)(66066001)(2906002)(5890100001)(31696002)(478600001)(58736002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1756;H:C02T10KAHF1T.secretlab.ca;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjE3NTY7MjM6ZTdJRXFSMi9IUEd0dlZ5SGpZRSs3djRp?=
 =?utf-8?B?eGhmS0Q5TDFaNmRnMTRHT1NGbjNvWGZFR0plbGxtNTBhU01tMk53N2FURzRB?=
 =?utf-8?B?Q0lqN1QzTTNFRHR2RU9LV2V5YURubm0wSllJL3IvT25PUXRHUFpzOXU5eHdr?=
 =?utf-8?B?THRxYTRhNU5vTjFpSDV3WjJET2daeEhveXpYbkpxZ0VDNlhldDB2b1dJSWJq?=
 =?utf-8?B?UERHWnQ5R2VYYmc1TlMwTG9KL0NnR2VtbEJKMjVxMzFhK0JrcHR4Vm1zREhP?=
 =?utf-8?B?OTg1c29RWHZQVzZGWDlJYkFXM2tNM1NDUUZ3eFZNSDY0VWYyTmtUdnBQa1do?=
 =?utf-8?B?eWlEYktlOU5aS20vTmI1Ym05ZnhVdnVETzNQN1p5aWJYNkx6OUg5QVd2Nzdv?=
 =?utf-8?B?Kzc0SUkwcUJISlZ3V3Iwbm0vVzZwalNHMmRQSDhLR1ZvTzNnMmRwZ0dabVAz?=
 =?utf-8?B?WWRCc1pScUxleVVqeXd1dy81SHp0YktEdldyRkJPMnVoZ1RCNWExaUNnTWox?=
 =?utf-8?B?cnROUkw4Ykg0M21XOHBWYXdvc1pucng3VXFmaE9paTlNRUJ4RDBjN1ArL3gw?=
 =?utf-8?B?N0I2RXl1djZYeHluTFB2Y05LUEh2Sm9STzBNUU9laHptQXdKWTl2Rmd1U25K?=
 =?utf-8?B?Sysydmp5aTVldis2b2dTeUpvSmp0WUpQZjAxc2U2Q1pveVFFMUhBZGpnRmkz?=
 =?utf-8?B?MEZEclpSenYxT1diTThoR0k3UEhXallQeWcyVVNaV0VCQVEzeC8xSmducDUr?=
 =?utf-8?B?VkQzZ0MxU29FdWVhRGdIbXUwMm1mYnFhTTBKVUd1ZTdYcnZDNFh2bUdoKytQ?=
 =?utf-8?B?ZTJoZzg4cnN0NWtJcnhSNUIwcW1QYjYxUytlK0VOcVdqdHBMcjF5TTNqdE43?=
 =?utf-8?B?aFJnMTA0RGdMaEczVlNkZzk4N01lcFk2WDR2ZVBUeHRwWTIxTWdEQzdSakVC?=
 =?utf-8?B?L25aOFlGVDVyVHFDaU4zYW1SK25ud2N1TGhrU0FpTUVLWG1KRjFOVkYvZUl4?=
 =?utf-8?B?bnd3YmhEekhVZ2VSQzdnc1Jqd2l2bE9mV3A3RmEzWFdBRU5qN3RCY2NQMVVx?=
 =?utf-8?B?UUtyWXZtVGowU1U1ZE10U1NUZUtoaXUvOEVrZ0Jvc2w1NDdLc1hZQVNOV3kr?=
 =?utf-8?B?RVpXMnE3WW9UT1pVOU5BbTZiaENDaGd6ZkYxaGtMV2dTZVIxbUgxYWRXMmZK?=
 =?utf-8?B?SENBZHhZKytISXA0dWQ3cmpXc1AwdzhLOUFxUU1hbW4yNjY2YmZYZTVZUnJX?=
 =?utf-8?B?ZFRLWXM3NVFKVkoxakR2c1lZeFZzcHA2OWY5UGJVVXoyRVJaOXExWTVkZkQ3?=
 =?utf-8?B?VnUvbXdnODBkcjlHVXMxMVlIbllieG5XSTNjTTc5QldETHVJUVZCWXJtR0dF?=
 =?utf-8?B?Ym9VbTZHQVRnVnhMQWYrY1BadG4xb2ZTanlDTEVWR2xTQTJDcllNYkpxMHNZ?=
 =?utf-8?B?YUh5cmZvR0hZTjZ3RFJwWDRBSVR6RHVXRWRGN1ljazVFejJmRFRxazQzMXox?=
 =?utf-8?B?TjVNVHJpRTUzNllRUUlMaFZ6bnZ0Zkx2aTB3YzZyYmpZdkJuOHVOMGZVdTM5?=
 =?utf-8?B?aGtnQmx4cUlWbmhsQnhnWDlNVjlIRitOQjh5eDFYSWo2WGM5alRDZ2l2NkIz?=
 =?utf-8?B?cmdvejNTdDIwU3M1L2VZLzgreVYyUktCQXp4ZVA2NkRRcE56emFHSjVmSEx5?=
 =?utf-8?B?cjcxckc3d3N4RSs5Z1huQVR5bVBsbTVDQjNyK3FmaUFVeXAwTCtFT2swV0VR?=
 =?utf-8?B?d24ydTVyRVJhZitxRzB5cEZqTVlNSyt6WGdCcHRtc0Z2M09wczM1MmpUMTY1?=
 =?utf-8?B?TWtaMVBIUFQ1ZWllMGlJeStueXVvOTRFT2RZblp2MDBQczlmb2ovZzZSeUcw?=
 =?utf-8?B?ZEhoYlNySWlmY1RxekZDN1NrR3pHY1M0aWVRMWxDSE0wanJqWXVUcmJWMGVH?=
 =?utf-8?B?KzFWR3AyaWhYeUpETjlXR1BpdkxWQzE0NDI5ZU55QXh2OXB6WFZjZlFwNkhV?=
 =?utf-8?B?eGtMNWZxZTBPMGFockhoZ3NtS1lzbTlPQjJxenNRRGs5QWl3NUxLY2ZrVUxt?=
 =?utf-8?B?dU5EWlZicUZhaVlNK0tnZEhBVlErZWRmZ1dhZmV0QWpFc1ltOWxZdTVVMjRz?=
 =?utf-8?B?eVU0QT09?=
X-Microsoft-Antispam-Message-Info: gkUCU68MYYdxEq3UnA5k507Ic4QkzcKbMQQS9iZ9FGwxBQDHbx5S4TofG0loCqSa4FEJE0UySLq0obJZWJxVUkyRRfoj9rPqNdqdLCP3Z9HtEX2cZufRSHUL+WyAtxqwFsQ8qJMvkssnyl+uUsSml9oA6/rY8258fxDjFjtiG+1sNTU2TezlarozZoXuBez4
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1756;6:BlPRvpvbbxUpcXAr1GsWFSZMngNKDzXmxjt1L/hwaN4g6fMV9r+Av2Xuzi3rQYqTUt6CtApeZxY1OWSTxKObK5Asj4j2MosbQOb0ZnRFBwhRwrKZ9BLG2yLWerwj2v4Im+L7Rh12bQMC0Q7mcEeHQfbcGC4AbiJ/+ZlBQZRD73dQRt9Gfo4uN6z5yi9ajUEQ0kfJQweutapj0tWmu40hdxjK1xomyj8H89oRvlM+jCdY7ujkmh7O0cV8C8oA8ui0m1g5g+44cLRoaCmPzZAdxQe+fzuig3wmBXTy41T2xASYgxGghQW89d2N5hyVUmOnb7s2+f9uUuNrPze8OxFmfzY40vrQ5YCv9ekZy4NrGzyox3KqJaAzJR7Yaa9tEfnkqYxDf/2np+nt618VvVl//lFtbQiDPMzLsKbMKtxoz8v2SBzgBigNIcKp/re7F+PuJEp4uVybM2wJonYVnmCnHQ==;5:vCwu9AHvEOYk+lL4jNaFBxqbAqvMbf6JYuNm8fQcJbhFUmf7B1kYGQF+ExvYgnQmUO4hyH5yFFFuNznDP8BKuBDFwxQfWGSMSmS3L3dQWSLrZdUquT7y/Q269x7z/mELxCDtb86Yyqdt4Jrje0TVH9DluGfVFs4K4rzMImPwlaM=;24:Pb5lEnNnQ/qRLH6uTeajYptPlba1c1D6R/g1SYE07/h46BP1+Gd7PluDxz/Zx9RxNIcMQGugagN77Ksh5oNhBFQ932KRRfLgagve6VrNrfg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1756;7:CTVxrZxNlhnqT45vsv6QCGNiVj3Sl+BmhXi6glqv6jZvFmTTFTNfeuV+a80py6aCOHxtvAM9jPvAKma3A50vE6GIgfXPHkCmUP2RzjtrLqhA5qhFq0sRP1ySeS+lVbyrCzVMpCuhTZm29b/6+68It1NylULXt8I98XqZ7tvgBLTGYwWEgGzQoe+1340LcKsoPjezNm66iA/TYnMOv+zQ1Rx+wziwztU+Zp8x1NS+aKQ0wBLE12XDjzDI137+lJmA
X-MS-Office365-Filtering-Correlation-Id: f0b0892a-942d-414e-6bb6-08d5a922b3d0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:01:23.8712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b0892a-942d-414e-6bb6-08d5a922b3d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1756
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NE1bME012929

On 21/04/2018 00:41, Stephen Boyd wrote:
> Quoting Rob Herring (2018-04-20 11:15:04)
>> On Fri, Apr 20, 2018 at 11:47 AM, Stephen Boyd <sboyd@kernel.org> wrote:
>>> Quoting Rob Herring (2018-04-18 15:29:05)
>>>> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
>>>> new file mode 100644
>>>> index 000000000000..fe0a3bd1668e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/example-schema.yaml
[...]
>>>> +  interrupts:
>>>> +    # Either 1 or 2 interrupts can be present
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +    items:
>>>> +      - description: tx or combined interrupt
>>>> +      - description: rx interrupt
>>>> +
>>>> +    description: |
>>>
>>> The '|' is needed to make yaml happy?
>>
>> Yes, this is simply how you do literal text blocks in yaml.
>>
>> We don't really need for this one really, but for the top-level
>> 'description' we do. The long term intent is 'description' would be
>> written in sphinx/rst and can be extracted into the DT spec (for
>> common bindings). Grant has experimented with that some.
>
> Ok. That sounds cool. Then we could embed links to datasheets and SVGs
> too.

I'd like it if we can define the description text blocks to be
reStructeredText markup. That makes it even easier to integrate with the
specification documentation.

[...]
>>>> +  # Property names starting with '#' must be quoted
>>>> +  '#interrupt-cells':
>>>> +    # A simple case where the value must always be '2'.
>>>> +    # The core schema handles that this must be a single integer.
>>>> +    const: 2
>>>> +
>>>> +  interrupt-controller: {}
>>>
>>> Does '{}' mean nothing to see here?
>>
>> Yes. It's just an empty schema that's always valid.

IIRC, in the current jsonschema draft-6 spec, the following also has the
same behaviour, which I like slightly better:
     interrupt-controller: true

g.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
