Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeBVHMi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:12:38 -0500
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:19755
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751687AbeBVHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:12:35 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] dt-bindings: fpga: Consolidate bridge properties
To: Moritz Fischer <mdf@kernel.org>, <linux-fpga@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <atull@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <devicetree@vger.kernel.org>
References: <20180221173306.17265-1-mdf@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <8751fd85-fc84-f422-94e7-dd5689cb6922@xilinx.com>
Date: Thu, 22 Feb 2018 08:12:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221173306.17265-1-mdf@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(65826007)(53546011)(77096007)(186003)(336011)(26005)(50466002)(478600001)(65956001)(65806001)(305945005)(36756003)(47776003)(6666003)(64126003)(356003)(230700001)(31696002)(575784001)(86362001)(2950100002)(4326008)(36386004)(316002)(54906003)(106002)(81156014)(81166006)(9786002)(110136005)(8936002)(2486003)(76176011)(31686004)(58126008)(106466001)(63266004)(229853002)(2906002)(8676002)(6246003)(23676004)(5660300001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1471;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT031;1:QW8sGQYpJUQA65JLVJwuU3Q7/jKaKFaoMu28WFOHC9pFUL2/RIxDYq3C0c+PNZgBF5BzXxECjGuCDY8Mn/eXTAO1poFbPW7jnV+KaHcdx+BNWMVq9rQoZTRzdcvTfPEa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80090011-4e41-4104-a373-08d579c3a453
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:SN1PR0201MB1471;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1471;3:s47A3Lt48wzWRAGPRIwztwU/IKn7CPHal/qATiBneghQuAcwX5PlnxZOsiCj2SM5Ov5Ap4s/h0mqQgsfG2J6iea8jYDoB9/y0tOsLrdPUbROUktJE1Wue2ItsHKFKO8HX8azaWPrxs6SgHQtedK5P/5UE91ADAmhwOCCaH2pQzn8wMKK/c2NAIEK8FRg3QXWKcSN6FdpF5F4m4p8CD0qS4T6VBhrh1A7CUYmE7LU/AWN/a+5qaDBSKSsyJv/wQ3DiqbB23qFmllsQtRcGdh9oHQtAA3/cTXSLAHugh0r+0lIiB0yOLplF8a+YTnrhgBR0jthgt1PriyO4Nos1JbmqQPuSFPPeE1cdk1naekf2Ik=;25:es9o5zBmc0R4W1Uv+Zh8yRJW6aGURng3lE29MB1Zm49xQJTAE+haOOTbCmZb93IETLECiUEp+6yBpH5pkS1G7Ov63DAiptYIyUjzyJ2iHPzNV02ui83ZMGiBA/ucwwD/ukonKwGBgffS6hqI9PXijWovegnclOUdwGIdOJYD8OGfeiSWoPeYxVIsbdwbRLeqpjxxDdXaGBC8FuLHwj1rqN6kwWiiBBSU+NIHhfXw4TznlPPBJSzKZ5PBPy2qYpVTeHfCovHAowPYdUIjrxoRDRUHHagZrX38nVgJezJVXqiBeAHf+lh6nWP/eXYNCRc1NLI4SOP+E4FYav3caXsS9Q==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1471:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1471;31:hst8suoixuHBMKnc0GjbRjyl2Ih6sJGkibm9QE2nRfvZV4LfeRDVuha1j8FFK/D0oLLPkScRi+akgmGJziHFFoYtLYFu/GVNYtSrJzUtUBTZ1eKX5FE1PEgI4naK7MmTG5oS5WNejWaxiQkgqliHw+sPREwJ8xZbOPV4UBHVOezMnAT/KP0Q81ifLMYww4Xt3BLHJa3tY3eUzPM0qHBU8vup31khwCkBErPFarBjbN4=;20:h2BwuenjRcrwBrGtGnduobBezaB0b7/v0v72S1DAo717if+woIgbGr+dfyOpwwGL+LtDeLFBOtiQtOZq6Qr9BsKR2ZZEiD9v0Q2kuTY5GFqpUvUaVzRLgJ5lglgL3k0UifpUA5QjwAO4Sld4sEJ54fZB62JBaWRHiHWVbpeFKeYgBfqTirFHSGmK7/KGuDHG5iNAeC93Lpr8m5Z2nr+mOnVQK6Jaq+iTQe44b4K/+OYLm/yjUKwNdRhEVEmzkFIGlLMin6Rwp1BS9TRbCcxrmvG0Cp65q4zaBK1hUATKOgDvC6g5G0jfjy5coFGmxRwLOe71bQ+2n3+J6zp52csrlE/rCFaXtHK9yAaTCvGKw/CbdKT385dHEP736gDAuHuIOH6Xc660A3k1UlLXgaiTpM1R68WFt2NuaEzRzHpugF6YLrOsdjwa+zyRmrMzok6RGygmZFb6/CWWNHWrk3/3PIqzZQk2id6TzYoKaeq/kuemRa9iDk1TuiaQrabLtnEx
X-Microsoft-Antispam-PRVS: <SN1PR0201MB14718E5019F9EA1326A7B699E2CD0@SN1PR0201MB1471.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001076)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR0201MB1471;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1471;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1471;4:PD9q5KFFtoG4Zahwjr+DVAhWz960JCZM6ujvEL0zdvz8CBr7u1jfxMEpGjfFlcnx33DnEl/ASkCdyi7e58O3dqCl7fmo9IL5T8W/2Zjsms3+HBi2uC0LKsOUL6213ZirkLaTt5iZeB440R5AEdyOmnDIzoos5UCJp8j55nOzuJLTTDVYuzzYB3xUsnIOvmDq/muTHyaC+QuoaihVAg9czseZ1OcVRmrSvZbxfFIM7Tq1CJf53C89l/P3bMsRAUz4f1EdkbLh598ccEdsvyQXjLw+DhJ5h8zqgBsNbaBNdVryo9B/1r5sB6JAGdmWukTe
X-Forefront-PRVS: 059185FE08
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjAyMDFNQjE0NzE7MjM6NS93NmJ1cUExSEJ3UDVybDQ0S01zTndY?=
 =?utf-8?B?c2I1SWV6SnFZTm9heFcwU2xzTzRWSWwvZk5pK0F0azVQczl3a0JkTnZVT0VV?=
 =?utf-8?B?SWlZMjhxWjEwUVF5T24xRWtXU3NmRm5nNzQzMUZRYmE5WHVpM0hpZ3hQU3Ny?=
 =?utf-8?B?Y2xndCtnNmN1YWZGZzFVOVZRa0JCRGM4OEpoR0hQQU9HZU5STWVYK005K0dH?=
 =?utf-8?B?MFB1OFhQMEFtZ0dNbFNyRmh5OWpkQ0JON1hLNzNQQjQrRkVQb0pwbzZRQ01Q?=
 =?utf-8?B?Z28xd2N1ZFluNGllQmQreHB5QVR6a3VUc3ZqTHR3RncrQi9hek43cG96ckIv?=
 =?utf-8?B?dU9ZK0Z4YmQ3bDFWTFowNHJxUWM0dHVIcEFOTmRDM0IrUXFqZm8ya2NNVWFT?=
 =?utf-8?B?OCtheXA0N0wvMXpCUW1qYnE2STV2RnE4TllrSmhIYVVFQ0xFeHBPUE9ObWda?=
 =?utf-8?B?bE41QlhhNEFSb092ZU01UmVkOXgwRHRaMTJIWUlGYTZjVGRFNWIwWFhmb2do?=
 =?utf-8?B?Uk5oU3RQVi9mNVpOcDljS3hKNDNmVm5BYXVHY2ppMCtMUDdlSnB4aE1DTzRE?=
 =?utf-8?B?TnJjU05zbS9pMHVrMXZ2NVBPMVIxdnY4T3ozcm42b2FMK2JxRUczTFNKRU4z?=
 =?utf-8?B?cnlKdmVIMGNNbHJzLy9hM1BTSVVLeE91cEptbCtLR0x5Nmc0UXhJWmNoNmFC?=
 =?utf-8?B?eERwbWRHVlRNNG1PRkVoU0d3anV0aTRSTGd0UFRsSy9adm5NOElQTnAvUi9P?=
 =?utf-8?B?RnkwcFA3TnoxRzZRbnJYcDJNMy9rdnlQaW1ic1lLNXkySUgxUjlveFd3dHI5?=
 =?utf-8?B?bEprUzltNDRzSHNOSjM4QWRicVJYQ2dBYjRVa2NvSlJyQ1R5MmpRMXZ0ZHpN?=
 =?utf-8?B?Z3l1Q2NEODZaaHhBK2twSzh5Tk90bHVreTVPZkRGNUs1MFIwcFhVaWhzVi9p?=
 =?utf-8?B?NHEzenlrb0t1b21XYlJnRERmTHMzK1A0SmlXdmU3c1g0aXVQczErYWNNTGJj?=
 =?utf-8?B?YlNwa2RWM3AyektxeTU0bHl1eklOUTU2eCtpYml6RVJwT3BuREx3aU9RMjJE?=
 =?utf-8?B?dUJmUm83ZVU3UnVpWWo3TGFydnRVVHFYS1hVWHRsK0pRZHN6bzZYSFc0ayt4?=
 =?utf-8?B?bjVoa0JSTFNacExBMWpLU0VtcTErQ3hpTklWaDBqMFE1REVscytCZzUxSDYx?=
 =?utf-8?B?ekNGVHRoUm5FcWZrK2xNa01ScG1xQ01XK0g5VS9kYkxBcUNmTUVEdVBjVEQz?=
 =?utf-8?B?YzhrOWR1Umxwc0Y5NFNHeFFSWHZBTTRwNVg4ck5MalhVckpFd1Q4bWxtMGtG?=
 =?utf-8?B?a2NWbkxYL3IwcmJmdFYrQ2JUb1JZS3JTc01jNzd2N0NlNk9TOFBtTWdMQnlH?=
 =?utf-8?B?MXEwenpMbXVmSzJxalp4cEFrMzNSSzB6c2k4d05DS2ZqK2Z5RHZpTXNRMUp1?=
 =?utf-8?B?K21XOW5HM0Ewa21wdnFFZmhWVnIwT1FWblhiVVlLTVNKbTFzcHU1TEtQdEZR?=
 =?utf-8?B?d1I5S1BnKzI3WnlMSTc5MzluR1Iwb1AvSkorTFdqNCt6ZGpjcFN2Qlc3OFpG?=
 =?utf-8?B?a2FrSk83TnJQeGlBRDl5SDBlTWgvMTdkRzZWYUovMXRwbnptMDJIcXVHb1kx?=
 =?utf-8?B?ck5JakRsaURrY2N3L09odi9nQWxCMVZyRm4xRkJKODVVbWZzRTBWU2hqMnc9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1471;6:B0S/5Vi/QTbUpq59KBeBkI8k35r1zmGxd46H6u2iCZZDhNyvjFv28xxuNr1CakYZ42RRqpOFWRul31bOxprqsy51BsHdHbaOCZUvDeczpWhL9eAczeNE/LTavT3gmJIfRJlmzhxomMWrDLo8yarjUFTeyOCLcIBhO4u0isgg25lwtcyTSOLGo7KKvZMaF811oeXNYB+LHZ2E01B+JljEViitX9oG04CI/AO4oDIspLn8EmPjLl4MWtQjzcx6vFSfykwNUrhvrQbe8HhMOPcFkdoBJ9dx1GolELi1GnvZjbxPUKWrLjqzW3BjEBSlDmM7JnZ1iGcbgHYrQW/eiM74n9nZ2LS1SBzUgfGCJLIQXWs=;5:fvDWrn4j08L/mZhVSSsly2t3FXiGaqnM/f0uv5wjfi9vXpEutxcN5LDd4gu3sYetvCal5JCMYNDm/vrB1wVefUPjb9d0yExV50LDw/h9eepaMCkaexMsXszcLYaX56EL91CDQ7euavgWsQXK55fjPBVIZQNZOZz10inHQ+opkcA=;24:Bn05ZK0Mq3TnRBoo+MPuqpZ1Bg9XMbKKntOzroi9FgWjiLZSm9hrn5arwODAY/iqlynjw23yY7YSu0cGHBhyEJ21Ax9RRV3pEnyNRulnNPo=;7:ZCCz5GgxJPsylGph6MSg+YbdEcG/h/Lk4p+oxSg7kzpZmuc9pTZ87M5zJxKZd+RBpx/72wfa0KWDgDou57nJn5RJWmXEw1jFojicolivsxSI0XCITG3ro3Nw4c3uWzmu7gtYmwiWo7Ku+W6XeLjplse6C4Jz2p5nhuIqVX1jTlmTWPBdvRZJ41afqCYFLuW4VHCzfoXVt5RV78S4LHMfUHHKYtmXKXxiQeNMEKeUHJy8zwAq3uFnGO64rlQ24QUA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 07:12:32.0477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80090011-4e41-4104-a373-08d579c3a453
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1471
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.2.2018 18:33, Moritz Fischer wrote:
> Consolidate bridge properties in a single file, instead of duplicating
> the same optional property over and over again.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt |  5 +----
>  .../devicetree/bindings/fpga/altera-freeze-bridge.txt     |  5 +----
>  .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt   |  5 +----
>  Documentation/devicetree/bindings/fpga/fpga-bridge.txt    | 15 +++++++++++++++
>  .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt      |  8 ++------
>  5 files changed, 20 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> index 817a8d4bf903..5dd0ff0f7b4e 100644
> --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> @@ -3,10 +3,7 @@ Altera FPGA To SDRAM Bridge Driver
>  Required properties:
>  - compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
>  
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	fpga_bridge3: fpga-bridge@ffc25080 {
> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> index f8e288c71b2d..8b26fbcff3c6 100644
> --- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
> @@ -10,10 +10,7 @@ Required properties:
>  - compatible		: Should contain "altr,freeze-bridge-controller"
>  - regs			: base address and size for freeze bridge module
>  
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	freeze-controller@100000450 {
> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> index 6406f9337eeb..68cce3945b10 100644
> --- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> +++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
> @@ -9,10 +9,7 @@ Required properties:
>  - resets	: Phandle and reset specifier for this bridge's reset
>  - clocks	: Clocks used by this module.
>  
> -Optional properties:
> -- bridge-enable	: 0 if driver should disable bridge at startup.
> -		  1 if driver should enable bridge at startup.
> -		  Default is to leave bridge in its current state.
> +See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	fpga_bridge0: fpga-bridge@ff400000 {
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> new file mode 100644
> index 000000000000..82607b23a287
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
> @@ -0,0 +1,15 @@
> +FPGA Bridge Device Tree Binding
> +
> +Moritz Fischer 2018 (Consolidated from previous bindings)

nit: I would remove your name and year - it is visible from git log.

> +
> +Optional properties:
> +- bridge-enable		: 0 if driver should disable bridge at startup
> +			  1 if driver should enable bridge at startup
> +			  Default is to leave bridge in current state.
> +
> +Example:
> +	fpga_bridge3: fpga-bridge@ffc25080 {
> +		compatible = "altr,socfpga-fpga2sdram-bridge";
> +		reg = <0xffc25080 0x4>;
> +		bridge-enable = <0>;
> +	};
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> index 8dcfba926bc7..4284d293fa61 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -18,12 +18,8 @@ Required properties:
>  - clocks		: input clock to IP
>  - clock-names		: should contain "aclk"
>  
> -Optional properties:
> -- bridge-enable		: 0 if driver should disable bridge at startup
> -			  1 if driver should enable bridge at startup
> -			  Default is to leave bridge in current state.
> -
> -See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bindings.
> +See Documentation/devicetree/bindings/fpga/fpga-region.txt and
> +Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
>  	fpga-bridge@100000450 {
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
