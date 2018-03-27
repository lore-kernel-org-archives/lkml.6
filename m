Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeC0M5K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:57:10 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:11072
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeC0M5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:57:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 4/5] drm: bridge: lvds-encoder: allow specifying the
 input bus format
To: jacopo mondi <jacopo@jmondi.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-5-peda@axentia.se> <20180327102741.GN27746@w540>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e2e4f914-b301-d6ea-3807-05c58849771f@axentia.se>
Date: Tue, 27 Mar 2018 14:56:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327102741.GN27746@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::21) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52dc344a-c7ee-441a-a15d-08d593e23c41
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:qAF2WqyWuVGkjNxtkam+gZBp7j3pbuCvH2P8ZXlBAbKygYp1ENf4Hsc8Mf6nIhRQRvrCaIpOBPEohBGwZqEMi6ldptzV5qtqmeNCkbN+jf8VlSc838RGyk9U1b4XpeVeWGuPz+cs+0awqKWxUlmRrSf1rOEE+BVxaJwTe20z+Cxl8IGvn1hEVJcWuJFULu6+uNuH4GUOL5piJehX9GscHDk/lolS/Gh6nlzmmPmeNJp6TUALKRh8TXbCqYfsd6dR;25:FitGduDMDWo7PnJ/b+JYzOHPo3LLrjkluGXcGVv/5Dz5D+nG1+TrPKn/Pyice5SBvzxnn0bS7uA3bGdx2c1vtMNegWCnETe0LOeIN4fZDe8rCRCC1gU8X2zeQTRegpreqUYCSjN609GXJMQ6l2DrHXieqquYHv7rxIdCjXqHU1wvI/iDKJK2scCct6urSKjWhsRlxJLmorS+zAEeK3fnousfQcCuoHdXUGEguYmJTivWRB9wVLIs9BpidseIjtXBZfo2fyCpOzaePUKt2lyrnexFrrkBBpIPCwXQJxbuDkbAtEqYEd5uHryLOsDzVSvuKOJlDda6fxgehGnhezuNjA==;31:Y++DfiIIRGione3o//FCPLQMqsoCH3Y02lkkzapJKL3HgTUa1T/ED8VYUzicIY0sobGJpbrPxf9U6aunL7A5qJlMk4WM88gI+TgwNbB0eSWLIx1H+qZUD1V8yl79GHMeA1b0pHjzQTbDDX1CAgEXEFDpGX4DVN8YlNUCCnWJYw4GFMoqZ0nA73Yy6CKqCRtGZPadnar3FhROVdarOTMahyd8zBjk8ysn9NIxWKr1V1U=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2780C67BADA26BC97833F4F9BCAC0@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:n1Sej9rUXRKMEVLYecnOR+IVriOUlhDHUf8KpjDMDhiPCt8czFgLyJbKS7su6kTBIpqncVWoPneB2yNwEjCqjH2cU8L282+53TC0cYR8MBN+OwHcmqQntIKS8Zv4ZE+lkc8ABsOIxcuCZQ/KqF8O1xSLOgWH22D+D3D7UitfcK5KPBDRTk9ryjP2HezrUF7JRzSyFKTI3Gq1m3Ck8foElIwpWRz2fYg2nwfSF0lWf2LS1iTXHUgGE+dgRAHe9FIZ7iufSN99ERBxzUnqgabaSw==
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39380400002)(39840400004)(366004)(396003)(51914003)(189003)(199004)(377424004)(4326008)(5660300001)(97736004)(31696002)(575784001)(6486002)(86362001)(11346002)(105586002)(6666003)(65806001)(47776003)(6116002)(52116002)(486005)(486005)(476003)(230700001)(23676004)(956004)(66066001)(16526019)(186003)(65956001)(2486003)(68736007)(36916002)(52146003)(36756003)(77096007)(3846002)(2616005)(59450400001)(81156014)(386003)(81166006)(106356001)(54906003)(64126003)(8676002)(65826007)(58126008)(305945005)(478600001)(16576012)(31686004)(53546011)(25786009)(3260700006)(229853002)(26005)(6246003)(74482002)(7736002)(76176011)(7416002)(6916009)(53936002)(50466002)(2906002)(5890100001)(446003)(316002)(117156002)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6d2hkc3VKQjA3dE5IdUxqZ3luR3N3UjVM?=
 =?utf-8?B?NDlIZnFvVHBhcEtJc1FSNXZiMUpuMld6MU9SYjZieDFoTjJNVVBOVmo5ZW4r?=
 =?utf-8?B?Tjh6Uks2RjZIV1FZeGhZLzFpMmg5c1pqVmJVVFEzanFRL2N0S0ZqUHpZL0hR?=
 =?utf-8?B?U2RyYnAyb2FMcTk0b01jWnNXWnI5eE5tby81YkNkM2xGbERrVW5panc4LzJT?=
 =?utf-8?B?ZVErTU5WVDAvN2VRU0w2eXFVWHlUVEx5d0Vkclo0L0Y1WVdnNXNqNmVSMkNa?=
 =?utf-8?B?VjBreXZPY1RoV28wOWxVMUk3RGhUY3dWdFlGYmw4K1RQci9EV1U1YkVnY0pZ?=
 =?utf-8?B?MHZmU0RLZzByZFBHMmVDbzZoWnpFeURUaFNPSWF5ZHdCcmRHSERiTlExY2pB?=
 =?utf-8?B?WjNmUm94c05KNk53TDExdXBNOCtUTGJwZmxrcW1zYlFXWEk4OXZDVVFpdjdv?=
 =?utf-8?B?a3RtRUsxVlc4NnIxd0FoSjBqRWJtRDN4TnN0L1R0VGtudnVDZTBpaVhTM2E1?=
 =?utf-8?B?RStOenAwUUpBMUZXM3Z4UWhudWJuV1JWaGdDdDFWVDhxZS9mNW9rQVhDVk1H?=
 =?utf-8?B?QVJXbEY4MzJ1TFNVR0NYQUozLy9JbFlLUGYyWlVKL25sY1NOaW1EbzFYN1Bx?=
 =?utf-8?B?cnlwYmcyNXZROWNMaVl6ZXhiRWxvK0h4cnBMN3FLdDM1WTI1T3oxc2JzcnBT?=
 =?utf-8?B?anNvdW1DdHlIZzZoWnM1Y0xJbWJMQmtiY1FScTIwOVZFRitlNVMzQUpEWVFn?=
 =?utf-8?B?WUNKcWpZZHlZZ1NXV1R4VVAxMWk2bGs4R2dQVlJFRWU2Z0VuTGtpZGl3M0pT?=
 =?utf-8?B?b25QcDBBNmQzRzVqQWlBM2NLaUZicmIrUFJsSTlQNlJKM3NWNjZLQ3N0dUlF?=
 =?utf-8?B?RzFuZVF2UkJNc2JLM3dIeVNDRlhXMkN0TWtqQklSUXJVRitjOXZDVm5QVzdN?=
 =?utf-8?B?ajZkMmVFdGFFMUNzcGFLZDlXdWcrSmdjZlZvbTRkRW5qUGJ3dXRoRW5QU2Nk?=
 =?utf-8?B?U2VwWlFnOHN3cGtUbUw1UXZKSVNSU2VlS3EwRnRqdE01OWtESjBncllaZG5O?=
 =?utf-8?B?SUw2NEdaZDk0KysvZDVIdlU0YWFDRnk2dnM0eTM4UXJycDh0dW9aSkJQRVFO?=
 =?utf-8?B?ODlLMTBJR3RvUXhuSDBQS084a3NnSGFQWHd1bDNyZm1mUTNBTG16WjJJenVh?=
 =?utf-8?B?RzFiOWUyOGNTbmtWbnBDMG9GSDlwMFBDVDBkU2VpSlVBQ2ozZjVaZjNMeHhP?=
 =?utf-8?B?cG1xcFpWWTBkbUVVbjd3OHpHU2xSZ2RXb1dUS21qV1RoaHZPR1JyQU9sN1JM?=
 =?utf-8?B?N002bmNUZEMyWUtEbTFjL1JPWVZpM1NkUHZZSVE5M3U4SVVHZk9idGplU0NO?=
 =?utf-8?B?NmRmRUgySnk5Y2NOU0RFc2x4YkY0UXF2VXlRRmFMTzRXK2ZJeGE2algyMGMz?=
 =?utf-8?B?K29EZVFlVWFZMlM5MGpSdHBGdlZ3WHpPNnpzb3JoTzdGL2ZNVzJXOFl3Y2hh?=
 =?utf-8?B?Rm1qQlZTaWc4bWMweDJ3T0hhYVpCblJnVUZrR3F0MTU4Z0dWTHNEdHZOSmg0?=
 =?utf-8?B?Z0taMEMzdUFOYllaVVg2NkJSSGdoR1hpaWJnWFFjTG9uV3o3UGhKWWNLNTl6?=
 =?utf-8?B?NmdpNmtlU0hZRDE2WVBwVkVLazk5eXBTa1E0bjJHVEh5dDdzd2w5N0lmc2Jw?=
 =?utf-8?B?c0JOSjNUOGhMMGxhbnUxN200MGNzR242cWYxSndmdzBnd09XM21CL2NjS09o?=
 =?utf-8?B?dUw3TmdiNjloWGQ0VlFUUm9PeC9zT3dZYU9RamdzVjdpNGFnaVFEOG1sN2l6?=
 =?utf-8?B?a25mc3pYZkI1SWloZ1lkSUVzS04rektMeFhpM2ZTejlVOGhQUmFFNGRkZzRP?=
 =?utf-8?B?K2FPZ3VnMXpTbWZTNS93b2sxYkdZT21TTnJIOTcrUUZ3ZHBFeDlkLy8xdzQw?=
 =?utf-8?B?VWZtTWRPT2F5eU8xRWgwUFJiSEpMMDFjVVNMYVZLZngwNXhWaFg4SWR3ZHVY?=
 =?utf-8?B?WlZoVmRSOUVTTDZpWnh3SmU5VkVYV2VmZms0V1Rvc01McDQxU1dYUnhpWXB4?=
 =?utf-8?B?RUF0RU1EVFBvOVFrSm5GVldoRkIzMDFaY2xFRGcvMW5admpTUEJiVDNaNysr?=
 =?utf-8?B?aGxPNGpRd0pMU0ZXVHk5NWdJWHN2eUpGM0hRbEhhSmtRdldiZ2lXMEw1Q1M4?=
 =?utf-8?B?N3FZanpjWVB4MUNqVGVIWnBnWEsxbGJMSHFMcHZnTEhsMUtRYUs2WkQ3eHhG?=
 =?utf-8?B?WG54aFFqT2d4VHozeTF3NjZnZnVtM24rR0tTNGJJbWdtajk5V3k4ZkdqeU8r?=
 =?utf-8?Q?UXny9CGpTUJ9GGhAUY=3D?=
