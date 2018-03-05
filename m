Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeCEPzc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:55:32 -0500
Received: from mail.phytec.eu ([217.6.246.34]:38133 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeCEPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:55:29 -0500
Subject: Re: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
 <3530074.WSbKf9j6h0@phil>
From: Daniel Schultz <d.schultz@phytec.de>
Message-ID: <cecf3c08-d43d-c340-c5ff-30e41e338469@phytec.de>
Date: Mon, 5 Mar 2018 16:57:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <3530074.WSbKf9j6h0@phil>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.03.2018 16:55:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.03.2018 16:55:27
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 03/05/2018 03:15 PM, Heiko Stuebner wrote:
> Hi Daniel,
>
> Am Montag, 5. März 2018, 13:45:11 CET schrieb Daniel Schultz:
>> The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
>> Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>
>> The binding will be added with the next merge of net-next:
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=9708fb630d19ee51ae3aeb3a533e3010da0e8570
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/log/Documentation/devicetree/bindings/net/ti,dp83867.txt

If I search in the master branch, I get the patch. Did I searched wrong?

Daniel
> I did find the commit, but no related change of the dp83867 dt binding
> document [0], including a review by dt-maintainers.
>
> While your property does not look overly complicated, the binding
> should be updated nontheless.
>
>
> Heiko
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/log/Documentation/devicetree/bindings/net/ti,dp83867.txt?id=9708fb630d19ee51ae3aeb3a533e3010da0e8570
>
>>   arch/arm/boot/dts/rk3288-phycore-som.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
>> index bdd80aa..e60535d 100644
>> --- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
>> @@ -141,6 +141,7 @@
>>   			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>>   			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>>   			enet-phy-lane-no-swap;
>> +			ti,clk-output-sel = <DP83867_CLK_O_SEL_CHN_A_TCLK>;
>>   		};
>>   	};
>>   };
>>
>

-- 
Mit freundlichen Grüßen,
With best regards,
   Daniel Schultz

- Entwicklung -
Tel.: 	+49 6131 92 21 457
d.schultz@phytec.de
www.phytec.de

Sie finden uns auch auf: Facebook, LinkedIn, Xing, YouTube

PHYTEC Messtechnik GmbH | Robert-Koch-Str. 39 | 55129 Mainz, Germany
Geschäftsführer: Dipl.-Ing. Michael Mitezki, Dipl.-Ing. Bodo Huber |
Handelsregister Mainz HRB 4656 | Finanzamt Mainz-Mitte | St.Nr. 266500608,
DE 149059855
This E-Mail may contain confidential or privileged information. If you are
not the intended recipient (or have received this E-Mail in error) please
notify the sender immediately and destroy this E-Mail. Any unauthorized
copying, disclosure or distribution of the material in this E-Mail is
strictly forbidden.
