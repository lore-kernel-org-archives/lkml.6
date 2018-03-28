Return-Path: <mkelly@xevo.com>
X-Google-Smtp-Source: AIpwx48IotLAzztX61AxgCmJ8GKI9coKqYOCiE6CLZiAxs04FjcVQpBfldR5tu/YV0gIIy9i/m8j
ARC-Seal: i=1; a=rsa-sha256; t=1522279800; cv=none;
        d=google.com; s=arc-20160816;
        b=NNAP8vH2gU4mTcr9WZ0sk6+dNOXLvrVbIOxivh6MwkO0O5U2+hcDyS+7zigugVJxDZ
         RLSU+8oS8GLMCXAPImlwzBPuy70BWM8iddG2XJ49HFujtNu8Ho9k7y0iMFLpheCEfIu2
         BpuqMFH918s0/HChDZFXUo4DZAlNAiwlflcCyiRbhr5TQn5iTGhlc0CdiPCPW0p01EEy
         8g106Y8LfhaMcCqYES/WTA8FLSgsBsi/dn2QDZ/uxlWCcRAJXRta5/e1BhXxvXm+Cg/B
         rLjtpyQgJ3xZZPk8W5t4xMyJm7jCLmpqmrDuK0XlVFp5THy5obR7RZlipQc7lW9VMy2J
         SEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=PnR942Wp6cToDWRFR+naWe3MNHUTvd6MijZpxsjmJE0=;
        b=fr57/+2xMcHa2iXsjFj+UrjRGusftKkm0Tf7vXb9zmvluFaolK12nDxTp9qid2w2uz
         mhuCa/rF2FOOMr9sca6Ou2Gjt3oO+X42df34E1sz7zg+7ppHKJEzyKctbuWgWDYUdpiQ
         XWq3aRL0u9ns4sgDH+aXNo1KKxOtcwUoMGxRMcJ4LQb6bC6kXsTZVCXs/EKHAalxjIkZ
         OTxD141hyU7fpE9zEx5fVORBrxEAPa9G+mQ+LbQ1rhauKgfuWdax0XLZTxyhmvA2UsKp
         ez84XZbpDZLH5NyMLTe96vd391BdT4VrlbFwvYHrvxZg5yiKoyu8z1o4RdZLUw+f9a2e
         PjdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@uievolution.onmicrosoft.com header.s=selector1-xevo-com header.b=2kN2a3za;
       spf=pass (google.com: domain of mkelly@xevo.com designates 104.47.32.48 as permitted sender) smtp.mailfrom=mkelly@xevo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@uievolution.onmicrosoft.com header.s=selector1-xevo-com header.b=2kN2a3za;
       spf=pass (google.com: domain of mkelly@xevo.com designates 104.47.32.48 as permitted sender) smtp.mailfrom=mkelly@xevo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com;
