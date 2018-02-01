Return-Path: <Michael.Hennerich@analog.com>
X-Google-Smtp-Source: AH8x227P3GiHZPLTvsmtUhZaVIEW8NpZhZa1X04JkqVP8N4lknmGofP7zQFYNDfotqF8lsTD325P
ARC-Seal: i=1; a=rsa-sha256; t=1517502312; cv=none;
        d=google.com; s=arc-20160816;
        b=qtfQ/6FiTNMaDFnLbQ04iM2KZjOmR6pUnGYzFM6H2hBOr+IVgT5rwvF9E9d2Jh2rR/
         wgI3QdcSlWNhpFcjw5DXGVyXpXWfu4kEnddfMuGYJh5npV2+pihJX5jRLguooWkBGIkP
         3IHQjx+1+FAuj58Sm8fBgOZHJJqX4ViNkFFG3U+wQ/By4KgI6uu78Izn1N0uqdoqKgjp
         DEs/q67ILYnYfsn5sMeZLuAMDOLqnB1noi8VnahbHC/w2p9HTNs1A6yoJXha0l+Va0Um
         TQC322WXEJonT/DvA9rBYKIjKPcXx3O7+pYcSgVkLPgfmgv/Ej4sbC22LGyjsS9Rvn8K
         zWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:dkim-signature:arc-authentication-results;
        bh=lEPAHs19SxaYLOWrx13Vieyycn1xEonSs2lRp1Kyxo8=;
        b=kjVNZvfSp6qi1Gb9xa9QbFNsZtpYHuTT8ziLiZk8Av/SkTdPhw85tybwrCq1BpLQI5
         rMlS6Ux7xDV1Uj6RT3RLP3LTp2M12YIKcgh5X7io5lhuCCU8d6OpuX56jYYyk/jG/cLi
         NxAGer3rEQo6YqRz9YE0XJ0I8vZrAgy8q1F/y2WmdourOOOQltVDg8+t6xHcJkLflvJJ
         CC+lYPqmar39AyF64PJiMq7vh56Ur2AXEaU3+Xl7V7xt0Pt+Oo9QKTONhF5BtNvG2M5G
         tRU3RdNBah2nAtSyP4JUngajgja3EBW/4V8Yzld/J6hiDKaGOjZVQxnS+SzecZ8tqBBA
         7hPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=tu5kuAEp;
       spf=pass (google.com: domain of michael.hennerich@analog.com designates 104.47.38.62 as permitted sender) smtp.mailfrom=Michael.Hennerich@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=tu5kuAEp;
       spf=pass (google.com: domain of michael.hennerich@analog.com designates 104.47.38.62 as permitted sender) smtp.mailfrom=Michael.Hennerich@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH 4/5] backlight: adp5520: document sysfs attributes
To: Aishwarya Pant <aishpant@gmail.com>, Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han
	<jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	<dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
References: <cover.1516978005.git.aishpant@gmail.com>
 <fe0d47871d84f83a927e139928afaf754141b7fe.1516978005.git.aishpant@gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <53d4187f-98e3-4227-fdae-8a80f3ae3132@analog.com>
