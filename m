Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeDIHES (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:04:18 -0400
Received: from mail-eopbgr40120.outbound.protection.outlook.com ([40.107.4.120]:7137
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751650AbeDIHEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:04:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 0/5] allow override of bus format in bridges
From: Peter Rosin <peda@axentia.se>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180326212447.7380-1-peda@axentia.se>
 <2233231.my6BbD3pcT@avalon>
 <CAKMK7uH-=BqU+vuePTq4joY3XS2ypvtSKYvpv1LLyovPpSXv6A@mail.gmail.com>
 <1563250.XEJxFDuW0h@avalon> <9af25e5a-7334-b07c-ff49-46530df6b1aa@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8bba78e3-ed61-4648-d4a4-5d12dd9ef11d@axentia.se>
Date: Mon, 9 Apr 2018 09:04:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9af25e5a-7334-b07c-ff49-46530df6b1aa@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::48) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6df9e3a-fe8e-42fa-44f1-08d59de81817
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:QbEQpDa/Z8Rjqvm701G2O4SJ1KRt3qL5yZACcurO2Les/SOPIF+sSJ83+ZriSX0Vd48/F8xJEH/MB3gIRJST33rdtimrNe61Nm8/9DpbGLT+mUWNJQ0FWI+b3IDXGcWeor1CiQdJFvc4aUNwomyG9+uJ9ji5JEuDBzY+YB2Y2gvdqRzfOzw1xVr6p0Ctu1WpVpzzT53bsMxsYP9ecKU9rCwfaDdg6D9eWahvcETM5XSVNRh8/B9WtufRXeFxxeAm;25:hD2aPCbw4Q8dF56B5ayJoHLYVB7byjS1nZ8hPxsgi8RG1ryhlLVD/ts51AIS71fadTxPvsGXHqxCd3/Fu/mebk6fCLjgJeWJRT4nDeUZiaeG0Kq/CEG60j7X+6NQAXrJXplhTkuBBkFNcq9l9PkXuMs9ag2L9XdwD4FWa1aYHZzh1ioU0JhQa5drsBBVBa1d9/D52CWnUpv0MYfNKPj4ArzlKmyv3ngd/SNvdSp+AMum5JtBIX5cTRUyfTuZ5SuGjAETROJtnNJhQ2bpEoBVl7QDNunsq9rVa+TdgxywJPQHiB3lgmHkkaOIA7vb10LNl+FL71HDTVW14dkuxJfYLQ==;31:/HD1fP3+leBsqWig5gOMTmMdI852t/REhQP5bkjgARk9koACQOLWY1PrTHD8mvZxL5qYuzHA6RMLK7SK7Vuuo2wd7FzxEyfDV7FcmFS4Zy0D7JUhmuXhbISpsdZ1Khh//gX+yxlsLhAhx7aU9+VbeCeu9ALB1HQzgCE9rE8nhJyu5D32P8vVaMt8QT9a5+UJR5mhtbp7Aqf77D7Mje3Vfxw6zl/ofwdsr+O/ADUMtJQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278257C05B752C8E31382192BCBF0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:ZJRKYL0vJN8W7W7pRijqecaCt8BWiU3Q15jADYfZ142S6cL38TArfhKi8WAHHS4ll4E31ru3BLhmwp5KUnjPBqU7LgeSnUqkPPtBVMHXidDVDVlV8HHKv3b2SI6cMhuROuKQvsEcjztfjf+mW0fQGzN4T1FbxlSGuvrvlJnWogli6g5vcEpKVBKRatYnDJKx2arybMKZP4Wrik2RSjCpuU9Xd/HicGgtHtZSsqwK4M4jKg/lf8097mCdxgTnYJWxdQQsFWVCc5+BwGTPHAKqcw==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(396003)(376002)(39830400003)(39380400002)(51444003)(377424004)(189003)(199004)(77096007)(386003)(97736004)(68736007)(26005)(2906002)(65806001)(65956001)(66066001)(31686004)(4326008)(2616005)(476003)(956004)(446003)(11346002)(486006)(47776003)(230700001)(478600001)(561944003)(186003)(25786009)(3846002)(6116002)(117156002)(105586002)(16526019)(3260700006)(106356001)(81166006)(65826007)(966005)(81156014)(8936002)(74482002)(8676002)(6666003)(54906003)(58126008)(16576012)(93886005)(5660300001)(36756003)(316002)(110136005)(7736002)(64126003)(7416002)(53936002)(6306002)(86362001)(53546011)(2486003)(50466002)(6246003)(31696002)(59450400001)(52116002)(229853002)(76176011)(52146003)(23676004)(36916002)(6486002)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6OE5YWVFMWHlSRWE5bFNCbkVwZXd4d1Zo?=
 =?utf-8?B?MGVGQjA5RjBYTHlMUFlobE1tYnpEV0IrOEpKVTcvUFBMdEIyZmJBWGpIOEpa?=
 =?utf-8?B?b1NXbUtkMUlFZFQvRlRyUERNWnBoaFRZZ3M2YTlsR2c3RUpPZUVPSUJ3NEd4?=
 =?utf-8?B?bVh1ZUs2eThra2s0cVBNMWt0cU95Qlc3aE1zSFZqVGlRQ0dmcUNraEJ4bHRP?=
 =?utf-8?B?MElqSGJBM2t0SEs5WEl0SUNMYVJqcjNxK3VKSXZqTGIvUnFXRzZFdGQ3Mjdq?=
 =?utf-8?B?NDFPZ1VTRzN1VTNJc05DYm1hSklUdW5KcGdzVkJBWmJvRW9ZSkZiWG9tY1FD?=
 =?utf-8?B?eUZBNjlwc1dOVVRBcTFQSnBVZHUxc0F0Vi9EWWc3TVJvY3JOL1REUnMyWnRW?=
 =?utf-8?B?UFFlT0dmK1J1MkN1S29BZmhCVGo1QWdoaGJIMnM3UjBpY0UvKzVFNjRmaUk0?=
 =?utf-8?B?cnhjUU5kZUFwRi9Jb1IxVlVzWnkweG4yanpQeWIyeHhJcmhGeTRQeU5xYkdz?=
 =?utf-8?B?Y1N2dkJGVmpjb1RUSHZZdEsyRnR2QzZJaCs3eUo3VkxUWXFoODYrelZ4bWxT?=
 =?utf-8?B?MFVlWXR4bUNNM2pZaDhBOU5SSjJNMVNWMDNTZ0RWVzNZTTkrVnVXS3FpWHUv?=
 =?utf-8?B?VnJPeXZVaHc4RlEzWlh0R2U1WURrQnlnVEVvRjl5MVZLSWY1cThzdGNNWVRt?=
 =?utf-8?B?blJOUUpZKzZTRmhJTWNzd0h2ZzE3dlRhNVpublY2WHBlZFhFNVM3aEJTaDNi?=
 =?utf-8?B?c2VNZmxXS1lVa25oUExNNVIwcHZKMm9JOExvbHlXYnJuUDNSVnFBRUhiMUVy?=
 =?utf-8?B?YzhWdmV0ZWN1UjZCd09kSkdWMWRCUElQd1R5OE5UY0FIRFJYZm9zUDJTaFVX?=
 =?utf-8?B?cmpzNS9uU1JSVG1abllsZWpPNll5RjRKWnI2L1cwcXVjTnlETldOWmxOTU1s?=
 =?utf-8?B?dlVBb1R3ZUpwZXNvVFlsN1NBUU9oKzNWZlA1YlhwYkxNL2g5akxnVVVCY1dr?=
 =?utf-8?B?R29JeG1vZXdXcVIyZDVPdlI4cDlDUjBORzJxRVpVcmo0MERiY3QxaitNb3U4?=
 =?utf-8?B?cnFKRkc0Q3hXNkFJRm80Nk11eGx2NTB3RTJGcTlvWkMzRmNWajdLdG5GelhU?=
 =?utf-8?B?aWpiTElaUG5lZENOOXZJUi9IcHhxZWRzT1E1Ynd5WUFiNXRTb1AxOXF0Lzhj?=
 =?utf-8?B?YllPWk43UXlNR1pCb1FOUFBZUjJXTGJTSmMxMVBaYU5rTGRUaFNlSkxybm1h?=
 =?utf-8?B?NDV5YXI0WEo3TW1pM1djNk5IWXd3bUVzUHZ0c3RHbzBVUjNxWVovSG1lNjZI?=
 =?utf-8?B?TUNFdnBZbHdHcVp5ZE43elRTZWxTcmNiTUM5UjBDOU1VbStsUzhrS3RIRmFz?=
 =?utf-8?B?Q1pyb3NLeUJCT2VzL1ROUUpVeFBDb2RMYzRIeHpkb1NwL3FON2pxbzYxamE5?=
 =?utf-8?B?V3NiM0MvNkxvVFgxc0EvcmVmNkdRdHphTEJIQmZ0UUdpbk93OWdOTGlYN3kx?=
 =?utf-8?B?OFltRGNBc2Z6cTE3ZndMNTNDWjNDbDRZU3ZMRWpPai81cFFpVkVsMHRxUmlq?=
 =?utf-8?B?YlA5UHRhS00rMzh1YjhUYTU4amEyMXJ4S002VHNIVmJXaXRwRzBKemxweE5I?=
 =?utf-8?B?anRmb1J3N3c4MVB3VDNRTG4yYVg4Ynd0QVZTWXM3VlZnYlFEOFp2U3hpMHpK?=
 =?utf-8?B?TmEwQ1lIcnphV043Y01uVjFlcWtQSDVpbCt0aGU5UW9Ib2t5N2VaU3Y4cFJV?=
 =?utf-8?B?VTJ1VUh3L0JrTGx3Vm5hL2xqSVJsUUROcHFiNjRKdnFwbncrS3ZBcUp0NERG?=
 =?utf-8?B?RDZNeHpBWHZucmVObElOK0Jac0tvMVkvTlF2anI4eHVVSTlKM1dEZ09LK3Ru?=
 =?utf-8?B?T2NCbGt3bW9NcEJEOWFidU5paVVMcCtSOWF0bmlNZG1ZdEI4MUk3SnFmUmhx?=
 =?utf-8?B?ME5Pd1BLeVgyMVZnOHAraTBwUlJkVUVnbE5oaDNTWmRuejMyTVgxYmIxYmhP?=
 =?utf-8?B?cldpWGhadnpIeGg4SVlwWFd1RFVNSitPdDhlWklKVVBkOW5USHo3dGIyTjgw?=
 =?utf-8?B?RWszWHBVdjNVUDJyUlBmSUlYRmJheC9NZ25zNjB1Lytac1B4dm80djBPVEY5?=
 =?utf-8?B?UmlFSzhDWUdYcDZIb2JKaWtVSW40WXFGKytMV2FqeXpsc2ZTREhGdTFMclRp?=
 =?utf-8?B?SXlITFgwbWl2MkRqMmdnLzJoNzJVOFVFYmxIeGNqMHhoQUhwS1JBK1pLczdO?=
 =?utf-8?B?anVRQmg5TWkzNTJRV3E2Y1dlWllHdDdpNXpBNzRlSWk3U09md1l1UFBCVG5q?=
 =?utf-8?Q?TQyrDVskUDFXAu6RASjATjUCGgVspmwIJQFtCtk?=