X-Microsoft-Antispam-Message-Info: l7u59bLJVuLoSc3fFTLJel8BIghDmmOwNOiaC1AmM0PtOwJ2f/jU1/yeGlYbWwAkwZOdH5wIOTNELZx5Q9DK7sxd8dceSUPc7EOYd3P9s80SlPmXs3R0+4qOH2tfC9l71z51voFG+rnZ+P2MVav83lqSTTw7m0w1KQqrBPIgdENL7nX+QKZ5OgPln9eB8fvG
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:6zol2WcoIJe+bZK6u1CPm5FXI/NNQ037JyVebQCogGWtpSY8bVDRUAnFwhwDw/yMVeTV1by3ArLqWdNE6h1NIHcdqMrALFMK05aMx7ldztJBPgb4TKsdv9P5fGsrt8kGMR5L5RRNS6HvEJpGAlDWipXWmn4SWkQK5iOOjMhwNMccxLBZ3NXzQO6B3bl+PeAurVMTowfgeV6DiDhPjMmMAGI+eAw+UBsEqhcNF7ZtRh7LR2Kiv5EXAYsrcT6E0QF+11SKAQUVFRigRRnby07xcOOVp0imNKM3EP7vg3IMD7npJyksBAIIqSZp61ZhRnidAUgXUgJT3mYqIeCSS7QT2l2phgT1C+LCtCbEdMpDQHPtvLFbw4PkjCwLEo7J3Wgp9bk56WHXDPdcSl65SkJ3k5Oet6lnR8SUutDO1/YqtpKjWHd6aUuXGKemay5nyBYUK3sp91VJecFiltu6X7UmBw==;5:ab+kecGY7+UJhRpDySeCjRSpteSQqOObKL2MiZhWOhy5BQIUEuRzkvk/m8NxlmaOd5nYfA186OOy8S0JRV514A3Ey3gx7dXifkre0Jf75WyZ4tSUz8xB99dcWHaqC0u8z5i1+foQJCIFtIeGumzqA4a5rdQdZX/o0YmR1sjQ+LU=;24:oj7yj3WIzyLU5XN3JcTIqehFVuseSeNC71uABLzU8YcAUXQAGCYBYDbIn6BhGyqeW5Ywwlr/7MGXZxomP7nnkwhCHNGzaNhlEJRNqRvYi/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:8JzDhsbb/5gnOIJDL63agBt7T2CGNWcpSEtH4MipntVyITdMqafgdKr9VniJ53+MvPqPfJ7gFrLasTVOlBn1yyOakVOgAxat3VlEZpTr6c8M7ZXg+35pdZZu+zY2VZoKFXYltCD/Jo1EDjS9fkopcFz35QngzNjMHwDkJgdp95WLtO+2aAAW1QeBb6rqbFcD+WPyVjjovMzloGAawN08eALUGaqWT4efmP09a4qBkEN1+Fse6mEZ4bCoBXYhTgGH
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 12:57:02.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dc344a-c7ee-441a-a15d-08d593e23c41
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for you feedback!