Subject: Re: [linux-sunxi] [PATCH v9 0/2] Initial Allwinner V3s CSI Support
To: yong.deng@magewell.com, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <9b60dee0-2504-6ae3-fda3-64c4458025c3@xevo.com>
Date: Wed, 28 Mar 2018 16:29:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [205.175.119.149]
X-ClientProxiedBy: MWHPR18CA0037.namprd18.prod.outlook.com
 (2603:10b6:320:31::23) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a0::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86f04df-6d74-4524-bc29-08d59503d130
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR0102MB3414;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3414;3:y1pUSI/dQ0wgP3+bnU+8S+WSqV47pYr25Bb/1NflkorraWRJTWxSdYaD+FYJNsh33xM9SfUfKGsHPI3XqkbgR8HGJ5r5vNjc8/RS5HkCIQTyRRbfq/DE38FG7am/KEy5zD74lVcoc5U9SgagE/bGMWbFSOER2HDUUngqsiqk3S2hmTpNv4TpiBQnjW5rQkH8Jn1mYhx8JK1A1pxAe/2XuwP5QkCXNAZtHriTiOfojmqyo8mUPDISffG97VfRjst+;25:cQfXhUqUSUH3ARzmYKL2dHNM9E0Uz6r6FxhgmFfYM01PGbodhZZh273zUdfe8J6vYp93MB0DWcMCka6mWSRsFpM1qBhI4ljKCOakOeySKDcETkuXNwIlF7IN4DE+RUVDE/vNdGhzMiTGiVk2mOqEgjhXiQOenTB1xiA3yBTPF52hnX+REC9IQCEBERYgyKV9HAfkevI7ymHFFsjOe59z9gNeJ+gOjQBlJiFGpd0itR82gMyeIcXenZivJeDqGFvUfQ+QEvEV64hW3u0vJcSjqSUIDqGiyBAfY4roauYvx5SFtl5yw0XvDc180eSF3VeeF7kgnWv+NYuXCyssRHYs4w==;31:1S2H5gGHNt6WdxR1m/s6MEPArKF2pvjuT3AbzahWgkrSc28Vy/nYj16A8nfcATAwTCMO/M55TCktZHgELrJLK8k9Pc3ySDIKjGz0s3F6p+lm5YBJfZfXoeQt0zsC/fSjkW4EraQhwgZZOD4QP8ygnlvlOp9j2csiNQwZvb9jYgQQahSe/5foF4Iqvl76eXHDPMZLHj8BTUyIUkrf4EKu4ijLYe/T9UD1Q7rYzggqzJM=
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3414;20:L6/8H6749qIRfNYs4eduvJiPchS2eFwDK9JI6ct6evTCNmQ+1trqP4of1Eu6gO7RNM8e1vN63fCSQcm4K5adDtSffhuZyXmfs+vt5AakNpK7m10la/a4kjoJxDzz+Yws0ZFMwJtEic4mQS3n/d3npZBOGao2YUBuB1bRQDae2tQgIPYz0l3siaf+LuWksGwS3NaV+8HzjO7tW7PKlESBW8uWuO7bGCJ9/OTJdRscq8V5dYbdmr15cnHUtsLR/+/+ECgowSk6wRprt54VfIJt8BQWrIZ9IR6UuKWjSi2jUSuW14NUNfbqsq63s1iJMCbF1+BlpXfIg+YeKnQmAO2Ti2b3uWACbmT4hZuCEtm3Rr8qFhH0MrbcB5Qy90B+QpW0KkRbIpL8S5or1qf53TcE0WlTKDaKBo+PnZ6rDJVKEjDKPA7Dz0akfEeVen7P1Fi0goDVYJGZxl4yDWPoPdUKyKKTKJ6nrnB1WdsPtdSI0jRWRgS2wLUKGnHLea9DwtQJ;4:GiQcIr3mJT0y3Sn3UhcrClDky8neVn23wayD6/+ZjeVrhwux+hY3je75jrdIlZWLKRlow4/M8QdW2KtxhIN8amo96pMCaZEyqZHWvOi9V4RBUt8Mu01krmRJVr3hCofL7GJ8xRdcXlAudGZ8Qzp/+azlGaHJeI7zrGTfiOXK/SViOgEBzew+sQbUHlVral6niDkiRrWcFxcs5JFNF2cSVrXigzwVBLBqaf9yhPqDvlrCTu/K0ubh7V469IUw9RUE0h7xzI5EmhkhIg1JddjTww==
X-Microsoft-Antispam-PRVS: <DM5PR0102MB34144BED65648DE44A1BE8C0ABA30@DM5PR0102MB3414.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR0102MB3414;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0102MB3414;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39840400004)(39380400002)(376002)(346002)(189003)(199004)(2486003)(6916009)(106356001)(105586002)(6246003)(53936002)(6486002)(97736004)(47776003)(305945005)(66066001)(65956001)(65806001)(7416002)(7736002)(36756003)(6666003)(26005)(31686004)(31696002)(3846002)(956004)(53546011)(386003)(11346002)(446003)(229853002)(68736007)(4326008)(6116002)(50466002)(2616005)(5660300001)(52116002)(316002)(67846002)(25786009)(64126003)(86362001)(2906002)(23676004)(16526019)(186003)(77096007)(76176011)(81156014)(52146003)(54906003)(65826007)(8676002)(16576012)(478600001)(486005)(58126008)(230700001)(486005)(476003)(8936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0102MB3414;H:[10.156.0.118];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAxMDJNQjM0MTQ7MjM6OHdpdFQ0Q3FPQTFiUEZadytIQVVTdjNy?=
 =?utf-8?B?QVJ1TWdKdDM5V21QU2wzSTB2VlhqUllabE5qUDdram9DMnBzdWdpRFZKTjVn?=
 =?utf-8?B?WWtpZnNlemx4ajhSWEJQcGtzVGpDUWgzRnFKeG12TnhLUG9WanZlcUVsTzR2?=
 =?utf-8?B?eDNCUk1TNGlqYzA2K3BYMVdvWi9yeWJXSW1ZY25lUUEvbDVWQ3JEN24yOEpr?=
 =?utf-8?B?OHdXUWszMFlEdGJxdjMvdStoTTB2M3ZWbTVZY1lEcFN6NFdVY2p4cm83RmVC?=
 =?utf-8?B?VnBXcGJjUWZqTkRYQmIxaElLVS9GUEMwNWNkRG5LWTgwVElqcFoyOHViaTFW?=
 =?utf-8?B?T0ZQUVc3LzdNVW53b2ZUUE1PUitSWlpUNjFNYzZXcmo5MkF0Wm9IcUdURE1W?=
 =?utf-8?B?VnJFQWdNWFlEZFIxRytGT2phbFFqNmJxWTJnWWY5SzUxcGJ5THMvcnBDcHh4?=
 =?utf-8?B?Yis0Um55WXU3SUZwNEFXMTVmNG51UVdYQjBkQlNjMWYzakh0b09rMmtJaTFp?=
 =?utf-8?B?eEhBWTVrMjRpbGpEVEk5Qlc1Umw4ckVYT0RsK0hucW15QkxYT3B6NDVLN09n?=
 =?utf-8?B?UnZWS2xWd2FxSHQ0MEZlQkJoY0gyNzZKWUkwalFUd1FhQ0ZUUCtKdm5iajNh?=
 =?utf-8?B?citrZ0tyQ1g5a2pEeUFQUzhjc3dPN0lta09KMHV3aU1mN2tLNUlueEdSallH?=
 =?utf-8?B?dkdBT2l3V1Y1L2Q1SVlHa2RnTVYxVERpSHpNb2I4MW9mNnhLd1IxVFF5MXV5?=
 =?utf-8?B?K2FWTVhJVG9zejYweVA5cWZrS0VpUms4RVprNG5wYU5TOW9ZRTY2akJIYllG?=
 =?utf-8?B?RlZ4dEJLbUxKVGNrU1BNWXkyMDZWeU4xeTJYdGJSaUtnd2tyQTBod3J0SkYy?=
 =?utf-8?B?eE85QXVGZ3lzL3JIVURmT0kzZU03Z1dFQ3BsZUxkL1d2a3p0QXdTM1BvWVlR?=
 =?utf-8?B?cFJ2UExsYWtEbFRWbk9JOERnYU1WWlZaV2tIZHR3eWxkQTRzRWI3ODlsS0RF?=
 =?utf-8?B?WFRDbmdvN0YwSHJ6UnJZN1FwKzJPb2ZaUW4zWUxpWGFKSHlYQWFVbGZYRnJS?=
 =?utf-8?B?a3VoRnR3dmJ5aHh6VUNsOEpEWVBwbnVqWEg3MEkrdUl1ek9FMFRjSm9rL0dE?=
 =?utf-8?B?dnJvRDJzUGxoM1NLREdTY255a01STytxRDk3bXJDOGNoa3A3dEY5bmFiU21W?=
 =?utf-8?B?SkJESitad3ZidDBralV1TC93YTBPbWdjUE9CQWVaNkZobVNVZ3Z6ODZEYVdm?=
 =?utf-8?B?aCtwd2ltUTlNZllUV004ZE91dXdwUXVmL0xPVHlkdkptN3p3V2szQ29aWHRH?=
 =?utf-8?B?T1d3LzA3R21nbFhYMDltNStUTy9OYWZnSDdCWHhkMkN2RG4vNHBrbTZkdjY1?=
 =?utf-8?B?MU1zUVMxN1J1SXB3bTR2bE1ha1FUY3lCRWhhSnhsajlXUlV4azFGUXFQUFhU?=
 =?utf-8?B?YW9ZdWoxZUI3RlRJU1BmRStJd0ppaXprVU5pcnRrR3djM2lnOW5JZ2lPNy8r?=
 =?utf-8?B?KzRFanIrV1MyYWcxbkRtcUp0b0NNTWtXWFhQb1Zrbzd5Z0ZDNENyTjFEYlVv?=
 =?utf-8?B?NnNjRnI1cE5pT0ZYNzAwRU9oWm5MK2ttd1NxRitnMWRlWS9mRjk3WlBwMG05?=
 =?utf-8?B?ODdMQUdDVnBaQTJmNHJNVVJMY2w5MExJejZCdCtwN3NMbitzb2hEdTJWWFY5?=
 =?utf-8?B?RDE1K3Q0R0N3dXNhamNVbk85Vmk3dHdFVGxhS2lwTnNGRzZYM1Z2YWRoYzFB?=
 =?utf-8?B?WVNDd1hZOTA2WTcyakpPWHd0dFkvV0FFYmtYTmZkdlQvazVZMlk1VkZwbFo5?=
 =?utf-8?B?VEV4eWhtVmlvSW1iekFmcFBDd3llbmQ2MjNoVnVhMHgremFlTWZobmZSMFhw?=
 =?utf-8?B?TmtiQ1JsVmYyV204VDUzVXBrVFRpWVFKSXBxT01HRklFTTRzR3M5MGlxZjNq?=
 =?utf-8?B?RnJaL0FIQy9MZFhDZTdOSWdyQVp4ZnpXcjg1bDFwb1lCTjRYSi9wK0kyNDZQ?=
 =?utf-8?B?aG1vM0JFWHZQUlI4K3AvUXl1eHUwMGFkcWlJTFlnPT0=?=
X-Microsoft-Antispam-Message-Info: Hf9BG5eqZkGcjHKD9c2xbhbAAkW40Qh8iTuywwk1gsoI0F2hJTRuukjih6a5Gd9jGWgg91V5IOYAbSQ32yq/a0SOswm5R012khgYop5GJ3zCGQ1v+8TDOtTY7e/aqnE7W0rU3h07en4c+tan3/kWnjNLRbWq3xJ+0/DnLrOipXovfPca1AkjO2WBbecLUgcE
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3414;6:7ixiHzDW/1f1howGFLNlitTO6licAEpj4+C6q/JIWe818sT/af01uBZTLyi4AtXzX9c1RlGU7CiUaFGEN3WzI3cLLUJCPolFgrCq1LJeILZRwyOTmJ5bgo//QqFP0ByaPCZUsE0SzSLGvMlchWABSnvigHIN0BDlWgHTcalKVN+PV3KmLyqGVyS24l3BgHUiRzQq9nOFhDPWgyLptC6ipEG/KPaY4jxsp71vd6q6FPTPSP7LZOP0sfHx4g7jSrj1XwUjSoXSZPxqQbYj00rriY3fcnFox3b8QLrKBGiWBAlsRDqw3SU1+bN7Q0/lLBFJRTUJzLNeyGsxvlyTREKQlczd9D+itljRqGvY0T7AH9iJLtR1hzhiQPK1+bWiC5ScaMh9TEHKSwcn/THo6kINo2bnxpIaAlOPVg+v+2VGv1kwwnBMHd05fpYiODWMuCyn2qTm5Ead/uwr39/s6kI02g==;5:3AqLmCSMoCYIv0ivF1hpjm1Q/m9sEjkqWNsRdqSwH0EvuFY65lPdbE901djYAgkLYvqpJZkySHPY1aTIJcu9+qML2EX66XUQS7OCE5otdW8rUGVaRcIYLHzQNzk22kIcuq3Ng0796kb8ZHGku0YU6PfyAxh9u6RXiHS4aJ5iRK0=;24:piAZvJJ1D8WZQwrIFleNmuksJt86Ogme80mbTS2ecR75sVM87tR1vqPcBZu38mRX5MItrfQ5jhA7eXMeCOPwaJuv3AVUbH47FKxY+fvZxQQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3414;7:Nrr57kxaYaYtLU8t2GUc25KORJ4J3C5qba6gBomUlROQ5EyR2NCfC74RD+bYo4BHBPZ7dYcsMBitxF1cYUBRo92FMzcHTWOfPU+N9gCkDM9+kT/Jfb1XhAwVX8Uj9hPaB9df9+77SzNxeBUeQCPmobgBPnslj3hWxts/iwlU30/fROP6FPC9wIuanTmfJRXnzRbrRSTFnB5706odZhRXIEwXsiA9e6eHzSgdmbneRfKAl7z+1+kFupnakdaEq3nA
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 23:29:55.6428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86f04df-6d74-4524-bc29-08d59503d130
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3414
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151284000328035?=
X-GMAIL-MSGID: =?utf-8?q?1596226064888501838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 05:51 PM, Yong Deng wrote:
> This patchset add initial support for Allwinner V3s CSI.
> 
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patchset implement a v4l2 framework driver and add a binding
> documentation for it.
> 
> Currently, the driver only support the parallel interface. And has been
> tested with a BT1120 signal which generating from FPGA. The following
> fetures are not support with this patchset:
>    - ISP
>    - MIPI-CSI2
>    - Master clock for camera sensor
>    - Power regulator for the front end IC
> 

Hi Yong,

Thanks so much, this driver is a great contribution!

Unfortunately the board I'm working with (nanopi neo air) uses the MIPI 
CSI-2 CSI0 interface rather than CSI1. Do you have any plans to support 
the MIPI CSI-2 interface at some point? If not, do you know the scope of 
what would be involved?