Date: Thu, 1 Feb 2018 17:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <fe0d47871d84f83a927e139928afaf754141b7fe.1516978005.git.aishpant@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(39860400002)(376002)(2980300002)(438002)(50944005)(189003)(199004)(47776003)(3450700001)(7636002)(106466001)(4326008)(2950100002)(86362001)(65826007)(356003)(5660300001)(229853002)(77096007)(64126003)(230700001)(2201001)(186003)(50466002)(65956001)(246002)(305945005)(8936002)(336011)(8676002)(26005)(478600001)(23676004)(2486003)(316002)(110136005)(53546011)(58126008)(36916002)(31696002)(36756003)(43066004)(76176011)(67846002)(72206003)(106002)(7416002)(31686004)(6246003)(2906002)(83506002)(39060400002)(65806001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2718;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC005;1:HlNLI9vG/NBhIlqAHqVOGC409QhR8Tpimjf3mreV6hNZofl0zrVZuM2X+GCWciSm7qEAsF5ZycOfqr95mMdj2bCh4TPMDPujrX0KtpAOLqX+p0NGlQ77jDlRndDeIGl0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9630189-d4b0-44e1-3046-08d569905c2e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:MWHPR03MB2718;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;3:hnKBehjhgP8c0BvYfdPw+qqBqms3lSuGsaMlN5ICxTbb9avsNGj3n/DH1Ph+QSz2+DpngCGbN9B5HmIafmGnP/UVYKt+UcxS1wCCKgtpFAXIC4f78MsnhLhs5TT0zwx8XA7jOA8xNp0EW4roEVp4NAKwwCNY7to2hNh0qF/JlA5fdVjeVXYPTV50hIfaY5ZTlnWvldHweDec16FEYO7ZpBIKkr6od+ec8b2gOEhzuzf0M8HfJsf5NQF7UhDBYAte68HSVfAyin5l3cqy3avD+4zBTV1CdeJvvw9m4R9RgUAaTqswsxSXHBmiO0pZw6tST5QR72g87QmE2NwNxwK01FrMlg+Gzjw1s/JvYqyLK0w=;25:o0+U2oW+wwFaepR6wdk8eepF7r6NZdqX6d7Xu0C1fnOZr3JO7TSsi6r87o4N7wXDVbRkbr8eAsHdTktUUQUB4DG5ZUjl+fLDSHwoPGBa7cK9th2uSLGxIzE7ol4+TIJ0iVHqxMDa6qNStp0yQSRhrYwYdHwd1s2JdzOz0YdoWTLD+PenLbptw20FFuYyfSh7F2Nz11x7G0PB2I+SHvacdUo5jZ6rqcnp+2Sk+uw+K/ZRV7FvhEWgcw4hOx4j1IHn5D4b7WFkm0bMKjIqO6NPrS6qr+fKjiL2YFn+V/Rry1jKBm3a8SxCQp5CS8r0+4bcAcMrVSVmtpBUbcR5a/W2Nw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2718:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;31:/95PNmGv4AsRiop5FCPKuGiAdzC/2hWbkVGubxOk8ppz+wAK6JJvB6FivodM5GETirK4tzOmhip5wQI1XeZ7TZLx+1C7k9UuFAikVliJSeg3QvuyiiGOnWOmvU510wbyD76t4jo9KAwN4Fmz1jqgeMDixhLlMrO4MqpLl/3PaUnozivmo73fDEH/PrKD4+TK9a3BkhVsgwV2UI5CuZo/i2I55ba98UDH+0IIuYzV140=;20:dwF6+hfMMgL8TnHIGDfLo7Xa2VqPkhvuKCE1eoerI1h2hzicdD9T9877adDluhJEjCtQmz0pxu9wTfNc49k0735k8HJOjXmHKolCl51Wc7PkoRoa6wFN58c17RSFaY2ZODs9Ty13S9eK9neff1rT8po/cg+x0YupzCMA3g74lqUwHdzL/dSZzWZg1AK3hb156a/j5i0RnvHwclx5EjYLP8GJgnTVy0um2iTeM7QRZG4icDu1DuiXT5lfDHEw4a3+/e75z2/ibSYNkQjWXb7m/bYCyFA6X59vOwlaE+yuuHJGfDerNq381OLmFnQfeq51SNvK8A/JeTZHqDkYXcxoGAoZLsb8reHHTzrR/gboh0yFg2DR3KU6wSChkapesRji8kS72ft+PtiDyX8gLF8JYrJq26gzqAWV2ouzbjqgIBwOB3iKM/znZAt9dCo2ASMfODP1IqxmGcSPRn4oJsKgWfpk/loiaW4nEu3+Ov3RT0SUJ8UJaudi9EePD8TKg5+d
X-Microsoft-Antispam-PRVS: <MWHPR03MB2718FA7F28B5B48517D9D4E48EFA0@MWHPR03MB2718.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR03MB2718;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2718;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;4:Znq38Q1JeuLN+jQ2hYsXhNGOyPcu/uF+3ifo6Flcz4+8V92o3PDaGtLBVXyRNdQYWngZijpDTNdX73LQK97UJDIDPjdtbhvLFMTui97g2/cJrNp79TZ/i6iLty9/1x5mPI04b7glFNQM6BUtGCAvZA7+wGUOko6m09YPr/CS4zsoqDzjHzdCWHxV0MupPlbT/fXBe0aB5DX85BjlZEoT8kK1QINKQ+5eHdlGIj9U6WJ/CpaFmXoXy3h5Scw/ftdDeXblQvSwexm13VcZxRTqsiv+4GhHogBO37k1wGpk9WeNLmyGO1x7mhYU/zWtwv7a7JngzeXQtflvq2sK5Lf3+fRYQV6+VfvOMGjAXuso+/o=
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAzTUIyNzE4OzIzOmgvdFVmNksxZXdzSlFzbFNQTngwcSt4K1dH?=
 =?utf-8?B?RTNGNVpONVd6dHhQNHF4MnhnT3RqM2NwVitjNUhIRWU2bm1oMUlvWmthajB1?=
 =?utf-8?B?bS9oYWZLeHpNREV3UkRiWHpLUkk1aDNsUlFqTnlaMVl0S0srSjFmOFc2YzFp?=
 =?utf-8?B?MlJkYnBxdHVPenZ3L0ZQYWg4ZFcrclRsdGtVcmovU2RxZzZMcXhSSXZobWJk?=
 =?utf-8?B?NDRCUGEwbGFHaU1CUmhXVS90akhUbmNWT1RIeG0rdlFBS1hSQXdhM2ZYRHlB?=
 =?utf-8?B?d3B3c3V1N2VoUUxsdGFyQmFMUW1RWjcreGFHTnh6S3lKMTI2V1cyLys0QlFi?=
 =?utf-8?B?d1psQi96TVRnYy9TelhaQ3ltYllIdGpFUTFqMDUzNm5NUG5WZEVJUHdLY3p1?=
 =?utf-8?B?Uktzdm0rV2hnUGVQdWxKMXU4dFRsd3lPT240V1BFTE4zZGpsRTM3Tm5ReG1D?=
 =?utf-8?B?SmZZQ0t4UkRkc21LaGluc3pMNmFFbkNzeDFUbGlwRkZjbnVzUlYrcENiYUFC?=
 =?utf-8?B?ODNXU09FdDVWc3NOdjJGczhSNUtpR1RQdHZEc2ZkVjRZRFNDSmxPTmlYZnpa?=
 =?utf-8?B?MHFwT2J6elFNWjdScGQzZzF6YWhvTnhYRDhYMWFJeGVHZDR0dFNzTFhDNWxS?=
 =?utf-8?B?NE15d084VW44UDRuV3hqaWFjbnRZT1AzZTV3SVZkM09GSU92K2dWMlpubHMx?=
 =?utf-8?B?NmRaNEdUSmNxUjlNYWZvVUM2Y1ZMb2NkQnZQTUZaN1VoZTZwd1R3VFg4MU8z?=
 =?utf-8?B?UllPWGM1d3ZCdVV0OFhtYjBQSVdYRkxhRUFnRE13NU94U0owNnMwUk01eGJO?=
 =?utf-8?B?dVpNQ2dtRGdQWmZ3T25MUHU4c0hDRnlNSGFuOHhISkNZREg3aTIzR01ZRDBw?=
 =?utf-8?B?dFZNcFl3TmtJOCt5N2dsVk9hbkZ0djZDTkgraHZmVVlIVzBUWDA3QWxXN3dr?=
 =?utf-8?B?R2lPK1FnWXpMU3Z6bCtFdkRsbU5hY29xWld4RVFsUkYwalpwbkw4WnNKMzM0?=
 =?utf-8?B?YXd6eFYrUlVVbXA3bHRkcVZYZjJhNXcxMVQ5SjFDU21hKzhlTDlqMERPODNU?=
 =?utf-8?B?VnBmaE5Nd3RKbG8vcnVIYXNuWm5GNDh5NzJLbisxVHdGZjNpbk1Dejd4NzZr?=
 =?utf-8?B?ZGUwTlVveU5FQWRITlVYaTJVbFl4RkpScmMwL2YvdklvRjNVVk9LUWllSTMr?=
 =?utf-8?B?MDdCbm1yMUwrNlJBT3hFdVc4TUZOa0crQTJDSEoydTVYejA1eGEzVE03aldO?=
 =?utf-8?B?WkpVc0tzK0daeUVCdndKL0o1d3JDdUxYZmpYa2tiOFlQWmZUSXNaV1k0UEJL?=
 =?utf-8?B?YkRhQWppR2lNcGtId2hYSTV0QmxWQUFFVytPWTZiOHlUMWhaenhoZGxHeXB3?=
 =?utf-8?B?UVBXaWNFcTVERlREdGdySmdncUhUSDNzTHhzY09CN0tLcnN0ZHFOV1NXaTdp?=
 =?utf-8?B?U0NpNlRyMGE5ZjhMS1VBYU1HZTlLNjBxTWgySTBPeGYxam1VajFWejF6VDZV?=
 =?utf-8?B?RFlVckFUWE1ZenNvTWtXazNDais5OEh0QWhDYkpzYzRqNDc2YTN3c2lxS2ll?=
 =?utf-8?B?UWJ4ejdaWkJ2SlNtaTZQWkZ4cnlLdFlyeXNqSlRZOFZMbzBXbmpmdWpmZ0E2?=
 =?utf-8?B?eFo2L1NGSTJ5cFhWVzVsM3ZhR2p5TVIrWnhJaHh5WFpLSFMrVHlNSytVUGZu?=
 =?utf-8?B?ZmxKa0lqR3NwMzdpWE93cDlKR1psZy9MbUNzTGxOM2gxU1lGUm4ralJ3cE9F?=
 =?utf-8?Q?e1hrPb+TE2NI6/eZXlajmpHtsLnW2nbBOnJy4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2718;6:t7KFXajIzoh6u19VZ664YSDEFXGJ1JBJRfM+O4nO+l9TpqbSAeUDFA8E6iLvzfTc+D4eo6l8mHztVFtv03RRFq6uJ91iqrj1ibpjqvCUQ1N8rbO8oBfXJcBa+uTMQXXGlIW2wxY2KGQhRB+RtSabugvud6Y+h+uP3Ud0WBoKz4/MR5CB2GWHQ1KdGduqw+u1EKKGQuKh0VgZBru2VW0RnVxZkI3AMws6usw02YDIpR9/rFBomW46xz8H1WKtP3FrMES0yBp55Gx7TrVbHbUHaOCLE1j79dvvHMDMBTEoBfjVaGjvS9C4u7traaMQdeIzp6IHIvD+8PxWcsK3G7An+Y2kY/FXBb65J8ukAGhAhc0=;5:08qCqdQayYQZ5ZwwXd/onUWoCnV6s+tojP5XaU/xLMkdpqUpk968f4uCJdGAi1XjVgSWU5cMFYJ/GvCfWIPRxcLjASQtIqdGOWMki28t/r+i45AlIRF3hGQOMtPlor4jX6qBd6sT7WKfwFiLEnk1XgsxlCk5zyutrXrQQUf2Qiw=;24://bMqRy++A8rOHJOY5prt9F2uMw02qTEmco/ZZUp+cu3129q1Ln8gXrU5Qrgxh2TOLdH1eWSdeOXB7bZl6QHOW41ZnJjB/Jk3E7SSDEkPJY=;7:WD7bv9/qp4t5AzEWfKckHoE6snBFTnfmZSN53jvHKC/JOTA0RwdN9W5YFP/tM1lxJyFgiigQyFWrmj6XI/icsd8/thU00RNiehILPhvbz1kXIuE27YHNmYFcyfUmYk1f+daGIpswjVrq6OJv1c9lsUdvrJmiPncPSzPt3bhQX0Ez4OcM7fbQWzEagsAJcVEVZYUQ8sVXIg0b/YOUArZE0oIxMzhXzbtA67/vsCFxOh8ZuPJ6tpvx7/YZ7/q57uYX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 16:25:08.1943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9630189-d4b0-44e1-3046-08d569905c2e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2718
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590667245765542746?=
X-GMAIL-MSGID: =?utf-8?q?1591216505058839784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26.01.2018 15:54, Aishwarya Pant wrote:
> Add documentation for sysfs interface of adp5520/adp5501 analog devices
> backlight driver by reading code and looking through git commit logs.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   .../ABI/testing/sysfs-class-backlight-adp5520      | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp5520 b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
> new file mode 100644
> index 000000000000..34b6ebafa210
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
> @@ -0,0 +1,31 @@
> +sysfs interface for analog devices adp5520(01) backlight driver
> +---------------------------------------------------------------
> +
> +The backlight brightness control operates at three different levels for the
> +adp5520 and adp5501 devices: daylight (level 1), office (level 2) and dark
> +(level 3). By default the brightness operates at the daylight brightness level.
> +
> +What:		/sys/class/backlight/<backlight>/daylight_max
> +What:		/sys/class/backlight/<backlight>/office_max
> +What:		/sys/class/backlight/<backlight>/dark_max
> +Date:		Sep, 2009
> +KernelVersion:	v2.6.32
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Maximum current setting for the backlight when brightness
> +		is at one of the three levels (daylight, office or dark). This
> +		is an input code between 0 and 127, which is transformed to a
> +		value between 0 mA and 30 mA using linear or non-linear
> +		algorithms.
> +
> +What:		/sys/class/backlight/<backlight>/daylight_dim
> +What:		/sys/class/backlight/<backlight>/office_dim
> +What:		/sys/class/backlight/<backlight>/dark_dim
> +Date:		Sep, 2009
> +KernelVersion:	v2.6.32
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Dim current setting for the backlight when brightness is at
> +		one of the three levels (daylight, office or dark). This is an
> +		input code between 0 and 127, which is transformed to a value
> +		between 0 mA and 30 mA using linear or non-linear algorithms.
> 
