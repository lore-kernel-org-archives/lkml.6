Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/BM0bg5yuO1obXZ3WH3MsFYynNdsmR7FC2A1vRiXBvN5dCIGupjl7qddsnKk7gGsv/Dsyi
ARC-Seal: i=1; a=rsa-sha256; t=1522157541; cv=none;
        d=google.com; s=arc-20160816;
        b=aoXrvRHaZi7iMQC7coCFjoHzyDAzNerSsOZijBYCQWM9uh3xAE1JJKbkxtKpND8jYA
         Mz67gmXb5Wx5plzrJDDhND9x+ql4Ecwg8JzGWlmIcGcyaETN5uqV3IyujLBQqy7hueYc
         crEBi+2BgmDs5rgApD+WFFXxglyb3QL1DB1Pr+bsSHE8ROnUxq9AAugqRX50/B9fUhbx
         5v9LpSLfkpebgGkGbvCXIzOP0CNq0kQU5EmD91A/gcnFFhTnIx4WZuhevlxesY61kZSF
         350GLazdK0ZaOB8w3STgRq6EDXmd8P+uYS9JiRPcLRpd8A1jZYlvxt1QSbotNHidOPfb
         jPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=ezU24S+IT3ifZlAEg+Zdu9xqvR3mMN8DVlEB8NqKtaY=;
        b=V6lvt6DQtdK5eK3wINit1OuTmHIJCWaK+Ke8Wgz/4Ae789fKMPFOHBhXMv3B5ht56j
         Ei3j/t2+A9kNqJ4K1eBMKv1MpIa3T1jP4emWiIVyWSCFlNGbjdIU6xU0F8BptnZZFwsN
         m6r6jebm4RLf2Cn6zBgeDDW45y6vLm/6nLacjBBniCLgboHaWNrVb+7PWhJ0O6V1Cf91
         c2YUXTXPTWmWyXlo/abdyVt/6a7qATPc9toy7IouOi6EKCeP7w0o3smbiZjUCDAE3VQ5
         Y0Pld3J825cxeLpC2SonMk3ltpC/ftlR2LAG114756hZEiHmEqeo5BBdkOV5dzMEWI7D
         6qug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=i0psi2Hb;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.5.132 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=i0psi2Hb;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.5.132 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 3/3] iio: wrapper: unit-converter: new driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-4-peda@axentia.se> <20180324140339.4ec66792@archlinux>
 <1e950fde-d3d9-ca9c-1055-7ab8fc57fc4a@axentia.se>
 <20180327142256.00003056@huawei.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0c9e6fbe-cc05-1a2e-0437-dcde134e6eba@axentia.se>
