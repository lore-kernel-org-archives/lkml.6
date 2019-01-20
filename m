Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F3FC6369F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89F320861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfATNhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 08:37:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:39131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfATNhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 08:37:11 -0500
Received: from [91.14.82.116] ([91.14.82.116]) by web-mail.gmx.net
 (3c-app-gmx-bs40.server.lan [172.19.170.92]) (via HTTP); Sun, 20 Jan 2019
 14:36:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-1c369adc-b489-43dd-87c9-5b43d49561c5-1547991406711@3c-app-gmx-bs40>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>
Cc:     "CK Hu" <ck.hu@mediatek.com>, "Daniel Vetter" <daniel@ffwll.ch>,
        srv_heupstream@mediatek.com, "David Airlie" <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
        linux-mediatek@lists.infradead.org,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 20 Jan 2019 14:36:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
 <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
 <1547775975.4221.11.camel@mtksdaap41>
 <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:o3i0L9O9z+MQlz+k1jSJjzY4FAThw+MOKUvQv5koO7oJGjqZ2m6zlGK/O/V5qwkb37qaC
 ICMcZwO9jhaDqZAj2oFvflIvZeqrW5aXVKcWzgFa0sNDZmoMfS12yqfk1Ubsaz08vjjj5nP/oraS
 EpRpASe0FNiR+CwF40kmXRhD9FobgrXZDLtoMkin1OYB62yS5/XInKlMgROz3Ph1tbX8fQ39R8yF
 HNNfmjZtIejybkJnABXRzcmR3BOLGNq5YOLIRjwli15zQxwsOZyHXOKHNzZhXcUvX9kLbYrpbKWB
 zo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqCeU4qORIw=:P01+qOOUmzzjPAfj1IeNZ+
 9R28epdTR5zX7z81bqBfysFGYKLHrgAwbFjgeSPDvMuxbK7Tcjc4W8KW1Ue0aU4yMxtCkYgEZ
 tEgp0tSejn4+lQZiG4ZVL7DUZNFhn2HmCEzWnCqpkv7qnZH/2A7PM38QOFCm4Bynm4bDpHnnr
 ijcXKzw4rr3Pi1KX6n6V70Lhn6MvlyqhVcfYS82EKG6JuHCSeN0lyvQRGIMiSTb0sIHi8PIk5
 vV1mh0wi/gLrcgFuf9ftroQGDybGyyGu5wW0zBCRqMv5ZI8DZaD12+fW/26cnAEpGDBZSDfCD
 6ubVKBwnW/aJck4bFYTHzwVZnL+a7FTOOCl7UKTChfPuSI6i3DDqroEBoL6n5B6o/k1DPPZwZ
 RNFgxTYcbNy1yYKtsdIHiZH0fxTbMIlUwXz2CfiMjyrJOADG/sws0ixukXTDh5Rw13yCnA4oQ
 vcJunUsEM9eiNqHTv0RdQbA5ig/4pRL8jFxVno4OVZIrAXPXE2kTZNwBmab0ASvXZA6gO6N8O
 lgonbmiTeM8iT2i720Bbuk9d4wwbfInf9MvfJTK3CjdTamM7if09TRRhexXMKrsruxnBwse4n
 OJH1zRI1IvZlk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with mmsys-Patch, but same result, no fbcon, tft is switched on but i see no kernel-log

after boot is finished, i see X-server, until this point i see only black screen

regards Frank


> Gesendet: Freitag, 18. Januar 2019 um 09:39 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> may it be the not yet fixed mmsys compatible problem?
> Frank, did you test with my last series [1]?
> [1] https://patchwork.kernel.org/cover/10686345/
