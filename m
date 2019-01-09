Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFDBC43613
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20509214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfAITAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:00:51 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38011 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAITAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:00:50 -0500
Received: from oxbsltgw03.schlund.de ([172.19.249.20]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdpG-1gsnov1vMc-00NmAx; Wed, 09 Jan 2019 20:00:15 +0100
Date:   Wed, 9 Jan 2019 20:00:13 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <1966518233.54588.1547060413944@email.ionos.de>
In-Reply-To: <7dde45e2-8e26-5051-dea6-da3566bb5e0e@i2se.com>
References: <20181212235150.6491-1-eric@anholt.net>
 <7dde45e2-8e26-5051-dea6-da3566bb5e0e@i2se.com>
Subject: Re: [PATCH v4 0/5] BCM2835 PM driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:xe9R5NiMj5STj4jz1+DejXlRv4idZiMxmQwZyvUdKsCduF8oMsW
 A0Zi21xKcDqhGFwhkeneIdrV/aoL37XFrjVlQPj4BT628jYyEegl/tHTfZBimhqkUPo3EAM
 hg+8JeqTf3IeXL9Nna5s+jFTqFePa0sApA/B8wjJeBXAp3mju3EYSXt3IBK2oqdLZmpTmD4
 K5dSRPWaDgBs9cm0pN/Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cEN39ddn6aI=:o3oBq9HYGiR1Fwm4iPZXAK
 +9nsslsvaCMFLziOrafwf0jKO8/klF9OJ809tks57L8n6nAQ4SXA7XBee43UqQ1i4Bi3Io8Vv
 i+gj++ILw9pbPSdrUcR1bIUHUxNwCB5aCORiPrPA8EQUpaB07uJHwvGC1vvRIua7kdej2Swyg
 NRGZbkBNdRllUTKNafx16keGEF8sm8AZjNzvwFRVTczgjWaDrShRABgPTM5Q0GiVwdgQ6Lq0R
 WVstAmsNClCUFVEcIreIRTXtyH1LoTvo0Hw6T9VjXll44oOB+3IA+RWhsG5+Ihe6XVOzKNyJV
 Liid4Zmlweii2A0TiLT0aw/EaOQpjtHZWM/K6RtIQCJEiPMkkNUxMDPXtuTDXHHiw96ypnN1S
 tGhF8uEOPTCkNUNlw4UlhtpH3D+J1ktqq/iZMIUlL13WVdjnkHbKIWnzg5EDZHEWNsU2+hN8m
 HX4gV4IZtrTudnZoe2t2wgl5Xqq2E6bHEtb+T3hILUkI6FgxK0lacHgB9nKVcFQ5P3J+l4cK9
 srQ0vjTgH2zsEYEVZ3nTsW4TLwDFtdidLNAk9bm5mBvMcWTOWtXc8kH1uJ7x4byAOMAylUMYE
 9spRqEJ1uAw/u/JzqqUGGFk3FYrXcHLsoki2xR0RyWAKZPEZX+NEWiLbR37giq2xHrcIjN0ny
 EuTlZGyGmdWTP0USt50kuh+j/wHBq4UPo/XZvPFQflxEdB74d5r1a58lS1TWuQnnfjBHhBdsK
 0mASgBbugV98sDt8flr6zoXHgTfViLcNh2BFCY+AyJLmOaRauij5ohFEFEc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 3. Januar 2019 um 16:56 geschrieben:
> 
> 
> Hi Eric,
> 
> Am 13.12.2018 um 00:51 schrieb Eric Anholt:
> > v4 adds the system-power-controller node to the binding as requested
> > by Stefan.  No driver changes are added to make the power controller
> > behavior optional yet, since it's really unrelated to this series.
> >
> apologize for my late reply. This whole series is
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 

Applied to bcm2835-drivers-next / bcm2835-dt-next

Thanks
Stefan
