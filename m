Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeCFJ6L convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:58:11 -0500
Received: from mail.microcatalog.org.uk ([217.6.246.34]:38625 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeCFJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:58:10 -0500
Subject: Re: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
 <3380975.Amu1WGHSQ5@diego> <2707703.8mZIocJ1Ne@diego>
From: Daniel Schultz <d.schultz@phytec.de>
Message-ID: <fe1d445e-e9ac-452f-e990-d4bc17bd3355@phytec.de>
Date: Tue, 6 Mar 2018 10:59:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2707703.8mZIocJ1Ne@diego>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 06.03.2018 10:58:08,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 06.03.2018 10:58:08
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 03/05/2018 10:08 PM, Heiko Stübner wrote:
> Am Montag, 5. März 2018, 21:25:30 CET schrieb Heiko Stübner:
>> Am Montag, 5. März 2018, 13:45:11 CET schrieb Daniel Schultz:
>>> The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
>>> Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
>>>
>>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> applied for 4.17
> had to move it to 4.18 though.
>
> The change to the dt-binding header goes through the networking
> tree and will only get merged for 4.17-rc1 .
>
> So devicetree changes in a different branch aren't available at this
> point.
>
> One commonly practiced alternative is that you provide a v2
> with the actual hex values instead of the constants for 4.17
> and a follow-up patch replacing them with the constants
> that I can apply for 4.18.
It's not so urgent because the RK818 PMIC currently does not boot and 
the patch for this problem is also pending.

-- 
Mit freundlichen Grüßen,
With best regards,
   Daniel Schultz
