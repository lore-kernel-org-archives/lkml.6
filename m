Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeDRHcD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:32:03 -0400
Received: from mail-he1eur01on0135.outbound.protection.outlook.com ([104.47.0.135]:61760
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753133AbeDRHcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:32:00 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v2 2/6] dt-bindings: display: atmel: optional
 video-interface of endpoints
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-3-peda@axentia.se> <20180418091658.690e3d5e@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ffa56109-db0a-5619-2214-d163a2a42ef6@axentia.se>
Date: Wed, 18 Apr 2018 09:31:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418091658.690e3d5e@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM6PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:209:15::36) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:3iIVf7PE5HfT3kqbh3ZzSMc81jT6TH2GwClQGf4pAUK9kOMB2OwbiMaZDEJzGo1BrIa3OuyWULCgYZnIDLvPGssvsoEafnDfZodZKnS3QJUJsIcfS5lIm6WZHGWQN+x3/jt51wr6JxIln0+JopSXC+jXGEOGgn5mj2OHSywBt8BwUhJvBQMKzhKYO756AtDTGyXyUEAhL9B+E6NeRNCEkyPM0DSX5efc1qCo+0Vqgh12EVDVc335yVXhjlun9MOL;25:NxQCmXwK1Rbuouh2uUXB5Ndw1ypQt2KnPOekdBNiOxqgsVY30SDYkweBGLEr4tBe9HTD1hkTXPbxO66H88kWnvgk53/rpOSd5LTUpCsTYZ8IyVcR5RXx4M4wI5pm+bNu0wbF3Xj8Lw+n/cHykrB8igvDYwVDzUcEZrxeqypDenXD9cgbo71tfcmqzkuObJIjg7yH1rjD6N+vsB2IPBZIf1V9+OLnPrlloqcr8jqv9q6B0GrluPgPFahXi1Uh2sK7An95FSB2jZAFsLkm0yVhyTTlhSgKby7+E0lgqnJK1XCuk0NXMSogIXPV4pToxmml7o2v3dXOjWKgpoe7Ml/A2g==;31:bfczNFU+rvLE3ZfcvKx/HKUVU8/ppx6mhccOLBivxrml3zXa+nMsuIs3SPwllKX9mTzm44zdpTcE//zglbVJvq3/FIDIhOfG7QgUDEQGscdhF384fZsL4YcnICWQDvYCWVPZzfojiOWuq4f19zZyOfibuxzA4IMHaso+0eVX+8TTagFqd61YGIzJd3WgvFpQYRRsifj637sKEHeNl9lkHXZLMf8vfE2ElUMzgbl76Co=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770C18F2927DF765F59C194BCB60@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:D2aZHMLW8ANaBzsp23UxMgApCipvGJNbZg1+c5qp9S6Y8L6evSxnnT33BpuQcpz73Xq6Xh9SwVJ7SK9IgYRWuDZt3MUqz+SRnBvDXXpLM60rwrj2+q/68M830/uRQUXUBYBVR4Ptq2USgUb9HQckGcNUW3rtgMFEqpp35i2cKC7d0niTdmAxWv3WQDqHuTKEhzxkRAUez4ByOy/wnubbnh1Zv0gYH8BvVAuffy6mOPIgsR2tgprRLazb0rgEZe5syaXDCNcL4vxov7i8SjkWQw==
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(376002)(396003)(366004)(377424004)(31696002)(11346002)(5660300001)(2616005)(230700001)(956004)(446003)(23676004)(52146003)(47776003)(77096007)(316002)(53936002)(3260700006)(66066001)(386003)(7416002)(36916002)(2486003)(25786009)(6666003)(54906003)(4326008)(6116002)(2906002)(476003)(3846002)(6916009)(305945005)(26005)(86362001)(65826007)(6486002)(58126008)(74482002)(36756003)(53546011)(8936002)(478600001)(8676002)(16576012)(81166006)(117156002)(59450400001)(6246003)(186003)(16526019)(31686004)(50466002)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6OUt1L1kzMUh2TEVuYnRueHdpTFVjM2xL?=
 =?utf-8?B?WFBXd1pBYWJmc1JKakQ1ZUZJeFMwTitGK01EK0U4NVA3SGxzejR5bWdGWlJM?=
 =?utf-8?B?WnpXeWdFVHR6cVVWYzJVRnNYU2l2OE1xOFR2cnRzWExKWnNUWWtUUHh2RG5s?=
 =?utf-8?B?K2NFQUprR2pMZjEyOFVlTWQ0NkF3U2czSWlEdnUyb2E2RDhvYTNpYitCRUdn?=
 =?utf-8?B?a3Q1WHAwWVZjWDhDSVNaaVYzb3ZkN2JDM2U0ZWtQVVE5Tm14TjV2TGsyMitm?=
 =?utf-8?B?T0xFRlZTZzN4b28rOGlHRWovRjBTWThlVFhrendTOWwxWnJha2k0eENwai83?=
 =?utf-8?B?VEd4MTh3MDZhWmJhZnBTdW1IRUo3M2E0U2g3ZVIyd2VUZ3ZnVk1CRGhEVUdz?=
 =?utf-8?B?b1pBcVo2V04xRDNIdUJ0TjFUUkZSbTVpNWxyKzRiUXNxaXJmVFZsMWgzTks2?=
 =?utf-8?B?aEs0QnRkcW1wZFJnb29ibWlLU0EyM0o3NmNaSEdkcHE4WGR4TjdIUE84Y3JU?=
 =?utf-8?B?cFZCNU1TbkFneHE0K1RWaXRZY0pyVlRjRGQ2bGxZYXpmNTFEdzNhL3BHZXlX?=
 =?utf-8?B?M0tEZDBtZU0rbkZmanY4T1BoY2dFY21hZVFtSlpwS0luazhNUHFYVnRjYXpR?=
 =?utf-8?B?aUNpZldVVVR0NnhIV2JsQ1pnQXcyeEZLZklGRXEwR3M2cnZ1d0JlRmNjd1U3?=
 =?utf-8?B?Znk1cHpxS2E2UlBpTVN1ZXJ6ZGZ4OGl3LzFWMXdUTXQreU9KSUwxS2tVb3lH?=
 =?utf-8?B?RTMvaEI4VlFRWklvYS9jT3gyOUp3MjRtVzBEeGpyN1VEQ0tZeHE1di9HWDM2?=
 =?utf-8?B?blhNS0RpOWdoUUxKYllXYVdXMFhMR253QXRpVnludk1yK0ZqUWhNRkp3ejh4?=
 =?utf-8?B?OW1lUzFqUkJMbzhDM09udm9XeEdpbUVYa1MvUFFMNzVzbCtLZllvNmwzbVYw?=
 =?utf-8?B?MGFqWW4rZndpSWpHMy9lSGFwVkxqSDQ4bFIvQmFDY0xhbXIxbG45UFBpTVFs?=
 =?utf-8?B?dGl5NFc5ZEtJU0dqUU1MOEVhdmJYaGZOb1JGRHMzWHBubUN5QnlLZFBxd3pD?=
 =?utf-8?B?aFR2a09yKzJXcWJvcEVtdFBLdTllQm5ON3g3TEcxbC9lUzg5aTQwWFVzdmZL?=
 =?utf-8?B?Tzg2L0pmMzk1ckFadHVYaVczZnR0Z05oc1k0eEppU3FLK1RmeVNsOVVCUkZZ?=
 =?utf-8?B?cFVsMmhWODhROGV4S1YxOG14bWhZREdZY2lvYlBNNkNhWUY2WWhsd2JsNEtL?=
 =?utf-8?B?SlVuR0JyR2xVbkc2QU40dy84Tk1DNUhlVHNtY21DKzVLTGMzS2FmUnVVVTV5?=
 =?utf-8?B?ZmVBaTF2Q0VmSHk2TDduZURQMjVtSUhTNGRIUDFmTWhrWU85UHN5ZWZCMmVU?=
 =?utf-8?B?RU5TWnpNWFd5NG53UWJPZEY5Sm03ajYzSHd1dy9XazBPOUxlRmdUTmFsdFJ4?=
 =?utf-8?B?MkxrSEhBQWx5N0RyM3JySjIxQlB6NVNFWWVkVEE1L1J5MlJxOFAvbTJKbDRm?=
 =?utf-8?B?V3Y5R29jTk1IVWZmNGtEaWgrVjhNekxrY2IxcWpsQjFNc2Z2bVNla1F4bEUr?=
 =?utf-8?B?dWp4WnNrNWZGVWRLV0ZNblZJZEN4OEN6akFkVGcwdWFicE1FTEhyampEeHgw?=
 =?utf-8?B?ajFxMS9sNGhKRVAyYjNMd3Y4Z2MvL2k1K2tVS1hEZUlpS3lxckhpVWhhL0hu?=
 =?utf-8?B?eFdXeW9tUEsvQ3M2ak5iL3pYclRkSzZ2cTVPZUlJS29kUXZLMzV1aTZ6OUQ5?=
 =?utf-8?Q?zboF+P6dqUadyCINb9u9H96LkV6usBi4KTXjeuM=3D?=