On 2018-03-27 12:27, jacopo mondi wrote:
> Hi Peter, Laurent,
>    thanks for the patches,
> 
> On Mon, Mar 26, 2018 at 11:24:46PM +0200, Peter Rosin wrote:
>> If the bridge changes the bus format, allow this to be described in
>> the bridge, instead of providing false information about the bus
>> format of the connector or panel.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../bindings/display/bridge/lvds-transmitter.txt   |  6 ++++++
>>  drivers/gpu/drm/bridge/lvds-encoder.c              | 25 ++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
>> index 50220190c203..8d40a2069252 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
>> @@ -30,6 +30,12 @@ Required properties:
>>    device-specific version corresponding to the device first
>>    followed by the generic version.
>>
>> +Optional properties:
>> +
>> +- interface-pix-fmt:
>> +  List of valid input bus formats of the encoder. Recognized bus formats
>> +  are listed in ../bus-format.txt
>> +
> 
> This comments applies here and to [3/5] as well.

I'm not sure how the below comments apply to [3/5]? I guess you are
suggesting that [3/5] should be dropped?

> Are we sure we want the supported bridge input format defined in DT
> bindings?

Yes, I'm pretty sure. In my case, it has to be specified manually
*somewhere* (at least I think it has to, but what do I know?). The
bridge is the best position, if you ask me.