Date: Tue, 27 Mar 2018 15:32:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327142256.00003056@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0344.eurprd05.prod.outlook.com
 (2603:10a6:7:92::39) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0001a7ed-4687-43df-9f6a-08d593e728b6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:QjH56zHx045Z76/mIIph7tL2qPOs12FRPIo8DgEnxURCduvCl4KaIiKc0XP/4KVmUkPIMN7U99UbtNMyoBHD+srzAGfALpdflUnfVAuxvejr4qtMVXxD5+5S9u2ziaqW/mGkFo7RYKqFnTDL5tBaY0ei84I72whMwcGjc/nE7LwCEpRlBKEExQIp9s3oqTK210JVaXYmtb0hJbQLtLux/sIcqpB3cWQT9OXhT52+G5Qz2HDhAYGN8OlpYru4QyEb;25:LajyNXnD+f/wPlFpIDwsOBY3NT9jbO5Kn5eHAX/vhfOcm8yVVGK4CQtCv3UXbts/fmQ6aSuQa7GzemUgWoEAE+cT+lhNswh2H6L7omX/vVF5QGKZPU1foWlNBnr5sromYFLPFatSNCmu5VWNypcj86DRQnHwyMWEGIUlDtaVdV0yxCkE1QJg07tDXhJxgHoFjWsVdEqw3G8hmu6KOVpCtdL06bulNfNjwYeF08AJlqbGQZHCjQ1Bbw/bYtpVq/gVVewxLSaCCO6v+m/MGnZkb1F6Uq5hFZTzm3TlesKVmXgizmEyNY/M11r3jQ36lZjr5WlGQxfy6s8AqAZEkzw0Uw==;31:nMtGaVoUNUauA2Gw6BwUreG8klJC+tEw43wkR7IJE5KpP3+ZrjD5BtErDZ8z9gxHiS9FiKgPx3VGj9whQ2VW4RnLWO8IovmJDKWdVKCYElDhRWHBXNCgvhjWjDfcJBnZBAwBkh2cCt++B3+FZ5DaK60yng/YfC653ahd+zOokPMSaxWLX9/QmiJjpYWg+Fh1mEuqpWsyIFcYPnlzxLVEdog/ra2DHcLz1QGUDKumxdo=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779848853EA6384FCF008D0BCAC0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:if/KfUxfVi7+gwq2xsB+p9PGFcmoptfI9JTNYkvTTzjelQrZujsl36aPjvKPUXYdFQiummXQXr9s9hxu4F7+w+Y7vSj9MssxAtRactDaEI1XJ2T8zlhzXfsMtXZCJkjB4/oemFm3dpep1q0h0dpJLr7c2fXtYvsqPhY+jf9hV8+uPhm8EmO7kM0GRo5pt8jKXSmfm1kkz1TsAPPuWl/8BnHaYDtVLrPqUFcMYrdct8qCvueUCxdGqcpi2KfyJPKJ9eKgGxkekrZ7vUEi9dp+Gw==
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(377424004)(52116002)(64126003)(117156002)(65806001)(86362001)(74482002)(2906002)(4326008)(97736004)(3260700006)(25786009)(93886005)(36916002)(23676004)(76176011)(2486003)(6116002)(52146003)(3846002)(50466002)(65956001)(476003)(11346002)(7416002)(31696002)(486005)(66066001)(486005)(47776003)(31686004)(230700001)(186003)(16526019)(81166006)(386003)(8936002)(8676002)(81156014)(8666007)(58126008)(36756003)(53936002)(6916009)(54906003)(53546011)(16576012)(5660300001)(77096007)(65826007)(446003)(26005)(68736007)(105586002)(6246003)(956004)(6666003)(316002)(478600001)(229853002)(106356001)(7736002)(6486002)(2616005)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzk7MjM6d3oxV0ZWN0hQWXJBM2hSLy94NThHOXlY?=
 =?utf-8?B?Ylh1RUhjOWVIQnJiWDJGaFhBQTlHOFJsVnppdmpMSUVLTWt4MEp2YjFCYmor?=
 =?utf-8?B?azNXLzlveGZ5RjUwdUlLQm5qUE9ublpjZk5SRlRIbi9WTWJoNVBocStVbm1v?=
 =?utf-8?B?NWJwM0J1MTVLUnQxT2xDSWlXS1hKaDVXSHNZN3hLZVUxdUVBTFIyNFBuK0cw?=
 =?utf-8?B?OFlvdTI0eE5xVDFZV3JkUDNZb0xLcXF6RXZOQWtqOFBKZ1lGb0UrdU9PMDZL?=
 =?utf-8?B?TkI2VUZkSFdaM0pTSXQwR3YxS1kxeU5IcEtoUHhNWHlKV0xoN1pVNzVwMllC?=
 =?utf-8?B?WTR2My9ZTmxUeSs3Ni8xQkZPYmJ4YU56TVVma0FYb3dIbkdOcW1RY3hoRnZo?=
 =?utf-8?B?SkQvanpEYnhNUHhvTmhZYkMrNk1rVzFVYkVRTWo5dGxUZkw3b0hjbnY0ZzZ0?=
 =?utf-8?B?WGJQQW5oa012OUlzWnpXZ3RxNE9hYkFkM09xV2gwTVIydGl2LzUxVkVLTDg1?=
 =?utf-8?B?bjgvSm1VdHlxRU0ybFhCN1JaVWQ3NEpJbVRFMVI0VitqWHBWVHpNMkkxUE1K?=
 =?utf-8?B?R090YkhIbmtUWmdEM2RXMEQ4RVlsYVh3S3VKajNlZy96Z3RZT1ExMFp3SExB?=
 =?utf-8?B?NEtqeEZiQjdZVWF2b1d6UmN5dXU4MnJvMW9Xck9KT0lUVisrUlNTVk5KTndj?=
 =?utf-8?B?MHJIbFJ3UFRlSVFqb2pYQU9UN3pTa3YwZWkwTlJzNldnVjdXREMvQnRyeHd0?=
 =?utf-8?B?dGdSUE5ybWJiL0M1Qkc3NFlTM0Y1M2hlSldoamtuV0txVG9ldnBTa3d0bHlD?=
 =?utf-8?B?ZzgwcGljNFJuczhmVU5BcnFVLzlPQkxBeWg4Tmw2SFU0MHB0MThTdEM1aEJs?=
 =?utf-8?B?Z3h4emIzSEovN3hTd3BheTl0M1FTQWtPVTl6VWdrYXBwblVqSitsbmhVMnF2?=
 =?utf-8?B?MVc2Ty9ESGwvTHhWRmF0MkE2Wmh1a01wLzNiLzdsNThRY0VHRjZFNHhXQWFw?=
 =?utf-8?B?V2hPUklkZW9WeFZ1TzIvdTByUitGbGJHajJHNjM4a0U5QXZKSGtMZE5rODhj?=
 =?utf-8?B?THJ4US9LbDYrUmN5N2lOZ05nWUkxTDVrdFY4UzM3c21kenpWQ1JDN0RDc056?=
 =?utf-8?B?c0NGcVVFaEI4WFVxbmF3NzJmTHpiQmVkMTU2WVcyRzdpNWpXR2dkOGdOMCtK?=
 =?utf-8?B?Q2dFWmJITnRBNG5vYy9LSUZVRFBjb0tvbE55TWJuWFl6QVQ2eXNDcGZ0WmUy?=
 =?utf-8?B?bkdIYXptNzRUc0VLYUJtcEViTy9nYnY5VlViL09GZEUvRlV4ci85cDNDWWFm?=
 =?utf-8?B?eTg2QXZwNnZTL2toZm1MNE9FdEl6UjYzOTEvclJFVHJwTE5wREYzU3VXMGpW?=
 =?utf-8?B?b0Y0QjJRTzZMWnRrWVIxbHh5VXhSNlR1MlZTdnp1d1hMWFJoMGcwenZCNDFu?=
 =?utf-8?B?VUh4WCt3S3FQeXhOWVF2akowMEhiSFc1M0xXcTNpUENLaXFBQVkzcmdtR28v?=
 =?utf-8?B?aFNBUjRXWTNvcFUzdWVxMDZzQ1gxU3BrRGRjU3c5WmNIanBDcDEyckc5Z0Rr?=
 =?utf-8?B?dHVHK1BqazlBMkF4TEVwNWhiU2pNUWpleVpwd1B3bkdnaDZtRWJLc3V2eTBF?=
 =?utf-8?B?Qm5hZEFxdXNwalhEeFRXeldINlhGK3Q0WGppQ0FybVBUczc1clowSTVua3RQ?=
 =?utf-8?B?anlLZ1pQL0tLdnFkM2J0b2o2NytKQXd4S2JxV1BZRzVzWHJXWUI1dTdaRkpv?=
 =?utf-8?B?eGNMZEFOc3dUNmMraTYrdFE1dTNFc2VERmVDR0t3SHBrcS9hM0hkRFM5MmJG?=
 =?utf-8?B?VVdrazF4UEh2VE4zY09BbUIzZ1RUSHlIWngzY3RoWDVQeTAwcTBtTEdUeEVu?=
 =?utf-8?B?Q3lhSmZtemJwUkpSK09oNjdSc0JTcmplNXhEWFJpVkhpdi9PcUVCQTdJMXBt?=
 =?utf-8?B?UW5pVkplMzIzNjZ0Zzk4QnhjUkxOcDhPci9TQTlYd3g3MVp3SkJkczlQQzBW?=
 =?utf-8?B?TTZUNEZUaTRGckRqK3RWWmxZTEY3UmYveGZmWjhQWEF3b052NDlwUkk2c2J3?=
 =?utf-8?B?MmphRFAxZytZaW1YUEkvUDhGTFBBWHhzRHcvTjU1cmpURVZNQmE0R0thRzlE?=
 =?utf-8?B?RDJyd0hWSjRWNUR1Mys5VjBNeTc0ZzdLbWNQcjdLNTZwZDRjU3lPRnRtWUo2?=
 =?utf-8?Q?2jZqxSmQX/e67/CeEzUOnLD9MqmLTW5icCIa4MKXiKtA=3D?=
