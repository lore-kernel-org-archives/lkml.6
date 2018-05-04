Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeEDIHu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:07:50 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:45382
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751447AbeEDIHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:07:44 -0400
Subject: Re: [PATCH v5 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
To: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-3-rasmus.villemoes@prevas.dk>
 <20180302194935.yq3xw4nxyrxuonz5@rob-hp-laptop>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <0bb4533d-c749-d8ff-e1f2-4b08eb724713@prevas.dk>
Date: Fri, 4 May 2018 10:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180302194935.yq3xw4nxyrxuonz5@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: HE1PR0102CA0031.eurprd01.prod.exchangelabs.com
 (10.170.250.44) To DB6PR10MB0438.EURPRD10.PROD.OUTLOOK.COM (10.168.14.146)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB6PR10MB0438;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;3:L3tncY7Fu2m/XZujjY/abSa2PrQv8MhLafNUCe1ZjJsZwTVzGv9ahzBdVL3rtLOErNQZEXtw6lWdGIal26/PJbaiSrlmHYEwLDODnXtdNWuk4MKEx7T34fwfe4dsT8rHrz94vwNHo5Ptiqcl4xN7dqjb+RoF/z2Y9udu9mCem50KIejrYBSxxgnPM+OrC64sC5pgfpDRPQPYp9rz2tLgC+aw4QjLXrHfvTKq1oz5RHN0KC/gCDzQc0vQ7fCxFBFH;25:nQCDodVQDj90luUt0qJRKkZPuPqIchKBAsd8ITljR4V1Up/TpSqDdCyBD3vesHZmUKV3jy+FAo2O6x2OmIoz/gqpAVABOx4EZDmtedvY29FZjythXdDX1VzjKa0rx8QcuKkdjDtoxX8Fjdv7C8AU+sCHVkYGYQj9+Ctm0+FqB5OC5b/mro69gzTNr6MTwPUivf0xbUeXuOF8cgrQw11nHuALUsYFO+ZTAn+K4DFeQMGgEXKuWsGo0goY/rMXMzMmmq8UP+3JTkLOVv6G/Rkzot7cXD9/BLuqpzsrFiFonudcTjgZ5Am6Uyd489VsCE07+BpzDpPhquhezgKi+tivEg==;31:VKtgKGsmzROHXS8OhWeewmfPykxW0viNny3nFnmcyARRJ1wyJe1YzDQXK0bMsa4alo9wUN6DRjV0eSOR1I/Kxa2MY3DbpgK953tizvBWL/pzVz94Ly6xAusVkoS+KN+aq0+iDCZS4mqBa9NHg/8e8TT8bpAPVI+6mMmsWxz65Ew+DCDq4BBoKcDH8F12LeomEBrSzgolUOKWtRCmXxejCEZ49BlGC06DhBtPKfwpDuA=
X-MS-TrafficTypeDiagnostic: DB6PR10MB0438:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
X-Microsoft-Antispam-PRVS: <DB6PR10MB04380883BB7545814F9DD22C8A860@DB6PR10MB0438.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231254)(944501410)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR10MB0438;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB0438;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;4:jkXDyQQBWZpqPd7GvQs7vOELqq/AQri130tKFogYhg5m30cHa943XiGpGC+gE5fdX55UPa/G8gxndbEjC95ALffa56rkaEecdqncfS1Psv1DwJTcYKhKVaJEMi2qavlD6IbUy23XFRffsh3LiKstWKT2fZckXYX3FnJDJzoI6fSMoQoLy3t2JGJybftJplDBzC/7g2n5NFU/Hm2D7lGhgzoJa0qng0DMZS2tCH6UAZx2BAgYXFx39K8Pnnk9RMTAWRXRkwlOqikzEpHQtTJPwg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(39380400002)(366004)(346002)(39850400004)(199004)(189003)(377424004)(65956001)(11346002)(476003)(66066001)(486006)(446003)(65806001)(6916009)(6666003)(2616005)(53936002)(50466002)(25786009)(44832011)(68736007)(42882007)(305945005)(47776003)(15974865002)(64126003)(6306002)(966005)(6486002)(97736004)(52146003)(23676004)(2486003)(956004)(5660300001)(478600001)(4326008)(229853002)(65826007)(72206003)(8656006)(77096007)(26005)(7416002)(31686004)(6246003)(36756003)(52116002)(16526019)(186003)(106356001)(105586002)(53546011)(76176011)(386003)(54906003)(8976002)(31696002)(74482002)(93886005)(2906002)(7736002)(58126008)(81156014)(8936002)(16576012)(81166006)(230700001)(316002)(6116002)(3846002)(8676002)(18886075002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR10MB0438;H:[172.16.11.52];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwTUIwNDM4OzIzOk5UVmt5V2FtWWVicHllbzF1RkR3d0RuTDVH?=
 =?utf-8?B?amxyenUyRDVyWGFrNnAzWTFqblpNeGkwd3hpd1dyUERIUGpIWFBrT1dkaXF6?=
 =?utf-8?B?aXF0SVhKOUhDY0pxa0s1QzMwUThta2diQ1puZEJTdm5sbkZqbHE2NUhlQnd6?=
 =?utf-8?B?SnpJcE1HY250bGNWQUIwUHBFMHB0SGtIenJtMG5TZlZYcEk0aTduVnBlbnVy?=
 =?utf-8?B?VzZadmttYXlTdThYRXo4TmlsU1pUdVIybUJYNTUwUFFubVJRQWloNC9pcjFt?=
 =?utf-8?B?bDd6bUdJTlFqdW15ZExQejFCQnQvYk5BSXRqZEx0MHZpVHFJbVBpSmkrZ2Qx?=
 =?utf-8?B?WHhFYUhCRE9mdllaOXYvWVNab2t1elpmd1U1aTNiTHRjZXBIQmFNd3hYdU1h?=
 =?utf-8?B?N3JFVktNYmNScVNFRHhQd3lQVG8vSkJqM2x1Y2lCcmtnVTRHSDlhODlDdmlL?=
 =?utf-8?B?eTJRUWorNy9YL0t0VmtzNlk4QnJmZGZVd2lmN1U4TnVKbDF0N1NZNlI1Y3lN?=
 =?utf-8?B?bnJaZ3F0eWxJbGt0K2VOQ3NadmdpWWhOSEo0SnFJSmtzbWZWdnhzTUpFTmZ1?=
 =?utf-8?B?dWluSG95ZitzTWdKZFBSbE00YVdXdUVOUndtZ3NWSXBISUFGcExoc015My9T?=
 =?utf-8?B?NCtpTXBSRkx3ckMwejN6c1JlbTloN1ZiSmk4U3IwWnBoL3hKM3FaejBmWm5N?=
 =?utf-8?B?TUsrWS9sOGRTVVpVVlFPanQ1NFJNOWdtR09PdmJVWkMyTnRtd2N1UlJlSmVD?=
 =?utf-8?B?SVJMMWg1V2ZRbmxqd05VVVZiM0lQR1I3Vi92cTRWYlhoWnBhTVJQeFJURDVM?=
 =?utf-8?B?U1pPeUp2aEZkL09mT2diL0RIV0RCN01RcXdnT0x6TTM1ak5nbkphSlFIQmE0?=
 =?utf-8?B?U205WnRvUjRuNVVnUjBPWGt5QlNqblgxdWdJSmlrK1B3YVlrRGp3M3dIVWl2?=
 =?utf-8?B?Rk9ydjlVcTUyYm1rOFQ4TVJKWk54ZVZMeXcydjZFRnhIM2x5emRGc2dtTFpI?=
 =?utf-8?B?WE83ZkhaUTR6K1A2eUw2RkxMaEdGSFk1WXBOQm8rRTh4YnY5RmwwdEI2RXR2?=
 =?utf-8?B?dzBaVUtnVytSSlhpTGxqaDBVcG5JTTNGNFh6Z2FuQXBRbnpHNFZqbCt3aFl0?=
 =?utf-8?B?TER6NG40Rk5XNjV0ai9iY2dlM0FDTFh4V2tIRnREK2VIQUswY1lCVVpxN2ds?=
 =?utf-8?B?RVljR1gxRHlqVHJVSk5Gai96OG42Q3NqWUFoM0tmRWRHZG8wZVI1dzR2Sjh2?=
 =?utf-8?B?Uk9vYWczeSs1b1FxMTR1OEpFRVBiRW0xZjg0Y1A3T2hONXdCODlEZDFTaldU?=
 =?utf-8?B?SWFaQlQvaTFtbmEzRGRJeWlWOG5WemJLOGtGaWp3bitqWVZoczY1NVRKcitK?=
 =?utf-8?B?dEpadkZjTVQ3eEtxWmpXVWhoMDZPSTdaNUdDU2QvcTVhYU1JZU5PemI4NHNL?=
 =?utf-8?B?WHFEbklnWXN3V0FKMXdDOEtiMEMzZzFlbzd0aTNFTXFSOU1iSHI1d3B0QklY?=
 =?utf-8?B?Vy9tVmZLWlRkZXA4S2JNM1lVRVVKK2JIWE10bXFBRFJkT0dGbnY4NnhMOGIr?=
 =?utf-8?B?anVEQjg3QlZkVklNZWk0ZmxqRXVod05xZVQyUVB3ZjZLZTRjTUxNVFUwbFhE?=
 =?utf-8?B?VUxmZGtFY3FqWVpmYnRQUkVFR0tqRmVnZTAxSUxWekRCUHBya2NCNFo1c1dx?=
 =?utf-8?B?VFM0VTNwTFJnUjlvdUM2N3U3b3BGdzFNcmVQZml1YnFJeDU5SFFJQ2FqSXN1?=
 =?utf-8?B?WXJOR1FiMC93VTRWQWp3ejRFQnVuUVgxb2VqeGJ4bW03RGNJV0kzdjM0eVZh?=
 =?utf-8?B?SnZlVlJpcXloWnZ3R0pLYnc4VEdyZ1c0N2FJUUJ1MFQ0UkhhU0l0U24vWEVx?=
 =?utf-8?B?eFpUOHNBUU0xc0NNZ3dzbGovd045TytSNnZYUU0rck5pSjc5TGZiNzVqbEFB?=
 =?utf-8?B?QUxqdWtIV3BHYWRVMUJTUUVCOHM0VlVIVm96dUcwenBTRTBQeFJaV3RabXhS?=
 =?utf-8?B?bkxRaGNLQ1lqT2ZuTUlZZHhUdHlqdDd3L00yTzBCZFozY1hkckY5aVBLREI5?=
 =?utf-8?B?MW8rY3dyMEY2Wi9kSGl3dkRmLzlGVU5uVmNVeW13RXZkbnJwcUtnOVFqbXFw?=
 =?utf-8?B?cG5ZK0htL1RtQ1diWFBvdWZLNGZqZ2tVTXBEQmJka3FLUFFaQ0RZdE1ESjd6?=
 =?utf-8?B?UVQxbkdYTzdHSC9qRWFZbU45d00zR0xNVEp2cEhrK1pmeVJNY2g0a2VBbk40?=
 =?utf-8?B?eTNhVmZXeXR5RWQ2ZmE3Y2t3NXJ2SkdLMVlZMGJpQWxhQ2xzUFZ0QT09?=
X-Microsoft-Antispam-Message-Info: yq2lRp7FPxGbWim1BNKplkDAs5U1lSbp784fPmKaRw8ao9bwDXMLl+T/iYjyvnL0FVL8SJidJuqlss2bc1eIc2mTnAqQF5aE8w9GiSwPhNvvKCag2vE+juZcCk1FfDYvRGbzLnwbHOQiaeYE7W8D40xGGISfb7NoAe8TqmGWuLFXsEkaDq7iA6NmGVNyeuV/
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;6:pWHzKuQI2TSwG/G6G3Xjca/mvFg82low9yloeLr81wKXqCrW2R9xGnEoS+MdVx1IxI7GtDS77UderyXVFZGNXEKrbCslzI4Ppjua4Sss6/Q5GZ4RJamPouNZqF1yX8nIqQVPmWfVmXLDMZKRGee1AFo67nkh38waK6G7/XDxtTCuDtqV7+lLpkOMokU9OZMDd8/pQd0N1OFRuuSvKaIbT75+ngVAIXtsxS6MhKfIUV4p4LmwanI8XhgbSP8NSYWnpyWsDCROpQ/Hhhon5yCKxRMNLaGlpMlWqVV1xXiJPy/rJ5GGZgC3o5NZ3yvK61JdUi0bW/3/BRpARzsOVth8hKh0vZ20CTM5LlMHDHh3UOA7DenE0YdE5+vjNTLtcIbrXQbGHddVqotpa8LacdqNLF+8z3oqibPqc0DP8HR3CAc8EAs3f+6y1E9xlUikbRP+y4TRTwgi2B0fh3kO5ve+kA==;5:YahYY05GDx4LNFz5I3ib4/anIIs6QbM0emq1yuj/4SRUD9HNZ5TI1OAr+n/0OSkTVKBrz/AD7MLt+xfARfBA7GEdP0CTNiPhC9LsXYFwyEg7nTb4QD4IPDDhHjtGYZhhoCjCsOReA31jWiaHmk+VVwqzgS5pJlrUyOBN0amTeDc=;24:ItvwXq85G8u9XLLOsYs6PiaCV0WqfYMw+mOWa6QFQnjYaVq0uSjmE/WLj/ini4bprDWeiNcV63FC3Q2EM4CeUj1MvFiDFNO7ozCPKTazh2I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;7:zBKJpppAbetucsPIvgD/kLHR1XA59lSw+UNB6zq5UQVKUoUX7x+GIbtt4iU5OaizXOT90zq4/w6hDdCHNYGTLNNyvvQxDrLOp7wztk2FBVsr7U6F5U8vor74rYKYAcR5vyevi/DU4BmqHxmwWwC4tJie3NGceWEfIHMPBuVwWQWdh1lDnpmo4zszkWeVRiT4SRfCajVb33XkqBwDqFrTwVUPXw3DjMuTRZypsh4le+c3zys/O35J5QoThr3JJHa7
X-MS-Office365-Filtering-Correlation-Id: 5d090abf-feb8-4f91-0eca-08d5b1961b25
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 08:07:39.2354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d090abf-feb8-4f91-0eca-08d5b1961b25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB0438
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-02 20:49, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 10:09:00PM +0100, Rasmus Villemoes wrote:
>> This adds Device Tree binding documentation for the external interrupt
>> lines with configurable polarity present on some Layerscape SOCs.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>  .../interrupt-controller/fsl,ls-extirq.txt         | 44 ++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>> new file mode 100644
>> index 000000000000..e510c715e8f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>> @@ -0,0 +1,44 @@
>> +* Freescale Layerscape external IRQs
>> +
>> +Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
>> +the polarity of certain external interrupt lines.
>> +
>> +The device node must be a child of the node representing the
>> +Supplemental Configuration Unit (SCFG).
>> +
>> +Required properties:
>> +- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
>> +- interrupt-controller: Identifies the node as an interrupt controller
>> +- #interrupt-cells: Must be 2. The first element is the index of the
>> +  external interrupt line. The second element is the trigger type.
>> +- interrupt-parent: phandle of GIC.
>> +- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
>> +- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
>> +  interrupt controller. Interrupts are mapped one-to-one to parent
>> +  interrupts.
> 
> Use the interrupt-map property for this.

Please point me at some documentation for that. AFAICT, that would
require the property to consist of n*(3+2)*4 values, instead of just n
(with 3+2 being sum of #interrupt-cells and 4 being the four different
allowed incoming IRQ_TYPE_*). That seems quite excessive.

I used a private property based on advice from Marc

  Most interrupt controllers use a private property, potentially with a
  range (see the recent example of the Qualcomm PDC [1]).

  [1] https://patchwork.kernel.org/patch/10208037/

and the qcom,pdc-ranges has this description (and that patch has your
Reviewed-by):

+- qcom,pdc-ranges:
+       Usage: required
+       Value type: <u32 array>
+       Definition: Specifies the PDC pin offset and the number of PDC
ports.
+                   The tuples indicates the valid mapping of valid PDC
ports
+                   and their hwirq mapping.
+                   The first element of the tuple is the starting PDC port.
+                   The second element is the GIC hwirq number for the
PDC port.
+                   The third element is the number of interrupts in
sequence.

In my case, this is simplified by the external irq lines being numbered
consecutively from 0, so the array index itself serves as the "starting
pdc port". I also omit the "number of interrupts in sequence", and have
that be 1 implicitly, since it will only ever be either 6 or 12
elements. So I end up with a simple array of GIC hwirq numbers.


>> +
>> +Optional properties:
>> +- fsl,bit-reverse: This boolean property should be set on the LS1021A
>> +  if the SCFGREVCR register has been set to all-ones (which is usually
>> +  the case), meaning that all reads and writes of SCFG registers are
>> +  implicitly bit-reversed. Other compatible platforms do not have such
>> +  a register.
>> +
>> +Example:
>> +	scfg: scfg@1570000 {
>> +		compatible = "fsl,ls1021a-scfg", "syscon";
>> +		...
>> +		extirq: interrupt-controller {
>> +			compatible = "fsl,ls1021a-extirq";
>> +			#interrupt-cells = <2>;
>> +			interrupt-controller;
>> +			interrupt-parent = <&gic>;
>> +			reg = <0x1ac>;
> 
> This needs the length too. What is buys us is following the standard in 
> which mmio has a #size-cells >= 1. BTW, you need a #size-cells and 
> #address-cells properties in the parent. (I think dtc will complain if 
> not).

Well, the parent consists solely of 32 bit registers, so I think it
would make sense to have #size-cells = 0, to avoid redundant boilerplate
in subnodes' reg properties. But you're right, the ls1021a scfg node
currently has neither #size-cells or #address-cells, so I'll have to add
a patch adding those before adding this subnode. And if #size-cells=0 is
somehow frowned upon, I'll just make it 1.

-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 3
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk
