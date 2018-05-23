Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeEWAQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:16:46 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44310 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeEWAQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:16:44 -0400
X-Google-Smtp-Source: AB8JxZqHWh4w/bFWPrprwQoGfEmJFoaR7/1tbigH94Q5PwYv5tiV35ToAo8VL5y1fyIcOxwXiqvTBjbym2mY+Ig1SgQ=
MIME-Version: 1.0
In-Reply-To: <20180523000717.HTtmA%akpm@linux-foundation.org>
References: <20180523000717.HTtmA%akpm@linux-foundation.org>
From: Joonsoo Kim <js1304@gmail.com>
Date: Wed, 23 May 2018 09:16:42 +0900
Message-ID: <CAAmzW4OF8dey78Pr7M6VMC-BBYrUiifW77wCBZK0VnX0KdprxA@mail.gmail.com>
Subject: Re: + revert-mm-cma-manage-the-memory-of-the-cma-area-by-using-the-zone_movable.patch
 added to -mm tree
To: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Laura Abbott <lauraa@codeaurora.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4N0Gqw0013827

2018-05-23 9:07 GMT+09:00  <akpm@linux-foundation.org>:
>
> The patch titled
>      Subject: Revert "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
> has been added to the -mm tree.  Its filename is
>      revert-mm-cma-manage-the-memory-of-the-cma-area-by-using-the-zone_movable.patch
>
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/revert-mm-cma-manage-the-memory-of-the-cma-area-by-using-the-zone_movable.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/revert-mm-cma-manage-the-memory-of-the-cma-area-by-using-the-zone_movable.patch
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
>
> ------------------------------------------------------
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Subject: Revert "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
>
> Revert bad8c6c0b11446 ("mm/cma: manage the memory of the CMA area by using
> the ZONE_MOVABLE").

Hmm...Now I checked the patch and it seems like reverting is imperfectly done.
I will send a reverting patch that includes the full series.

Thanks.
