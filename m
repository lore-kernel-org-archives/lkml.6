Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1DC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DD6206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DD6206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeKTS4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:56:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:46223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeKTS4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:56:22 -0500
Received: from [91.14.85.22] ([91.14.85.22]) by web-mail.gmx.net
 (3c-app-gmx-bs39.server.lan [172.19.170.91]) (via HTTP); Tue, 20 Nov 2018
 09:26:23 +0100
MIME-Version: 1.0
Message-ID: <trinity-8f0fde8e-5ef3-4272-b009-49e180c934eb-1542702383860@3c-app-gmx-bs39>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "CK Hu" <ck.hu@mediatek.com>
Cc:     "Matthias Brugger" <matthias.bgg@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, sean.wang@kernel.org,
        "Matthias Brugger" <mbrugger@suse.com>, airlied@linux.ie,
        mturquette@baylibre.com, sean.wang@mediatek.com,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org,
        rdunlap@infradead.org, laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, matthias.bgg@kernel.org,
        ulrich.hecht+renesas@gmail.com, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v5 05/12] drm: mediatek
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Nov 2018 09:26:23 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1542686982.26483.1.camel@mtksdaap41>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41> <1542686982.26483.1.camel@mtksdaap41>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9FoktelCMjXwZ65NJnrX0tRbG43Ioh16rAAgEPy9U6O8fjGJ/axFNSA6baKgFgS0xu0NK
 oMaNo2xqtgmbaulGQAGCCPoNs69jmceiwxqwX4mESDlIJ9aTrJ9DLzo9P5qS4tIhVCw4JIYTpL5w
 rQ2M9hrylqWgPWE1iqCNk7RliRq5nxqI/qaUQimM4qcpzRwR/+8voOETIX2YpLPZtRCNTSb4kakW
 OgWdZ+PcD+z8lyKONl7CEB0OlBNICiSAAiP8zt2UPhB1gAkXI29hF7TAzPGmLe892ELvMI3u403C
 00=
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ds4fHFW8is=:NeyLgAOtWswG5AWIm7YBsZ
 dtSzb5SOe+3p+nKwOnns246klj7296pjKGJQzrph33oC3yz/TwWxHuLvH4QwJaEsSUpWTLlW3
 a9tWf/4B0Yt0WxxwkpPmnvLx2gJlK6iWGdQ00U0q2lwWKbxVnJJO6Zb6TIbTy9hZYeyhHuPMR
 NPBrm9aBEpv3AW2ON4mGxpbn8hYff46G2/VVtHnmLXn2IfieCoPlPEJmbDZwo2KExoL0Vp5b6
 E3c0lJ0Y5c+py74a9IpDsZjtELnMaMMs+hE4J8pZ4GK10FINkifxFZMamUPeNg0BO3rLaWLV/
 aW/GJzqSL+SZaJ6RTIAgChNC0m/KZu2ZBfiLb1GHg3maR4PPmwuFzVCPSydvjKQeVWKny2F8j
 zqD4VHtNE9BbW6/GwJ3lBY/lErKWXQQAPy8WQ1NzNtON9jq6cBMd4BUy7igbljmyxaFtL7pYL
 ocaA1S2ObGqz7mX9iE6iMrKPf7zhgF34/q1N6z8xFylLZnWfKBDmQ3dftaEwIxjxnTko5gsml
 iB7RY99uClt76kTYjnhC2nwXmQXHfoAKnJ+xoyK8yztdIjEuf69Uo+/8HXd52mn120iU/ysAi
 1aFoLISdyyDWE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i got v5-patches working on bpi-r2 (mt7623) with a Patch from Ryder.lee and 2 from Bibby Hsieh on 4.19-rc1

https://github.com/frank-w/BPI-R2-4.14/commits/4.19-hdmiv5

but after i tried to include them on 4.19.2, i got a strange behaviour (stretched and pink font instead of white/grey)

see here for detailed info:

http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/75

there are some patches between rc1 and final which i tried to revert, but no luck till now (cannot revert, no effect on the issue or no output). Had informed Bibby Hsieh...

is there any idea, why this happen?

regards Frank