X-Microsoft-Antispam-Message-Info: guGbiNJdNVKXIdnIiqHSLAUF8zvv86kwygyIluDd10/fYHZ36JA6p0LgD2rQu/euj0vHHTHluH95esRCyLocnrcCGlgCc68FvNOAvBevwBiTiqGGfe4xTqYU8SjHkxiYZY/XhW64507q9XgIEImNB/NUYbFhfIYFCR9iMfzTQlHSylAm67ctwyxP/KgtTg+x
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:aovkvlzp1ILLS9sQp0qvgY/FW6M3xTYXfUE4j02T+iH8UwNRLgyJBGSOQFG1JqHO8PFZi33s7Y5OIUnWB/S4Ll9ZgdILzZhhElblN7/HCQ0XMrmLlfOPSgHd9oJ7GYG54wmFUligHZlNQqtadTqNPTdbccS0Wlu1TVtUzsZ9pYWp+aqEViN7lyPY7f0mGpDmlXcvFnD5RcNXfprUqcyscIIk7Yg14YWUykgMv6TCww3w/c042P+ZAQP255xckYEGeuL2s5Ov0LS0ucRsHNk/mGqWquKf/m6MpaXCPIZ+rzBQUg55rz2tqGoLU6KJ7mmWXQfdQVZfiqHlaonrPRCb5CuHr7p7P3F+6YH8eeq9gPyctojx+VcZJy5AgHqg3wJrJMbaE+K5iOK6LamQeYj6RdLIYnnAfWTF9nGpqJYW5E9kD6G14RdtJsAmxcGv5kXPO2TTg8c011MPl2RfhzLhiQ==;5:zCRLMc/kuuhnJDAY8yg5an0JNEACuN9qGF9eQd4ptofuMQkx8P97ano3zxZMws5lxcC6rZXg/waa0wWoGf7OEE581ErIQ+9VHUzypn6RYsEr5msSwBwYCfRjF8PUqv5uznQSxoX41jCw23jcwuCrjameqfHYCySbfXPS6y5q5xo=;24:51050+iXASvkyUXzrJQMjuCHo8h1Qcd5BlIJQBjjVYPus6Fu1irYSjrLBmmaTmb3ahh7SkYEYJUFiYHHa3zzCZAO/k2FyvmLuDkmfSsYIWQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:HBdD63J9RzTaynlojudVGdmihza+uY8X1pJ/O6sQjPf4Zh/r7cq6RTsB+FhkcmvANkX5fg7U9NzZX1Pp7XCTd70D4TRqvIVOxEyaubkKRhjQN3jJa9OEN4lYYet8mgstvyN3A0MhzKMNBBNDjAzaQDlhOmhpw7kJGTq0ZzafAzp79yqAikI67xiA79LlTtUFK1DUgn1ZQ3UIwh4/yyrMN3cuZhd6Xi7W0yhEYGzdai8cz1PUyAXKnvQiZAe9tpv6
X-MS-Office365-Filtering-Correlation-Id: 098a5776-e36e-4415-cfb6-08d5a4fe76f6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 07:31:56.0882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098a5776-e36e-4415-cfb6-08d5a4fe76f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 09:16, Boris Brezillon wrote:
> Hi Peter,
> 
> On Tue, 17 Apr 2018 15:10:48 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> With bus-type/bus-width properties in the endpoint nodes, the video-
>> interface of the connection can be specified for cases where the
>> heuristic fails to select the correct output mode. This can happen
>> e.g. if not all RGB pins are routed on the PCB; the driver has no
>> way of knowing this, and needs to be told explicitly.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> index 82f2acb3d374..244b48869eb4 100644
>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> @@ -15,6 +15,14 @@ Required children nodes:
>>   to external devices using the OF graph reprensentation (see ../graph.txt).
>>   At least one port node is required.
>>  
>> +Optional properties in grandchild nodes:
>> + Any endpoint grandchild node may specify a desired video interface
>> + according to ../../media/video-interfaces.txt, specifically
>> + - bus-type: must be <0>.
>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
>> +   override any output mode selection hueristic, forcing "rgb444",

heuristic, I'll fix that for v3, so please review as if it wasn't there...

>> +   "rgb565", "rgb666" and "rgb888" respectively.
>> +
> 
> Can you add an example or update the existing one to show how this
> should be defined?

For v3, I'll extend the binding with this after the preexisting example:

------------------8<-----------------
Example 2: With a video interface override to force rgb565, as above
but with these changes/additions:

&hlcdc {
	hlcdc-display-controller {
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;

		port@0 {
			hlcdc_panel_output: endpoint@0 {
				bus-type = <0>;
				bus-width = <16>;
			};
		};
	};
};
------------------8<-----------------

Is that a good plan, or should I perhaps duplicate the whole example?

Cheers,
Peter


>>  Example:
>>  
>>  	hlcdc: hlcdc@f0030000 {
> 
> 
> Thanks,
> 
> Boris
> 