> Again, I may be biased, but as I see this, each bridge driver should
> list its supported formats with MEDIA_BUS_FMT_ fourcc codes and return
> the currently 'active' one when requested by the preceding bridge.

In my case this is not possible, the bridge supports maximum rgb888
input, but since it cannot know how much of that is actually wired,
the actual format needs to be provided manually somewhere. In my
case, I know that I want to send rgb565 to the bridge. Sure, the
wiring between the encoder and the bridge chip could be seen as
another "bridge" that goes from rgb565 to rgb888, but adding some
extra layer to the model for this step seems like over-engineering
to me. Especially when the binding for the generic lvds-transmitter
bridge needs to specify the input format anyway. At least, that's
the right thing to do if you ask me. How else should it know what
format to request?

> I understand for this driver, being compatible with both a generic lvds
> encoder and a specific chip, the supported input formats are
> different, but I would have used the 'of_device_id.data' field for
> this and leave this out from DT bindings.

No, the lvds-transmitter accepts parallel input and spits out lvds,
just like the specific chip I'm using. I do not *need* to specify the
specific chip, and the driver does nothing special for it. It is just
good practice to specify the details when they are readily available.

> This makes the translation routine here implemented not required if
> I'm not wrong...

I think you are.

Cheers,
Peter

> Thanks
>    j
> 
>>  Required nodes:
>>
>>  This device has two video ports. Their connections are modeled using the OF
>> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
>> index 75b0d3f6e4de..b78619b5560a 100644
>> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
>> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
>> @@ -9,6 +9,7 @@
>>
>>  #include <drm/drmP.h>
>>  #include <drm/drm_bridge.h>
>> +#include <drm/drm_of.h>
>>  #include <drm/drm_panel.h>
>>
>>  #include <linux/of_graph.h>
>> @@ -16,6 +17,8 @@
>>  struct lvds_encoder {
>>  	struct drm_bridge bridge;
>>  	struct drm_bridge *panel_bridge;
>> +	int num_bus_formats;
>> +	u32 *bus_formats;
>>  };
>>
>>  static int lvds_encoder_attach(struct drm_bridge *bridge)
>> @@ -28,8 +31,22 @@ static int lvds_encoder_attach(struct drm_bridge *bridge)
>>  				 bridge);
>>  }
>>
>> +static int lvds_encoder_input_formats(struct drm_bridge *bridge,
>> +				      const u32 **bus_formats)
>> +{
>> +	struct lvds_encoder *lvds_encoder = container_of(bridge,
>> +							 struct lvds_encoder,
>> +							 bridge);
>> +
>> +	if (lvds_encoder->num_bus_formats)
>> +		*bus_formats = lvds_encoder->bus_formats;
>> +
>> +	return lvds_encoder->num_bus_formats;
>> +}
>> +
>>  static struct drm_bridge_funcs funcs = {
>>  	.attach = lvds_encoder_attach,
>> +	.input_formats = lvds_encoder_input_formats,
>>  };
>>
>>  static int lvds_encoder_probe(struct platform_device *pdev)
>> @@ -39,6 +56,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
>>  	struct device_node *panel_node;
>>  	struct drm_panel *panel;
>>  	struct lvds_encoder *lvds_encoder;
>> +	int ret;
>>
>>  	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
>>  				    GFP_KERNEL);
>> @@ -79,6 +97,12 @@ static int lvds_encoder_probe(struct platform_device *pdev)
>>  	if (IS_ERR(lvds_encoder->panel_bridge))
>>  		return PTR_ERR(lvds_encoder->panel_bridge);
>>
>> +	ret = drm_of_bus_formats(pdev->dev.of_node, "interface-pix-fmt",
>> +				 &lvds_encoder->bus_formats);
>> +	if (ret < 0)
>> +		return ret;
>> +	lvds_encoder->num_bus_formats = ret;
>> +
>>  	/* The panel_bridge bridge is attached to the panel's of_node,
>>  	 * but we need a bridge attached to our of_node for our user
>>  	 * to look up.
>> @@ -96,6 +120,7 @@ static int lvds_encoder_remove(struct platform_device *pdev)
>>  {
>>  	struct lvds_encoder *lvds_encoder = platform_get_drvdata(pdev);
>>
>> +	kfree(lvds_encoder->bus_formats);
>>  	drm_bridge_remove(&lvds_encoder->bridge);
>>
>>  	return 0;
>> --
>> 2.11.0
>>