X-Microsoft-Antispam-Message-Info: dQgvrSOamw/eicjPHtLZxHsMUDwxHtTkHXOLkfLEOFSgB076WzpzKRD2Jxtsm0KM0zHeHSQDd9/n7OpO1hlYsj7yhtn/UAHtGQ5wsQsBw2SXmOUJ0HtOtZBj9fOQSdjEi3422Pm5IcrusUjmeLvO3wFCyu1mjvna5a6UFPl4fi0LpgFMOwIpXMiQmot47E3y
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:bHk2eRDA3KyNv/epXU665rcqbEmfEYTWFAMXwZcXo2qk/YPZNy9mhb7aRO/rIqOb2hTUEh5F8ZIaoGZ/Oe0zPqM/JLSZ+aFDnAo4d/vrVT0hqya8YEvKme5NKMMwU1lS/bnSzxrbxBL+cA1H44Jl6hJr8Ap/z4tDdLLKmtWWWCLOsHoNQNEY7u0vmue/xlZiHbB8ep5z7M0elFMvQLWDVObmnGKL4tqz3SCVVju6ZTbNUjbBHOD+z8q91AHUb1DcEawDWeTPp+Ad/vUWYQoiE1CiXAB8Qo2h5rjm8MBfOTL4nuM4RE+uE6br8IJW9F8n4OCdQ62LHDHGAALkWYXVtnh4X7Dbhw1ZRfbev6I3NuXevsd9ENDc8aMX7lVG8ThtORVQUieHxNOr8NovWvPb0H7AAqFuK2RBae9gP54yxdiWeLLu7Z9CW/v+A11K/8mEkY1yQsw0MFwDURbT1CTOSw==;5:dMIjR+GALmViS+uP2CoYD5jVkubn5mM2KK3JVgFtLUmLQ5mgNVf9V+Q34rUbbWcmA5mGzXp9wPxmQ89cMXrRsEziO0OTHgZcLKryTkJwCzB9bO9ynGbcc0rCiZcaGoZE52+u9HC9BzUJ8z0HMJsgBB27ok22vFjF7BUNSGQDVGk=;24:ZqGmJLZBjgb8YjI6CTME5O8MbGN/o71/Q+3sMflGDpo2o0EBF25NMkvfMlt8rmuT9dCFxhiDa+ze8SvPvBZWbY1mnY/ITEnH8+rYecHrwiI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:WAvBSh+jJzIicjKLKXjZNz8zJ7rfhUngqejFB/lJMR27LHNt9y9eWNhGzjc5hrUf+R8miib3VKGiCiuGVw7bIOnEJhFdiYC3McBYPqsiQHWYEj/0nE0ImF0Cu/L07bX+tCxLZqIekXhVfBbjkbG/R4EACbI9aKonmBdq1OyR5WjiKB1Kf9aySiu5RsbjayUKSr9t/uRiUpYdOvMu/lWi3IbpodAdwjn+VOra6H2zrhLLczHZk4oaE5UodSznhXg5
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 07:04:09.3382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6df9e3a-fe8e-42fa-44f1-08d59de81817
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 14:35, Peter Rosin wrote:
> On 2018-04-04 11:07, Laurent Pinchart wrote:
>> Hi Daniel,
>>
>> On Wednesday, 4 April 2018 09:34:41 EEST Daniel Vetter wrote:
>>> On Wed, Apr 4, 2018 at 12:28 AM, Laurent Pinchart wrote:
>>>> On Wednesday, 28 March 2018 10:08:26 EEST Daniel Vetter wrote:
>>>>> On Mon, Mar 26, 2018 at 11:24:42PM +0200, Peter Rosin wrote:
>>>>>> Hi!
>>>>>>
>>>>>> [I got to v2 sooner than expected]
>>>>>>
>>>>>> I have an Atmel sama5d31 hooked up to an lvds encoder and then
>>>>>> on to an lvds panel. Which seems like something that has been
>>>>>> done one or two times before...
>>>>>>
>>>>>> The problem is that the bus_format of the SoC and the panel do
>>>>>> not agree. The SoC driver (atmel-hlcdc) can handle the
>>>>>> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
>>>>>> wired for the rgb565 case. The lvds encoder supports rgb888 on
>>>>>> its input side with the LSB wires for each color simply pulled
>>>>>> down internally in the encoder in my case which means that the
>>>>>> rgb565 bus_format is the format that works best. And the panel
>>>>>> is expecting lvds (vesa-24), which is what the encoder outputs.
>>>>>>
>>>>>> The reason I "blame" the bus_format of the drm_connector is that
>>>>>> with the below DT snippet, things do not work *exactly* due to
>>>>>> that. At least, it starts to work if I hack the panel-lvds driver
>>>>>> to report the rgb565 bus_format instead of vesa-24.
>>>>>>
>>>>>>     panel: panel {
>>>>>>             compatible = "panel-lvds";
>>>>>>             
>>>>>>             width-mm = <304>;
>>>>>>             height-mm = <228;
>>>>>>             
>>>>>>             data-mapping = "vesa-24";
>>>>>>             
>>>>>>             panel-timing {
>>>>>>                     // 1024x768 @ 60Hz (typical)
>>>>>>                     clock-frequency = <52140000 65000000 71100000>;
>>>>>>                     hactive = <1024>;
>>>>>>                     vactive = <768>;
>>>>>>                     hfront-porch = <48 88 88>;
>>>>>>                     hback-porch = <96 168 168>;
>>>>>>                     hsync-len = <32 64 64>;
>>>>>>                     vfront-porch = <8 13 14>;
>>>>>>                     vback-porch = <8 13 14>;
>>>>>>                     vsync-len = <8 12 14>;
>>>>>>             };
>>>>>>             
>>>>>>             port {
>>>>>>                     panel_input: endpoint {
>>>>>>                             remote-endpoint = <&lvds_encoder_output>;
>>>>>>                     };
>>>>>>             };
>>>>>>     };
>>>>>>     
>>>>>>     lvds-encoder {
>>>>>>             compatible = "ti,ds90c185", "lvds-encoder";
>>>>>>             
>>>>>>             ports {
>>>>>>                     #address-cells = <1>;
>>>>>>                     #size-cells = <0>;
>>>>>>                     
>>>>>>                     port@0 {
>>>>>>                             reg = <0>;
>>>>>>                             
>>>>>>                             lvds_encoder_input: endpoint {
>>>>>>                                     remote-endpoint = <&hlcdc_output>;
>>>>>>                             };
>>>>>>                     };
>>>>>>                     
>>>>>>                     port@1 {
>>>>>>                             reg = <1>;
>>>>>>                             
>>>>>>                             lvds_encoder_output: endpoint {
>>>>>>                                     remote-endpoint = <&panel_input>;
>>>>>>                             };
>>>>>>                     };
>>>>>>             };
>>>>>>     };
>>>>>>
>>>>>> But, instead of perverting the panel-lvds driver with support
>>>>>> for a totally fake non-lvds bus_format, I intruduce an API that allows
>>>>>> display controller drivers to query the required bus_format of any
>>>>>> intermediate bridges, and match up with that instead of the formats
>>>>>> given by the drm_connector. I trigger this with this addition to the
>>>>>>
>>>>>> lvds-encoder DT node:
>>>>>>             interface-pix-fmt = "rgb565";
>>>>>>
>>>>>> Naming is hard though, so I'm not sure if that's good?
>>>>>>
>>>>>> I threw in the first patch, since that is the actual lvds encoder
>>>>>> I have in this case.
>>>>>>
>>>>>> Suggestions welcome.
>>>>>
>>>>> Took a quick look, feels rather un-atomic. And there's beend discussing
>>>>> for other bridge related state that we might want to track (like the full
>>>>> adjusted_mode that might need to be adjusted at each stage in the chain).
>>>>> So here's my suggestions:
>>>>>
>>>>> - Add an optional per-bridge internal state struct using the support in
>>>>>   https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#handling-driver-> >>   private-state
>>>>>
>>>>>   Yes it says "driver private", but since bridge is just helper stuff
>>>>>   that's all included. "driver private" == "not exposed as uapi" here.
>>>>>   Include all the usual convenience wrappers to get at the state for a
>>>>>   bridge.
>>>>>
>>>>> - Then stuff your bus_format into that new drm_bridge_state struct.
>>>>>
>>>>> - Add a new bridge callback atomic_check, which gets that bridge state as
>>>>>   parameter (similar to all the other atomic_check functions).
>>>>>
>>>>> This way we can even handle the bus_format dynamically, through the
>>>>> atomic framework your bridge's atomic_check callback can look at the
>>>>> entire atomic state (both up and down the chain if needed), it all neatly
>>>>> fits into atomic overall and it's much easier to extend.
>>>>
>>>> While I think we'll eventually need bridge states, I don't think that's
>>>> need yet. The bus formats reported by this patch series are static. We're
>>>> not talking about the currently configured format for a bridge, but about
>>>> the list of supported formats. This is similar to the bus_formats field
>>>> present in the drm_display_info structure. There is thus in my opinion no
>>>> need to interface this with atomic until we need to track the current
>>>> format (and I think that will indeed happen at some point, but I don't
>>>> think Peter needs this feature for now). That's why I've told Peter that
>>>> I would like a bridge API to report the information and haven't requested
>>>> a state-based implementation.
>>>
>>> If it's static, why a dynamic callback? Just add it to struct
>>> drm_bridge, require it's filled out before registering the bridge,
>>> done.
>>
>> If I remember correctly I mentioned both options in my initial proposal, 
>> without a personal preference. A new field in struct drm_bridge would 
>> certainly work for me.
> 
> You did. Ok, so v3 coming up...

