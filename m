Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C250C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3501218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nmoHcY9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeLSKEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:04:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51532 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbeLSKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:04:25 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181219100423euoutp01325aac1afbd529352a004fb6f870214f~xs9J-myzr0265302653euoutp01K
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:04:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181219100423euoutp01325aac1afbd529352a004fb6f870214f~xs9J-myzr0265302653euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545213863;
        bh=2h0fpsCwBy3MVAmWY92Djd87cjiSTpDbGmZVBK6Tmo0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nmoHcY9G40xksqu+ehlbJMc+dSIIuAnMHoi2a/Y6B242Aezok3Uy1PuYAg/rOfzYT
         7YLO2Aw2TldXv04LLZvt86CtcWwus6xgHE6GED9TZYOGOEMFw09LD5kZAWPjlbmCZB
         Yova0I7utuuBWoP8mWCb77xUJrgz760AuMohz0Lo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181219100423eucas1p2edc7556906d3519155ffd07e3af48206~xs9JSM2VT1696516965eucas1p2S;
        Wed, 19 Dec 2018 10:04:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 98.2A.04441.6A71A1C5; Wed, 19
        Dec 2018 10:04:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181219100422eucas1p1d7abfa8b10b6ebdf4a9a6814a9b563bf~xs9IcBb7G2260022600eucas1p1P;
        Wed, 19 Dec 2018 10:04:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181219100421eusmtrp1a25be906848d64befd3a058d8a862119~xs9INgUsQ0164001640eusmtrp1B;
        Wed, 19 Dec 2018 10:04:21 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-7e-5c1a17a682db
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.5D.04284.5A71A1C5; Wed, 19
        Dec 2018 10:04:21 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181219100421eusmtip22eeb42667a428a78f7aa48a14db2436d~xs9HwwnUf1654216542eusmtip2L;
        Wed, 19 Dec 2018 10:04:21 +0000 (GMT)
Subject: Re: [PATCH][resend] drm: dw-hdmi-i2s: convert to SPDX identifiers
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <58d189f4-078d-e441-1c9e-bb8fd2183add@samsung.com>
Date:   Wed, 19 Dec 2018 11:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <878t0mxs1b.wl-kuninori.morimoto.gx@renesas.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7rLxKViDA4s17foPXeSyWLO+jVs
        Fk0db1kt/m+byGxx5et7NouNm2+zWLw6vIvRonPiEnaLy7vmsDlwelzu62Xy2PttAYvH7I6Z
        rB4nZvxm8dj+7QGrx/3u40weG9/tYPL4dmYii8fnTXIBnFFcNimpOZllqUX6dglcGRs+HWQp
        WMZVcbGft4FxEkcXIyeHhICJxObzJ9i6GLk4hARWMEr0XfrHBJIQEvjCKDHjRj5E4jOQvX4u
        axcjB1hH7wY2iJrljBL//qpA1LxllNi8vI0ZJCEs4CXxefYxMFtEoEBi8b5zrCBFzAJrmSTm
        T25gBEmwCWhK/N18E2wSr4CdxNZJB8DiLAKqEvMe/WUBsUUFIiQ67q+GqhGUODnzCVicU8BW
        Yvn3+6wgNrOAvMT2t3OYIWxxiVtP5jOBLJMQuMcusWb6AyaIP10knnfsYoewhSVeHd8CZctI
        nJ7cwwJh10s0zbzCDNHcwShxYvFyNoiEtcTh4xfB3mcGunr9Ln2IsKPE55/fWCChwidx460g
        xA18EpO2TWeGCPNKdLQJQVQrStw/u5UZwhaXWHrhK9sERqVZSD6bheSbWUi+mYWwdwEjyypG
        8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzA1HX63/FPOxi/Xko6xCjAwajEw9uhIBkjxJpY
        VlyZe4hRgoNZSYT3UjRQiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQi
        mCwTB6dUA6PqFmmbhJkakQmLzI98WnH16cKnhQeXBZlndJQtmtBtFG+zjf//j+/TYwVawk58
        s9pm2WSvoe71Lfrms3NOYnWy9VIXHgi9frM4+GCa8gaFg9stTrSdF46IaOD1jtPM+m5z2Czi
        9LXLM2aoSGuU6LR+OHXJ5oDQjQXTJBpVnZkzU1TMgp9t51ViKc5INNRiLipOBAB43JMvWQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7pLxaViDF68NLToPXeSyWLO+jVs
        Fk0db1kt/m+byGxx5et7NouNm2+zWLw6vIvRonPiEnaLy7vmsDlwelzu62Xy2PttAYvH7I6Z
        rB4nZvxm8dj+7QGrx/3u40weG9/tYPL4dmYii8fnTXIBnFF6NkX5pSWpChn5xSW2StGGFkZ6
        hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GRs+HWQpWMZVcbGft4FxEkcXIweHhICJ
        RO8Gti5GLg4hgaWMEsc2HmTpYuQEiotL7J7/lhnCFpb4c60Lqug1o8Tfv6uYQBLCAl4Sn2cf
        AysSESiQePXpGwtIEbPAeiaJpc962CE6NjBJ3H50gx2kik1AU+Lv5ptsIDavgJ3E1kkHGEFs
        FgFViXmP/oKtFhWIkDj7ch0jRI2gxMmZT8DinAK2Esu/32cFsZkF1CX+zLvEDGHLS2x/OwfK
        Fpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiN2
        27Gfm3cwXtoYfIhRgINRiYf3gZJkjBBrYllxZe4hRgkOZiUR3kvRQCHelMTKqtSi/Pii0pzU
        4kOMpkDPTWSWEk3OByaTvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwc
        nFINjEL3p7TP25kt8jeraJ+D6Ho7j2XCmYxCZpd7rkpV/tb/zXeKcUfc09sa+ZfvrtJl4466
        fTpCrnu6msG1U/d3GPGlfLqZ5rZ2zxSeC/sdG+uPyfNtfc31O19GXeb0Ie6jbkd85ZbICHHp
        d/jyVZV8sHx+3GnBjsSdIj/vc4d/UvzO7bkymKFpphJLcUaioRZzUXEiAEE+SuLuAgAA
