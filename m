Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A53BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35440272D9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35440272D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeF3Ieh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 04:34:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeF3Ied (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 04:34:33 -0400
Received: from [192.168.0.9] ([86.19.254.212]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.179]) with ESMTPA (Nemesis) id
 0Linfx-1g9M5y242H-00cww9; Sat, 30 Jun 2018 10:34:23 +0200
Date:   Sat, 30 Jun 2018 09:34:19 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180629181007.18071-4-johnfwhitmore@gmail.com>
References: <20180629181007.18071-1-johnfwhitmore@gmail.com> <20180629181007.18071-4-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 3/3] staging: rtl8192u: Prune the rtl819x_HT.h file of unused definitions.
To:     driverdev-devel@linuxdriverproject.org,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
CC:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        tglx@linutronix.de
From:   Justin Skists <justin.skists@juzza.co.uk>
Message-ID: <63457910-E837-458B-A80D-9D73DAF33FF5@juzza.co.uk>
X-Provags-ID: V03:K1:3VOZfQSZZLbp9r7p/iH23LKDqkLQb1dFL5hcxkTCg4qtJAtQj9E
 SKwMJN1yzltByhAddAxHTFGThVuZ7QYkeRbZYdbHN/nussZAgQTbCxiX1Y33cstllhDw3bP
 PC6xG9gDI5m5r5GQBrqJ4inJQcqZjcBoihw4YfofSR0bD6wX6QOhjdUnIatQnUtQWHYSuL5
 5kazhtcnKf0kkXJH3rgGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4p6zaBoyuoI=:YwfZcNcnqGa1XaG5jC1+vu
 dr5A1Oa9JIK2qH4XxDvOvW6zfyXKhkDrPqmVFZi9Tu5d/VyKY65ATUL2SY2+/duzVsJD1J3vS
 MwvtqPGBfRKYAaf1LUTLFv2SWNt+mOyH31A4gtoS5fB1UwaYoT6gFN/6SCCim2n74NUKcv26D
 5dZUaECB0axA217JqarwfFPRahbfSNmJ+1e7k5YatV9rqSdSrgsfxtyUrzMDp/LgqtA2bwXrZ
 +OGuyPHgiCkgK1nx1/fsTmaqEJSuREQOuzOcdfIRMghW3hDoGVV465OqxwXNNDvlo0/X8UVtS
 Pcm+ca24uzjugZHckxO8PJUmdJ81K+JHD9cGIdf/PDjGhaA64KaSitzbtwnGD0T9+6lv85cgk
 G6Ii42w49SreKPfprGCPatQWmNdUTlL1iP3Sv8k3TcjBTGY/EUlzRF1geLmvgrFX7pN6mNUTr
 6zmTVt48VLHPLEx9PnG36Fs+zfaewle+iJfVzpfMwGbsmM0VY1eZ9xtteNkfCeQ03YwoQKJIi
 qFe3xIuA356Gvjbb8qT0jux0DsP0p9srlwBfEqiBoWSW0sKuBqqbj3MUnAXD2xfrMM5/0ieuH
 HWFZe1fxffQEHVw/Jgxj1SfzSDV+sC3qtrLisuP71T7Fokj41Xdz6OWejwMjCK7mh6xKCiZ2b
 VrMhjTqsIZs7rrvyQE0BXpYyfxlxRT38ZGv9B2ATRvaAgccSi4rq3uMeXbV1FRWXH5n0G6XVn
 FXWlGsLl/DT7NgO7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 June 2018 19:10:07 BST, John Whitmore <johnfwhitmore@gmail.com> wrote:
>There are two files named "rtl819x_HT.h"
>
>$ find . -name rtl819x_HT.h -print
>./drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
>./drivers/staging/rtl8192e/rtl819x_HT.h
>
>The two files are very similar but differ slightly. Unsed definitions
>have
>been removed from "drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h" as
>a first
>step towards possibly merging the two files into one.

Just delete the lines if they are unused. Don't worry about commenting them out. That way it is easier to visually diff the patches for review. (Plus, the previous code is never lost in the git tree, anyway)

:-)

Justin




