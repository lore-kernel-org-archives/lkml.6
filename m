Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeBJOuf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:50:35 -0500
Received: from fallback11.m.smailru.net ([94.100.179.26]:59546 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750832AbeBJOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:50:34 -0500
Subject: Re: [PATCH 0/3] Fix broken bananapi m2 devicetree/regulators
To: Philipp Rossak <embed3d@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180209175236.21215-1-embed3d@gmail.com>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <160b60e2-6e50-0d63-e6ac-b67e10317e12@orpaltech.com>
Date: Sat, 10 Feb 2018 16:56:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209175236.21215-1-embed3d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-7FA49CB5: 0D63561A33F958A5533BE79C30C5E26D6B632EDB1FD78CB7074CB87938132310725E5C173C3A84C37725542EFDE5E0D32589F7B83EC902356A58BF81F659395FC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917D7C7A9FD87E698947C5641C5E92661F1069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A54EC6414FBA6FDD2BA6EFEA8057A76A810190C091DAE83DDA462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005989B929F85CCF0956AB214C65830EED93B78F62797F3E8BEF510ED5234590C9A5FC78D3D9DFD682EC77752E0C033A69E3DF03E4AFE169B847187F6D0DA2124709F6F601AB1435FA63CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2018 08:52 PM, Philipp Rossak wrote:
> This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
> The first two patches update/improve the devicetree and the last patch adds
> all missing regulators.
>
> Regards,
> Philipp
>
> Philipp Rossak (3):
>    arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
>    arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>    arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators
>
>   arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 70 +++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 3 deletions(-)
>
patches are not working

Thanks
