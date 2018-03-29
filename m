Return-Path: <mkelly@xevo.com>
X-Google-Smtp-Source: AIpwx4+HF8lVONyfNPW2VnJ+gB0l7sKIbWS7eRBXAVf2LaTkzQIVOrMJV0t7HA8u4cSfueR/fJG6
ARC-Seal: i=1; a=rsa-sha256; t=1522344536; cv=none;
        d=google.com; s=arc-20160816;
        b=zTKIov//O4cnQ/YunKpmuHxXEBAYKLMQCKHKYvCnoZaLWB7PjrQ+JBm0p9HWjlHGYx
         oPpK8URPOxa+dp6ZAJLSbGhIyxja7P5eziEo3RNVkcLQxCwpsFLPyKiE6hEgnjl4u4l6
         c7JkNsy3y1Ly6jgJEa2qu9va2tu+srpoxthEgSocwBWaPiJ6fIlyBPgzPTv/ufuve1vs
         GJAv5WzvugvUiAWTt7q+Joaz1QyaERfoZRfEjqetoKPio6lDmEIjPoqDWTB2UyvQpEPx
         gYCp5M7aa1k4YQoinU19sPJHi1qke9s4HRrAvIWT4n4qKSn82C994OYxBLTU7JpIJZP7
         rgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=wNdySm2FdYiE++WmmzgbwtWSH9eCWTSgOvV3kDOb6xQ=;
        b=lZ5RJAVOoCEmPO8tSnhWQ2X459tTT+xNFWh+MJfpNdVojFfbH6Q2bvp57W/Wf4E+h8
         kEU3KRCxc2KsI7AwkEUEhWNeenlq9d6+m11ZOZ0QdBZp1A9WHKbxLcI8ziHyMJUUtLpb
         1RlwRzEy1Sp3rHOKy+fuAbT7Sm1iX1wswbjLZppxKCwojl+ijSoRj7A2KMPyWZrZrbFS
         re1eDBh/SYgLeab9ZOuALzF5SpPfljNhvDTvnIeYJItJYuBk5LA+LHRIAwcz4v3vfljp
         5NNu2J6jCvPt4hhLz6TAXKLvJB+Snwcd8ocDSvdsj+FaxM9QpXSuwtVN6TXHYpjAlyIF
         ZEqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@uievolution.onmicrosoft.com header.s=selector1-xevo-com header.b=Bf03Sknk;
       spf=pass (google.com: domain of mkelly@xevo.com designates 104.47.38.45 as permitted sender) smtp.mailfrom=mkelly@xevo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@uievolution.onmicrosoft.com header.s=selector1-xevo-com header.b=Bf03Sknk;
       spf=pass (google.com: domain of mkelly@xevo.com designates 104.47.38.45 as permitted sender) smtp.mailfrom=mkelly@xevo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com;
Subject: Re: [linux-sunxi] [PATCH v9 0/2] Initial Allwinner V3s CSI Support
To: yong.deng@magewell.com
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@st.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Todor Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
 <9b60dee0-2504-6ae3-fda3-64c4458025c3@xevo.com>
 <20180329090256.e9621262cf069c475a706087@magewell.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <a6205796-ee42-1ecc-dfaa-74c196bcadd1@xevo.com>
