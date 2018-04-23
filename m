Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeDWOsL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:48:11 -0400
Received: from mail-ve1eur01on0051.outbound.protection.outlook.com ([104.47.1.51]:22112
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755198AbeDWOsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:48:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com;
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
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
From: Grant Likely <grant.likely@arm.com>
Message-ID: <d2ed3578-ca09-15a6-e688-ffb9a097c2aa@arm.com>
Date: Mon, 23 Apr 2018 15:47:51 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Originating-IP: [217.43.212.223]
X-ClientProxiedBy: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To VI1PR0801MB1759.eurprd08.prod.outlook.com
 (2603:10a6:800:5b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1759;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;3:pv/BOP4OZYZAymRn95y9o7JIYEN9KhFnYdvMmQRTCYwQh8anAgyRLw70vYHL0DP2m/0UEk07XzYo3mwtXUYx7aIwc1Vb0C61A+bgIxN8+w4/+2WSOJ7uk91o+0ltJuO14WyWydXH+D8zUyUZhazoXC7MizB35h3zFRpmCQOT3j98yodS+bir+53yFbPZkQkTRIiXDoCqE64M91513DH3ldrinNvegO0LqyZ5v7ZD/cOzRk4RmGsY6fx/R0tjxHco;25:ACCVDU74KpF149HBk/wmghX46YFyo/0vd8t2b+5CzDNpmWykud23zjZLG7IC6E8BiUDWDGA3tDac11h7WDUjxDXj//JrBOwJxSBISUo+Fs2o8Gns9tp+4yaDahxWXQ9a4DEsCeZOtUc/tanhT7jE8BtLnr08VTLlpsVJes0Fq+cb0T6ElZqtvQeAAdzLOB+F8LocM+FhBppOUhxpH4brq3OxtboHRVD5k4mGggCBKQ3DvbgC2ipIx9fnYmzpydTDEM88XC3a7y3rVAh/aF20H9Sow7yPTSYzo+1Ma7/rg/yOWDoi5LGi75kgEgwYJa/YBwvBoIjsH1ZX63Ig2h3pcw==;31:oeoS/RlBX3BHjcBH7UsQgT+ZlLhhQiJJQ9/qAOI6ud11bUYJQvNYZSoHzMTc3LcbsRFC0mQLscJ6UcugCIFcNx7wK3vhD2MIrjiZr1KeMnPu52Sl4h6zClw2X1iktRFulYZVrEZt5KmY1mpvY1r7sAB39RBes4PBh4mRRHH9LQba+DwFtKl/xU8yuHzUN2fkUdmC7ASgmEGWduXPtjU6bZoGFFdfxvgT12toOi275Hc=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1759:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;20:9q+pzWC3TqtGTjfKeefcMawhNSrWEmFlvsWggExKJdreAXnVg+r9e4gDguIpxwQwQCqAPB7KyapsouY8vhnf1823o7Gikn4CPEx2GB9O97UPBFquWHiB251z6Ifl8Xdbu8d3rZuH9tljMegSL0YYPWpdjS8/F3c6cyuHwEmnI7kD4SNeRqmEqE6WnJz5IiyHz0Uvznk7iJiBAEATZ8GHcRd1XyH1JxccArCJ1ZJZJCLlWXj3zCa5Tf2yh69GpeU7jN7XF8WJX+BGKhMyxt1Nx0AOtUJHDg9Ad17w7852/OUy21+BzbTRbYydFAZeyA95IjD9Np9E8lZcCE67Uub7k5U4rQbs/4sWuH2CCbjRcVntolNkci1CgvAWRKXjj25oMMeCeth1VJ0H2kSGLkqJM4yYsf5HmJevG7S1Hzkqy+PkfR5COJDOJBqeu///E5SPyAu/R1UFqc3NBxmt163MFqa0+RklZPe36e7ltQrsOGhjmkVfmhH4nziYDxUvoC4Q;4:wUvnfvvhdxA042fopKvyZ+x135vtCy13DjnEu0VxXnLe+1gio2oWN3Gpwwso/ECu7VNqV8Z+XSmOQleCG7BHpAleU+o5D/R6dMkBlK9vGCNFx6BWNgPFH6iwOmDZPDflD9MMmWHXeJdt+EZglkIZf7KQUWi7J8Y7b5SkIqapV84Z6wooCoUdTojxVGoEVfwDshpwDL+9w344/zHI+oSEm61EBrAPTKr6Sk1sPCyIRkC3SZwvHT/U5m7MDvtkaqqdwxn7D3qTMqCUjOk1l8uc5MISno9K4hEqvvQEEnXQ3eVRRA4gaIoRcGK9c2DbBLVYbdF+uy2dnj+wuZkjBtYmdIM5dFB1inpUsStCD8zr0JpXJc2tZD5WDJpZFdqzXFzZ
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1759F3B37C67A926A2DFB33795890@VI1PR0801MB1759.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(35073007944872)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1759;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1759;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(39380400002)(346002)(40434004)(51914003)(2486003)(386003)(52116002)(31696002)(6116002)(6506007)(316002)(25786009)(186003)(39060400002)(6246003)(53376002)(50466002)(81166006)(47776003)(58726001)(36756003)(476003)(26005)(229853002)(6486002)(3846002)(76176011)(6666003)(110136005)(67846002)(64126003)(54906003)(7736002)(23676004)(65806001)(86362001)(65956001)(53546011)(6512007)(8936002)(59450400001)(16526019)(52146003)(65826007)(478600001)(5890100001)(44832011)(58126008)(53936002)(6306002)(66066001)(305945005)(575784001)(956004)(8676002)(446003)(11346002)(7416002)(2906002)(5660300001)(72206003)(8746002)(31686004)(4326008)(53416004)(2616005)(966005)(58736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1759;H:C02T10KAHF1T.secretlab.ca;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjE3NTk7MjM6Q0ZZaVh0dGVrMXY2eUp3YmpkM1orMHJM?=
 =?utf-8?B?R2lIdFQ2Q2ZBdDNpa3BWZ1JxclEzZWV5RTg1NG9nZ3REcnl4VjVHOGtGNGY4?=
 =?utf-8?B?bHdrbVVjS3VsZDR6N1F6WTlGZTIwRFJEME5VTThBYnlnUjNCTXhNRExndlRO?=
 =?utf-8?B?ZGp1RG1jRUFxUm0xV0pvcnRvTHM2NGhzTTZkb2lJa3BSdS85S2R2ODEzN3lq?=
 =?utf-8?B?KzlSKytubXNsdVAzdGFhcjg5VWJZenN4MzNIUVZ4QlRMRU0xVlRJMTRWVEZL?=
 =?utf-8?B?SjdhSWw3d0NWYWNRMlBWMitMRmYyeGdVOEN2blRkK1NIUWNmckdVSkl5L25U?=
 =?utf-8?B?Q2ZMak00WGp6Rk1mUEJQZCtOWkplRWNSN2NySlIzbC84ME9uYlBxdzFHUThZ?=
 =?utf-8?B?dzAyS2ZpQXlQbzl5SEFrdDF0c0NJZ2o2RXZGdkRIZEZYWnNRQ215UzJVK1RX?=
 =?utf-8?B?OE9Uc2JWVFU3STdNU0E0Zkt5YS9ZUFdwaHFobE83aEUvU3ZuMjI3WlJkKy9Y?=
 =?utf-8?B?cjN0NC9BZXFSZGFQYkdCWGpna0pER2pLb3l5NlN1SHFvbXp5VEVidEpKUHYz?=
 =?utf-8?B?YmdiZlZKdW4rUlg4N0NzNmdaWWxlenVpTGQ5L3JCTFpuMERva0FmQThydjhi?=
 =?utf-8?B?a25BTVVVcE50UitUL3ZWVUlxYjZRSExjS29UVHdpcnpmRCs3VWI4T3Q2Z2pv?=
 =?utf-8?B?UkhXLzY1Q1pnUzBpQ0xBZHZlREJoZW9YN0ZmTVhOK1lKbG02Z1NHOGU1OTdJ?=
 =?utf-8?B?VnVDQ1RQV2lyMGQ3c3l0WjhhNXFwWmZaNjIzSFM5TVNKdUY4clJ5SkVsSE1I?=
 =?utf-8?B?YUZHMkxqOEsvWU45N2dZMmJIOHlIMEQ4MnhZSEF1eUNFKzkwWXZEU1RReUJU?=
 =?utf-8?B?aVE3SVB2d0pRcjVJbWlDTkV4N2NxSHcwZjlvUlBzSGF1UFlkM1EySUxWOExs?=
 =?utf-8?B?anBybFE2ZWx2MUtpQmczbElwSmp5cld6MmF5dE16S1J2djA4ZUs4Q2JEeUxu?=
 =?utf-8?B?cXRVSXlDaFRpeWZpZkV2ck93OTN1Q1hEU0hMZVBMdXZlZ3RVa25iVUdTQkNv?=
 =?utf-8?B?R1ZqQjZOVVJNTWlnNnhXWCtnR2llck5OdXBQMm9aMjE3UVczSmlNZGhBU3V0?=
 =?utf-8?B?Q25kbkZrNjRsN2FhSGxsYzRkMnpCY0FPVzdOZlI0Um9kRHZHTTMvT24yVngy?=
 =?utf-8?B?WjRRQ1VYK0x0N1NyVXJuWFo1RmcxNVEwQWRXUFZLUmZQT0VCck9JTUtRc1gy?=
 =?utf-8?B?Z0FNc2RzTTdXUHhsZjcrY1dzOHdTOTNaVjc3WnpOeStOOXpEcDJqdWNwdzNt?=
 =?utf-8?B?K2gxTm4rMzhmVVNOdFFlMGgwS0hycFBnazl2TnJjNUtUbHBMZXdVcjB4NTkw?=
 =?utf-8?B?WWswNWlTd0JlSW8wNk1icHJFMUVSd0R4dFo1bGF3QjNTVTgyYUJCb0VNS1Vh?=
 =?utf-8?B?YWFOMHp2WnpseXVhWTA2RHRHWGdwR1NIUmpuaTcwOVUvbmJucTE3aGxtendr?=
 =?utf-8?B?Vk9zWTdTMDV2emgzOUJCTUZCa0lUM1g3bzlNRGpQWTlsdmZ0VjB3a2ErSjQx?=
 =?utf-8?B?YVpwRVViSFZBcDBKei9jZFBiVCtSQk1VUkhUUGZRUGoycHJUYk1OalM4K1pO?=
 =?utf-8?B?YWFGWkc1Q2pESmdrM1ZBRnZKVHB5UFJ4SDRGK2FvTEhqRGw1NVY0dGRmOUxo?=
 =?utf-8?B?YnRrWk5oSktQLzlhdEE1WDgzL01ZK2NuZXEyZkVLY0hIZGZpcGRtRUZmd3dL?=
 =?utf-8?B?UkZ4RjBFN1FTNisrRGhsT0pZR0FCOUg4Y2gvNkNYUWx1ZkNEQk95dmw3K3FN?=
 =?utf-8?B?STZjVVh2VHFwN2JqZDNFQ2llWmF2bm8xbmhRSFZkcktZdmg0UEliS3FtWDdJ?=
 =?utf-8?B?anVQRW05VkltZGg2dmJkcjRTaTJrVlhBNFNwNXNNQWtCVVVoS1ZFS0dmNEU5?=
 =?utf-8?B?MUpYTFl3ZWx2RDA2N21TdWpYQ3kvMkVoZFhYNXBSc1ZmMWh4VWVzRTBXOTRu?=
 =?utf-8?B?ZGRHUVhPb2wvOW9GL2d1R3lqdTZFT2QvTFlGUGNTN1hrNjdyRTQvV2wrSmsx?=
 =?utf-8?B?N1Rub1l2SHNrVXRQRnlZcE5BMUtBclF1NXNHN1VldmJENUJRUnk5OE5UeWNC?=
 =?utf-8?B?VG5hbXFYck5pVENjdCtBdmQxaVBBWWI4bC9FbkVSZm9xRW9KTTVuamV2dGN4?=
 =?utf-8?B?T0NiR29ERDRDd2J6d1ZqTHhzMlh6TFE9PQ==?=
X-Microsoft-Antispam-Message-Info: PeFfRNiTaqDq49IxUp04TZZPNjANs6uYj+F54ER9/3JTSyZRjzYS1bqT6Fn9nYEBScf8gQ2Gp/jBIWUGo+q6gSVL2TBvIIieJ6vaMhR38mJWrOJOgql6qOOXYFt8J5+h0Z/haIY9DI7oucp8fBSpOV33JwVSK+agK3b3LNvuaNXSwoXmin79Psde54jeAYdV
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;6:GP0Ln6uuFujuhQFNgYTvxkyv5ZrJTo/mkvy34ALCVBhvMTZmuESBVMNQK8lWci3Ei27dvaMLaTthSIwIa+2s2fIZ2lrkeG7R1ID5IBHBLVWzlnn3xpxPIIkbPE9kA3cklSmSk56pZLD5fpToU7zOqq64JNUWh+ttyZ2ciTQgnbVuPbyYqYm/zUvuCSdNeTh09BaAnNmr4Oa5kQZAP/IWRDV35zqzxjPFjB2qIXWDHnyIft35lIV7ieDmqwfDqxzd76CVXhUxlIfscBLHBbbYrNci4UV/nl4UV4KObOdmYs+G6dLJVvSnJMkDuyp2lYJVvXU/Q2jaf3X2WKAd0j0l33FkQOTcnqQlwCWLgP/rk8UOxH8lq/LRtvJx/4Imn0/Rh/UfYZnEgDgDXAZ+yPyaejnxYw3UuYWxfzOsq7uYsVlK8nfBWB3VQQr1105U8yr33MA9YeSAhuZXIi1D+7Xwrg==;5:YA6SOhKir73Rde3qAXI0xegtNWmL5zBG/TvSMJvCLbhA6uDijMLbGDWX53AyDRwEKd+WjUBDqszSi9GeFGz+dqCWakndORIYHjOOWCkpxBGDlhawwYeOHvHHXT/OFO7L57ng2MxmHMeKgMrryd4ny0qp5tt2NM8rz0eYshRdcsY=;24:G0ExxjDi6hRnaLfwldLltnuB0CfUVqw2KUhnhesmkgp6E3MrGR8XMEs6sMVLY7u2eWhr7jBPKnT7qFcmawMJauY1iqrqc2EboiETbGnveQ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;7:nvmsjP73MKEc8cm1cPQ9yGuT7HJ3avqB/kI4Bawra79a3XxI6477ZvaPBRn5NJlm9rvWpOqi92aAoMgk5cDB9czDBtTHy7Y4bhxfxn02PZpZ1DZAhefvUA1n8Zj2iJoYzEGFZ/vFvaaKd2GdEqXV1A9d5MBmI2kn8XM+acqWZtj5Hq5kPGDbxMDVTKNiTcyeEnSoIlMEccmnBCC3UT/G9eY44f3E+gcuqSjjXt0l9dM1gO27p3Hz4oc9PU8rOoYS
X-MS-Office365-Filtering-Correlation-Id: aa968362-6b87-4459-8a37-08d5a92933fb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:47:55.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa968362-6b87-4459-8a37-08d5a92933fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1759
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NEmEin016645

On 21/04/2018 02:28, Rob Herring wrote:
> On Fri, Apr 20, 2018 at 4:00 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Hi Rob,
>>
>> Thanks for the example.  It was a good starting tutorial of sorts for me
>> to understand the format a bit.
>>
>>
>> On 04/18/18 15:29, Rob Herring wrote:
>>> The current DT binding documentation format of freeform text is painful
>>> to write, review, validate and maintain.
>>>
>>> This is just an example of what a binding in the schema format looks
>>> like. It's using jsonschema vocabulary in a YAML encoded document. Using
>>> jsonschema gives us access to existing tooling. A YAML encoding gives us
>>> something easy to edit.
>>>
>>> This example is just the tip of the iceberg, but it the part most
>>> developers writing bindings will interact with. Backing all this up
>>> are meta-schema (to validate the binding schemas), some DT core schema,
>>> YAML encoded DT output with dtc, and a small number of python scripts to
>>> run validation. The gory details including how to run end-to-end
>>> validation can be found here:
>>>
>>> https://www.spinics.net/lists/devicetree-spec/msg00649.html
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> Cc list,
>>> You all review and/or write lots of binding documents. I'd like some feedback
>>> on the format.
>>>
>>> Thanks,
>>> Rob
>>>
>>>   .../devicetree/bindings/example-schema.yaml        | 149 +++++++++++++++++++++
>>>   1 file changed, 149 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
>>> new file mode 100644
>>> index 000000000000..fe0a3bd1668e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/example-schema.yaml
>>
>> I'm guessing by the path name that this is in the Linux kernel source tree.
>
> Yes, well, my kernel tree. Most of the work still lives here:
>
> https://github.com/robherring/yaml-bindings/
>
>>> @@ -0,0 +1,149 @@
>>> +# SPDX-License-Identifier: BSD-2-Clause
>>
>> If in the Linux kernel source tree, then allow gpl-v2 as a possible license.
>
> Why? BSD is compatible. The license of the above repo is all BSD.
>
> Of course there's all the existing docs which default to GPLv2 and
> we'll probably have to maintain that.
>
>>> +# Copyright 2018 Linaro Ltd.
>>> +%YAML 1.2
>>> +---
>>> +# All the top-level keys are standard json-schema keywords except for
>>> +# 'maintainers' and 'select'
>>> +
>>> +# $id is a unique idenifier based on the filename
>>
>>                       ^^^^^^^^^  identifier
>>
>>> +$id: "http://devicetree.org/schemas/example-schema.yaml#"
>>
>> Does this imply that all schemas will be at devicetree.org instead
>> of in the Linux kernel source tree?  This would be counter to my
>> earlier guess about where this patch is applied.
>
> They could be, but not necessarily. This is just convention in
> jsonschema is the best I understand it.
>
> I don't think you'd want validation to require an internet connection.
> For the base meta-schema, for example, it does exist at
> http://json-schema.org/draft-06/schema, but that's also distributed
> with implementations of jsonschema validators.
>
> A large part (not that any part is large) of the tools Grant and I
> have written is doing the cross reference resolution of files which
> uses the $id field.
>
>
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>
>> How is $schema used?
>
> Tells the validator what meta-schema this schema follows. Typically
> you see draft04 or draft06 here if you haven't written a meta-schema.

On this topic, we should probably do the same thing for the dt
metaschemas. I didn't worry about it initially because there was a lot
of working out what it should look like, but we should include a
revision number in the DT metaschema $id URLs.

>> Is it accessed across the network?
>
> Could be, but generally no.

The $schema and $id values are used as unique identifiers. The parser is
setup to look locally for both devicetree.org and json-schema.org URLs,
so network access is not used. The parser /can/ fetch a URL over the
network, but that isn't a feature we want to use.

Using the http://devicetree.org/ prefix makes sense for the metaschema,
and for all the schema files because I think the desire is to have a
common database for all users. For practical reasons it makes sense to
start with putting them in the Linux kernel tree, but only because
that's where all the binding documents currently are. However, we also
have the DT rebasing tree that is tracking mainline and has a good
structure. We can start encouraging non-Linux users to base off the
-rebasing tree, and work on transition plans to allow patches against
-rebasing, and to eventually make it the master tree instead of the kernel.

It is also possible to have other prefixes for schemas that don't belong
in the common repo (but I cannot think of many good reasons for doing that).


>>
>> (This example file provides a good example of a single syntax style, but does
>> not preclude other equivalent syntax.)
>
> There's also a question of formatting. For example, we can have:
>
> enum: [1,2,3]
>
> or
>
> enum:
>    - 1
>    - 2
>    - 3
>
> IMO, we should lock that down too.

I don't think this level of variance needs to be locked down. That is a
very basic example of standard YAML encoding of lists. There are times
when one will look better than the other, and it isn't a lot different
from the kinds of things we do in C. For example:

    int a;
    int b;

vs.

    int a, b;

On Jsonschema vocabulary? Yes, start with it restricted because there
may be unintended consequences. But for YAML syntax, I would rely on the
metaschema to make sure the structure of the data is correct, but not
get worried about the encoding.

[...]
>>> +  interrupts:
>>> +    # Either 1 or 2 interrupts can be present
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +    items:
>>> +      - description: tx or combined interrupt
>>> +      - description: rx interrupt
>>> +
>>> +    description: |
>>> +      A variable number of interrupts warrants a description of what conditions
>>> +      affect the number of interrupts. Otherwise, descriptions on standard
>>> +      properties are not necessary.
>>> +
>>> +  interrupt-names:
>>> +    # minItems must be specified here because the default would be 2
>>> +    minItems: 1
>>
>> Why the difference between the interrupts property and the interrupt-names
>> property (specifying maxItems for interrupt, but not interrupt-names)?
>
> I should probably have maxItems here too.
>
>> Others have already commented on a desire to have a way to specify that
>> number of interrupts should match number of interrupt-names.
>
> Yeah, but I don't see a way to do that. You could stick the array size
> constraints in a common definition and have a $ref to that definition
> from both, but that doesn't really save you too much.

There has been discussions in the jsonschema community regarding
referencing data in the document when applying the schema.

https://github.com/json-schema-org/json-schema-spec/issues/549

However, those discussions are ongoing and have been pushed back to
after draft-8 (the current release is draft-7). We can instead define
DT-specific keywords and extend the validator to make it do what we
want. We need to do something very similar to validate that the length
of tuples in 'reg', 'interrupts', and '*gpios' match the '#*-cells' values.

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
