Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69278C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4126E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392092AbfBOJJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:09:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:38746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388927AbfBOJJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:09:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10D8AAA85;
        Fri, 15 Feb 2019 09:09:53 +0000 (UTC)
Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
To:     Lukasz Majewski <lukma@denx.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770A46D7FA45A8AFA923DADC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20190215075226.413d55dc@jawa>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <c2eb829b-96a7-20cb-913f-ce4214f2156c@suse.de>
Date:   Fri, 15 Feb 2019 10:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190215075226.413d55dc@jawa>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz and Fabrizio,

Am 15.02.19 um 07:52 schrieb Lukasz Majewski:
> The best approach is to run:
> 
> git format patch -1 <your patch sha>
> 
> And then 
> 
> scripts/get_maintainer.pl 0001-xxxxxxx
> 
> You shall see the the list of people to send the patch.

No, that does not answer his question. And please don't top-post.

>> Who is the best person for taking this patch?

The answer is: whomever is taking dt-bindings patches in the following
10 patches that make use of this prefix, once you have a Reviewed-by
from Rob. So, most likely the Renesas kernel maintainer(s), i.e. Simon,
which differs from get_maintainers.pl of vendor-prefixes.txt.

Regards,
Andreas

>>> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>>> Sent: 16 January 2019 18:38
>>> Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon
>>> Linux.
>>>
>>> From: Biju Das <biju.das@bp.renesas.com>
>>>
>>> Add Silicon Linux to the list of devicetree vendor prefixes.
>>>
>>> Website: http://www.si-linux.co.jp
>>>
>>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>>> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
>>> ---
>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
>>> 4b1a2a8..02a7037 100644 ---
>>> a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
>>> b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -344,6
>>> +344,7 @@ sgxSGX Sensortech sharpSharp Corporation
>>>  shimafujiShimafuji Electric, Inc.
>>>  si-enSi-En Technology Ltd.
>>> +si-linuxSilicon Linux Corporation
>>>  sifiveSiFive, Inc.
>>>  sigmaSigma Designs, Inc.
>>>  siiSeiko Instruments, Inc.
>>> --
>>> 2.7.4  
>>
>>
>>
>> Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael
>> Hannawald, Sitz der Gesellschaft/Registered office: Duesseldorf,
>> Arcadiastrasse 10, 40472 Duesseldorf,
>> Germany,Handelsregister/Commercial Register: Duesseldorf, HRB 3708
>> USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE
>> reg. no.: DE 14978647
> 
> 
> 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