Date: Thu, 29 Mar 2018 10:28:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329090256.e9621262cf069c475a706087@magewell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.122.179.226]
X-ClientProxiedBy: MWHPR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:301:3a::31) To BL0PR0102MB3412.prod.exchangelabs.com
 (2603:10b6:207:1a::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86978ff6-ba36-41ed-44eb-08d5959a8a24
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR0102MB3412;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3412;3:+ohlPQ0lG+pDxKm+PICtwJ5Je4k0ZfC/+EyWO34a3roW8ibBvc7gG7UHHbPgyaFmDtM+Y9c+KA+cgQ6qYaW/sVwEx/sHTOPiLFxr/Hb0o9kezk80DoFffwaUmqAILpMA8Y4SAZl7o6BeCONFC5zWasCreQToe/3xECFy0LtlatV8Qgu2xlAr/Gkx7NAhcBdfOD2yP94booIzEl3kUU0oct7/SjGEoslygS7IPSsve2ddFPbTSsnziqDbNTW4aB3I;25:m/+OcDVxcsGIQ1kf+x3q4gl/nkMfCmtyKddHMbPlMh+xcYygdpAFahTzi9RUs4KINDQAojxmnnyXhDbRIzd5v4AWjxMpSX8DsKzFfe/cbd4PeaH3Xri0TBWaxuMi5l90KjgNokw+hSlRRv8TGoxf61qCXnVW4mMjTJaAGdG3vm08KdNX1S2yYydEGtnY7BijuJWKMJQABKTDJuvijxMvo2eF+Le6NOcEBw2Szb3D73ASibyLiy3FiGuu/rsquKzDdOZmwMfWH8DJL0JHKDAKyLxsD3po0dUNDhGtKC4+IB9bRoaESUWJDe5eIYkEDqYCRvG+l/DDReHYA8TIczfTYQ==;31:ApdFT+5F+EYde+8ToFuLGODic+8X/fQ4uneuBdcXbOebvdfe3ttwCptTzLQYsrLSq62Exyq3+auqAO9oA2cJWVwyO67zz9C5sMr6iNVYGSMM9Q4CekAnP6a397ixJN/mgNqF+mdJ0Wan9u5EOhjpKLeUnj6J5Ftv5F+ZanVLiv+nZMId9j0WRbE2IpnhW77sSUqpC8MXQVpIfPMVSwqmLWSOe6cb5Ish2WgfeEQKhdc=
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3412:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3412;20:VUyJBLkQ5ld0cmJNtKUu4Fhn/BPKrFQu7kaNR/cs7XSSRLSHvkEeYRnjUVYIXt4u0N7NSTBR7rbD3RN7kvS8nj+h5K/w+BbJoZNb1RCRnDkk7MrHbrkUQt9ps3rexxCsPy7M4kG9fMxBY6gqcot3II7zNEDRb55kMK87qTRfD6ZeH+pTuRqD0jdakwpNqCrTnZMz04UBhI+AFfXNnpc0ZIA0nEiFd/Z/9Imrm9X9kEl3XIzD+/zDXHy5SWcX01ZFI2aDedPmobm7O5fFAYCYD4Ziye6L/bmldeYynHyD+0ftTIpdajOjGMuUMSplXxrOnddDdsIl0hpeSK6u5KpsmHbBipmazqGJGwuKw+rd08C5gNWqwTSQB2WtdEayCgqcZUhCxHh2Wv/2GUHZMQaK9+JbPm8xTfc/wP6/FrGfblI5FyjaezU7FPX04DxX8s09EwGxnWFwPz8frIA1Cj83IIA04krnwpPSyXtHzV0gAyojsM34g6jq7tDFp+OnvGep;4:7ZUuj/n9gkfL5oVUFHRqPnzDKYhN7XkbE6YeIV1SY3F/FPpKcx3I+I47rQZ9E15fZyliy/mSVXAFTcpZETLrAP81PvK8YcR5LrqF7f2NBeUKLIQU6lbMvbgjh/WMum86PYOo7JzQ7h8pUIfsNYTP6H+O5lR3EMarxYIc3SRyI4gpvgeKxna2KgY6P//wpydO4G6yDh333ANicOUnav3wwGqmw25WO93UVqy/3nojIa/Mzfwn1vCwaqhKd3Ko+WbE3OQqMZd7CzFTf6daIKqJEjPAKbyoYgnhLlp+mvV4Z8Pf8Iu7ug3LS2Y0CoMYDj4V
X-Microsoft-Antispam-PRVS: <BL0PR0102MB34120A0DB2F5C842F38675FBABA20@BL0PR0102MB3412.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR0102MB3412;BCL:0;PCL:0;RULEID:;SRVR:BL0PR0102MB3412;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39840400004)(366004)(396003)(346002)(376002)(51914003)(199004)(189003)(31686004)(86362001)(68736007)(26005)(77096007)(105586002)(956004)(52116002)(53546011)(2616005)(52146003)(2486003)(50466002)(6246003)(64126003)(65826007)(5660300001)(316002)(446003)(23676004)(11346002)(16526019)(16576012)(53936002)(7416002)(54906003)(58126008)(486005)(476003)(76176011)(7736002)(67846002)(305945005)(386003)(486005)(186003)(4326008)(8936002)(31696002)(65956001)(106356001)(6916009)(6666003)(65806001)(2906002)(3846002)(6486002)(6116002)(8676002)(47776003)(230700001)(97736004)(81156014)(81166006)(25786009)(6306002)(229853002)(966005)(478600001)(36756003)(2361001)(2351001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR0102MB3412;H:[10.201.1.39];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAxMDJNQjM0MTI7MjM6Qk5zLzZrYXgxbnRhUzEwb1kydFdkNndM?=
 =?utf-8?B?Ly9Jdml3VmU1TmpUaVpQRFl6OEhJa2pBc3RoZHNUZVh4ZVNoVjNaQTZCeG5M?=
 =?utf-8?B?ZElZbU5PaVc1c1VrNU43a1JtdzVNTmhtNGM2WmZOK1I1RmF0dFJTeVlJc0hV?=
 =?utf-8?B?M01xNTI5Snlxa2lJUGxjSlUzYVp4MTREVkpCazJuQUswMHZrVkJlajNrNVhl?=
 =?utf-8?B?U3JwMFhxUTlSVVZURlRWMWpvMXpLZXo1NitXRTBmTnhyUUxudUR5M3JyWkdK?=
 =?utf-8?B?Y3Z4L0VtVU9Xc05zWmpQaGo4OW5sbUE0RU55ek85dUJiUG5mQUZRdVlrWHVG?=
 =?utf-8?B?UUFyTU8zemFNdEl1MGMzMmJCYlpTVDU2aTdCOHpzb2J4SVpicVVSTXM4akgy?=
 =?utf-8?B?TzNUTHVUb3hqOVE1aTQ5aHdBcGhuOVkyaGg0QUxqdnBqdDlXa1JiQlUvZXY4?=
 =?utf-8?B?UHFtTndUTVhEQjVndHpaamV5SW9HUkE2bHlFeS8rQXBPV2RadmUxUTNFQm8w?=
 =?utf-8?B?WlM1NmtMQ0xlT3hlTjV4NkZnNFc3TWxqbmhzamV0OXk0N2FoMW03MG1rYVlE?=
 =?utf-8?B?REZQaTI5dHVscm1sbTJJZnZRcjhMYzhEK1lhNDNWRWxKWFBmNHErY3Z6eVYz?=
 =?utf-8?B?bXZtTit4RnpUNWJSRFJGTVdVcEpXSVI2Nmc3bDBLVmp0ZEY4eDQ2YlA4cG9K?=
 =?utf-8?B?ajY2WjFqU1BldDZrdmd4VVVtUUJQNWhMWlBwZGRXS1lzWENvMVh5WTRDdENT?=
 =?utf-8?B?REdBOW9xSi9jT0FOdW1GaStqaERJK3doMytvVXFBaCt2bURZUjVuZmM1bVZ5?=
 =?utf-8?B?aWZjNnF1R1NYb2hTUEtMamZIVjVlV1VGRXBqVTRkQWtCZXNScTJvK0Mwa2E4?=
 =?utf-8?B?S0ZINWxrRDQvTXo4MlpsZFJNVktJaHhzUlRHeFpoSFhYcGI5R1pnVmI5OXhk?=
 =?utf-8?B?bkU0QjB5ZVVxTTVpeDN1ZzFwbFZ1WS9pYWI4SXJGUUlYY1hEUUluYmZqN3Y1?=
 =?utf-8?B?cnNVQlV4aGZ3emNRWGVWTnNOMzF1WkZNV3gwRUVPaFRxbC9salFqa1pIcXE4?=
 =?utf-8?B?eU1EMlF1RG5ISDBEZ3dsOTdablNuUFIyazBJaWI1R3BjTjFmTTdDOU02bmxZ?=
 =?utf-8?B?NXpwZ0FzWi8wZm0vZ2pvOExqWjNrVVhXYnR3dlFEMkEyQzIzbFJrU0lySEdu?=
 =?utf-8?B?dzZQejljSzBZNE1YUWM0R2hwanAxZHlmZmFSSnV2ZWZTemZicldHdnV6cnRM?=
 =?utf-8?B?bjkxWFZwNG90ZFVEbWJtWS9CTUhLaVNodkRZQ2g2cnFXMXRrUWd1aEJWUnB4?=
 =?utf-8?B?aDVnUmppbC9lblBDWVV6ckhwQ1J3Kzd4YXdJd2RWYjFVc201emVMQ01QUG9T?=
 =?utf-8?B?dTM1bGN3MCt0T1VnTjFuSkoyUHZFZ0t3dzV3c0ZSNVhQME14RGJtcytiS2s4?=
 =?utf-8?B?QlcvMkNnclBxWWlzbDBKT0xxYk1RSmlHQU1RUXRzSU8zUUEzSWIzeVBTdUV1?=
 =?utf-8?B?MFoxb2MvNUhyUW1PNmVvQm1TSkRDM0xEQ3JnZWkxck42N1hzMmxDN21NQnlh?=
 =?utf-8?B?VEtxWWlZY0ZhR0tvM1d1TFdsMU1NNXpsdHlFMkhyaDJJVENmVm1MbTRxN0lx?=
 =?utf-8?B?YkFBMnNvcUZtNnhLT0x1UTdRVWNhN2ZFQ2tuMEhVTlU2UE51eGlManNmWjFm?=
 =?utf-8?B?akVyTkQwWWEveHRoVGUxWE1DZzlVaGZQQWJVSW53SVVHcUdrRlZRV0dsazV6?=
 =?utf-8?B?OTF6OWU4SDBQMmNaV280bVVEcVF0V2wxM3pvbjJHNk8wSXZWaEZ2Wkxqekl3?=
 =?utf-8?B?b0o4Um5IYUZGN2d3NUhvSkVUdDFwQjVDKy9ISmVtZFBxTTFjOGZGZ2VESndn?=
 =?utf-8?B?eEFKalpDdHltM01BVGhmU3FsTG5kQXBxTU1jUDVBblFSdnY3WDh0dWxwQnNm?=
 =?utf-8?B?R3Q3QW04bDE2RGNzRktTczVQcGdVSklkcmk0UXE5eUZxWlB4YTdzc1l1U1lG?=
 =?utf-8?B?cHJMVUVXOHg5SFVJNVlVQ01TbnBtWnhMMHdhdU9BUFJMTUpVQ04xOHVzcXhZ?=
 =?utf-8?B?cGo0aDJ2MCthbGxJaDJ3djRWejFXd241Nkh1eG8wTnRkdkpRZXBnMG8rcEFm?=
 =?utf-8?Q?hA1cLvB1HhR6KowidtC9vGx8h5CklrHQvah1gHS3ZJ1jeI?=
X-Microsoft-Antispam-Message-Info: ZX/p3P8DxuRwwsk/W07RcahEeMrgAfKQA1incZV19viXF/TA5GTQRgPENFBAKNyllqjxMkS4RtVnDmwoO47ezVnno8AhUg1cC5uCxeaJjebuRuOUHiL4dBgvql8DGo7AHc/Qy0WfR2Z4x3v+GlWA1AWUgHNkp5Hzjm+eMXf3ds6ipb3Ir0y0NxwBhfYSiHgu
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3412;6:bnFlxq5O6wOXsUBGXys+vajYZobQN8Gu2dYvvY6LHkd5+dKFK5DBXq1q5tm4iiZOqy75/ybEPVSMFy9iHajEfBSyGZpQbiMykLGUbwnBYo5u3NmFUE8F9KbIQm6LsnwyOQtYOEmJXFfm5OKcYKhAN4pUf/G/+LzqM22pZZvJn5aRMOpynHcN7mjkh3H3FLlZGSWzEVdLsqj9M2m+/PkS6d+Q41tLeY69Zjc185xE77+Twu5EM8QMHZa9AE27gAKeadsvMhZGOgDN1bGuaxQJg0tnOZDsHkuoqbaeqDOFQYlLcpdvVCb1PfcG2ovi+ZO2ksNWnwpSNqsTXs7GAEWl5bCZuj9wCgFAmynnFNJZPCHwsst6OqvHtJAr3ZNWaI+Ah2WMG75ZVlWOetCb/00zlqNdb3+jScYZb5SahORizXajUbeIUJrwz/vC/S3AqqArlj6BMYki5cPgOMDIPO5yoQ==;5:GCDrEs0dA4OZ2kv1kylLjBFqprhUUPjo8G2B8xcb52stNNgH0hBMNs5XFM1RoGni0Q5ofrq8gUcowDGmGlwC0yPpAzfMBBSUGNTfeCiSc5NiAmrqp2tiEPhagtGrbAO6lqSI8TH6sKBH55gI/cXtwYb9WwAA9vDxsi8fu2UVMV0=;24:OPlkv2te1lfpfO18rgYY7gho6xPecrbLg9bkO9IjbnK6F1ZSi/a+P2mMVLSpnQ24YxzkcK/D7yDaycS53NipRaYsxXPhasnkMkxYU7yZ92U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3412;7:ji73zUBx2sg7ZNf/ylJ0s3Um3/4ZIEbQ4uiJZv1C18QVRz+PtHK0SH7mMPvtdPFHMWUYSAbS8drSU+sR7hqR2x/SuK7zFpQUFaybe6io11fA8IcW4fQKjRoznWgUufMGICXuQ1BmLjUWo608H1XFH5OsmUoMyVmT0SiQz3W2M2Jj3JvQHQFRKJFTpBywSeNGRPx1gu4c+vCCPLAsNZkkXvSPie61bdU2wr/zKWZqPdiWqQ0w7lT2PMswIE99+Xn9
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 17:28:49.9515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86978ff6-ba36-41ed-44eb-08d5959a8a24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3412
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151284000328035?=
X-GMAIL-MSGID: =?utf-8?q?1596293945221594572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/28/2018 06:02 PM, Yong wrote:
> 
> AFAIK, there is no document about MIPI CSI-2. You can take a look at the
> source code in BSP:
> https://github.com/friendlyarm/h3_lichee/tree/master/linux-3.4/drivers/media/video/sunxi-vfe/mipi_csi
> And try to port it to mainline.
> 

Yep, I see there's lots of magic constants in that code. I might try to 
forward-port it, but it won't be very maintainable or easy to change 
without a datasheet. That's too bad.

Thanks for the information, Yong.