X-CMS-MailID: 20181219100422eucas1p1d7abfa8b10b6ebdf4a9a6814a9b563bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181219005646epcas4p1b46beae1b0321c7bd0cfcaa66d4a3606
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181219005646epcas4p1b46beae1b0321c7bd0cfcaa66d4a3606
References: <87lg4n1izg.wl-kuninori.morimoto.gx@renesas.com>
        <2503467.Tla0HvxUZs@avalon> <87bm5ixtun.wl-kuninori.morimoto.gx@renesas.com>
        <3162944.uzPVLzYCHc@avalon>
        <CGME20181219005646epcas4p1b46beae1b0321c7bd0cfcaa66d4a3606@epcas4p1.samsung.com>
        <878t0mxs1b.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 19.12.2018 01:56, Kuninori Morimoto wrote:
> Hi Laurent
>
>>>>>>> few weeks passed, nothing happen. I re-post this patch again.
>>>>>>> I added Andrew on Cc
>>>>>> The driver seems to be lacking a maintainer :-S
>>>>> bridge drivers all have a fallback maintainer, but none of them are
>>>>> cc'ed. It's maintained in drm-misc, so you could just push the patch
>>>>> too :-) Especially since you're listed:
>>>>>
>>>>> DRM DRIVERS FOR BRIDGE CHIPS
>>>>> M:    Archit Taneja <architt@codeaurora.org>
>>>>> M:    Andrzej Hajda <a.hajda@samsung.com>
>>>>> R:    Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>>> ??
>>> I double checked To and Cc.
>>> Original patch included Archit, Andrzej address,
>>> but these were suddenly removed on from Re: mail.
>>> (I added these address again on this mail).
>>> ... what's happening ??
>> I've noticed that several mailing lists sometimes drop addresses from Cc: in 
>> the e-mail content (but still forwards mails to those addresses). I haven't 
>> investigated why.
> Hmm...
> I hope this mail is still reaching to Maintainer


Yes, I have just missed it. Adding drm/bridge in the subject will be
helpful next time.

Queued to drm-misc-next.


Regards

Andrzej


>
> Best regards
> ---
> Kuninori Morimoto
>
>