Nope, v3 is not coming up. This feels like an impossible mission for me, as
this changes core DRM design, and it would just be too much of a time sink for
me. Besides, the final paragraph of the nice long "state of bridges"-mail from
Laurent, i.e.

On 2018-04-04 15:07, Laurent Pinchart wrote:
> Finally, still regarding Peter's case, the decision to output RGB565 instead 
> of RGB888 (which the LVDS encoder expects) is due to PCB routing between the 
> display controller and the LVDS encoder. This isn't a property of the LVDS 
> encoder or the display controller, but of their hardware connection. This 
> patch series uses a DT property in the LVDS encoder DT node to convey that 
> information, but wouldn't it be equally correct (or incorrect :-)) to instead 
> use a DT property in the display controller DT node ?

hints at where I'm going. The reason is that I have a patch (that needs some
polish, will post soon) that makes the atmel-hlcdc driver use components in
order to hook it with the tda998x driver (an hdmi encoder), and there too
I need the atmel-hlcdc driver to use rgb565 output. And in that case there
are no bridges involved, so the proposed solution in this series has zero
hope of being adequate. It simply seems that forcing the output mode in the
atmel-hlcdc driver is what fixes the root cause.

End result; the only thing that survives this series is the interesting
discussion and patch 1/5. But I will include that patch in the alternative
solution, so you can drop this series entirely...

Cheers,
Peter
