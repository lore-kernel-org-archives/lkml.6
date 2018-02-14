Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031410AbeBNPbO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:31:14 -0500
Received: from mail.visioncatalog.com ([217.6.246.34]:46566 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031247AbeBNPbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:31:13 -0500
Subject: Re: [PATCH 1/3] ARM: dts: rockchip: phycore: Remove 1.8 GHz operation
 point
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wadim Egorov <w.egorov@phytec.de>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
 <7871181.EPqc8gR4GV@diego>
From: Daniel Schultz <d.schultz@phytec.de>
Message-ID: <a8de3d85-c4e6-eed6-d2e3-6d9b7318a9c2@phytec.de>
Date: Wed, 14 Feb 2018 16:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7871181.EPqc8gR4GV@diego>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.02.2018 16:31:10,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.02.2018 16:31:11
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/14/2018 09:07 AM, Heiko Stübner wrote:
> Am Dienstag, 13. Februar 2018, 10:44:32 CET schrieb Daniel Schultz:
>> Rockchip recommends to run the CPU cores only with operations points of
>> 1.6 GHz or lower.
>>
>> Removed the cpu0 node with too high operation points and use the default
>> values instead.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> applied all 3 for 4.17
>
Thanks! I think I should have mentioned this earlier, but can you please add
     ARM: dts: rockchip: phycore: Remove 1.8 GHz operation point
to the stable tree v4.14?

-- 
Mit freundlichen Grüßen,
With best regards,
   Daniel Schultz
