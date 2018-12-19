Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11E3217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L2kf5RwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeLSQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:46:01 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:40378 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbeLSQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:46:01 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C0F4C24E27F1;
        Wed, 19 Dec 2018 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545237960; bh=OyXGMQ/pJOEYcE/bJ8uErcbZH0mtCgc1xkHKcrI8SCA=;
        h=From:To:CC:Subject:Date:References:From;
        b=L2kf5RwKPtNUB21aGE2Fcjzr8CW5EuyYt8DblySBd+5qYrrhnUw0waJ7N7ITk3LpH
         LG4gFR6g6phJTowJ3IWFN4EQh/Jolszei9mhJk4LZuK1vUfsbjGupELopUC8konAWD
         1EXPhTp3Vn5e6Br4ZEk+DfSoK6wysIUBI12edahsZ4wIBW1H6MvKE9fFxxIHA/+lZj
         7do7qTPB/jBvbGspPrMHFWLQr9+m9gGGlAMCWArHpp7IgKj1PWK5nnCOvEfDRffJcv
         bAnCgmwwN3S94dWoawOimIdlOawBakSsSpJyXn8gvv55iTIa54GIw0rK0NLZwavnxb
         VMjvud9eyhSrQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 485B53A4A;
        Wed, 19 Dec 2018 08:46:00 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 19 Dec 2018 08:46:00 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH] arc: remove redundant kernel-space generic-y
Thread-Topic: [PATCH] arc: remove redundant kernel-space generic-y
Thread-Index: AQHUlUobY6gxmBuDVUmOQANdccHfKg==
Date:   Wed, 19 Dec 2018 16:45:59 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464221E5@US01WEMBX2.internal.synopsys.com>
References: <1544969781-14506-1-git-send-email-yamada.masahiro@socionext.com>
 <C2D7FE5348E1B147BCA15975FBA23075014641FC6F@US01WEMBX2.internal.synopsys.com>
 <CAK7LNATJVGVJi_S99zfEpKe+HYWpk+TkfT4gCFZVVTibyP=ThA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 7:16 AM, Masahiro Yamada wrote:=0A=
> Could you pick this up to your arc tree?=0A=
=0A=
Done, will push it in a day or so !=0A=
=0A=
Thx,=0A=
-Vineet=0A=