X-Microsoft-Antispam-Message-Info: YeEXdMGumjpP1AsOYOrUk6rKVImwDrklulv/9ymYjKYtxBd+Ptx0j0ldFUV46ZJl0sxfB2yjnXE7TCCjeLwFFY8BHoTF193mOnpN/hvLRNG/4c+474VySl4XMKtV0Ttmy5J8vxGLqDTNB1yTC2L16nl4rARM0qQ8ROddaJRvW0TB1HDK8zn9O7kF2Q1mRG+e
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:BQ1+2s+5QHBEwkpfSD9nHbuJvJMwFpBkHVuEl6g63ZARJwZHJWiZpnLm8kjvEF4cC4Y+WSm/u8PPDGUQ6LZd97+BBJTeDWazrpGKfeZGFYLsOuBo5EtLZGwSK7p6mDc62Q3yQzXuo7LUWUD2riGWjRI9ORBrmnIws6tKVN6iKLxQhk8hCoVcDYiffYMZfc34cjGb8b2oaAuKkB9gWHsIZPqnTbI15RG52y4o/0Vdu8CuP4OMKRgwwJVwyP1UyCJEXAaNLIwB6kkClnKYZZgKOfyDKYenjAy3sEbkrJRoBowtp7zb5cGNsCOSSE++r7JeYqzHho4S+gjVZF6S7a34X38bqUYTRHKppxu2uJ2suifEQVYOexvB8kgsKvbmwSKObRlR7sbZ7xpIP1JBNS3vAPFTlFKn+sBa8UaWKlFUMVCrYBGq1Xd5ax34WvAidzT32WJZAsDo7QK1T+btjhtSYA==;5:DMZ4fYngCzyFea2qn60mUWGLYzYyRvFEFNTNyq7M8KA2QpuUP+yDHSbTVWo7Nm+m01O+QR6/MImAxvzGtTQ3Hr4zg2LcoSyG2jBpCpn52DQhmaI5g91TqJ59Ck9nhJIppTuDKjf7WNrgEc0CcEhbNVtO9lhUiPlGzk/zfsAmaMM=;24:L4lfXd9wkcb45VShP9jhaP+7r/VB+aOQv+azYBPvesRfO2gXISrEXRulHl1zZBABD4yl6D/IsFwPWvNl3krjC7w9gay10bLzTTbxhYFHHVo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:Xz9BF1KJe2z3tyUUTIkAkfM9gyT0+105agF0wP1pwzV3VUaSygqNeaVGhxKx775JA7Od+aBLS/i8GQSbhogL0u8DYW5dVgbacn7tKkjmoflsn0huLUQamplex1EMEk+6fwxeZI260Ws5Nh6GzfCWQ3639wDDE7vINME76BhmWXiSKCbpqy2Tz1aqgWFnM+BIkJTk8dmibdP4RORiEsQ1KcvO7qKRzxkUSPgZ45U6BzQ/+kH7mRpnbDWqiYSfq6e+
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 13:32:16.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0001a7ed-4687-43df-9f6a-08d593e728b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386357743794195?=
X-GMAIL-MSGID: =?utf-8?q?1596097866264066201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-27 15:22, Jonathan Cameron wrote:
> On Tue, 27 Mar 2018 09:42:40 +0200
> Peter Rosin <peda@axentia.se> wrote:
>> On 2018-03-24 15:03, Jonathan Cameron wrote:
>>> On Mon, 19 Mar 2018 18:02:46 +0100
>>> Peter Rosin <peda@axentia.se> wrote:
>>>> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
>>>> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);  
>>> if the parent doesn't support RAW, is there a lot of point in carrying on?  
>>
>> Nope, better to error out I suppose. But I'm not familiar with channels
>> without RAW, what alternatives are there anyway?
> 
> Potentially _PROCESSED though that will need somewhat different handling.
> A nasty trick for that might be to map it to RAW and then have the SCALE
> reflect the divider circuit scale only.

Hmm, I think a lot of things might assume RAW to be a pure integer, and
maybe they are even correct to do so? So yes, that seems nasty indeed...

> It's perfectly possible to have channels with neither _RAW or _PROCESSED
> but I suspect we don't care about them here.
> 
> There might be an application that needs to do buffered data flows in the
> long run, but we can figure out how to do that when one exists.
> 
> It won't be a huge amount more than you have here, though we might need
> a trigger pass through as well to allow you to set the trigger for
> the front end and having it automatically applied to the backend.

Yes, this is the same for the iio-mux. I don't need it, I in fact need
very little bandwidth for these things. Someone with an itch will have
to fill in the buffer/trigger handling...

Cheers,
Peter
