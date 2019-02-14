Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D6FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F020823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438995AbfBNPFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:05:07 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:55417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbfBNPFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:05:07 -0500
Received: from [192.168.1.110] ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKKdD-1ge9Yr0e2p-00LpD3; Thu, 14 Feb 2019 16:04:58 +0100
Subject: Re: APUv2/v3 board support V2
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <CAHp75VeZSrxoxd298eFiJj-N_MRsCXa2GEAXry5jCUi6twt_Xg@mail.gmail.com>
 <fadb3559-d397-04c9-1bdd-e4d625cce278@metux.net>
 <CAHp75VeL8Z1EE=vh6VG18ecDxp9Zq4XKmnxc=PHZnNxKqc_BMg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0f952b25-9ba9-b2cb-381b-d51e195e8378@metux.net>
Date:   Thu, 14 Feb 2019 16:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeL8Z1EE=vh6VG18ecDxp9Zq4XKmnxc=PHZnNxKqc_BMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i65/D3i3/l3ZoNTHSZ97XIaw1jQlXNmUmHypN+vOhx+J0p84UqW
 WOcwBgDTJpyw10jnbl6F066sfjrslZxVa092PYlEtJ7zfoaNT45mZQTaeGuolhalXoIJYWm
 37AwmIbYjIkVtlok+11LuVbv3cxX2dQnO0RBCIl98EiW95Vv3Pmu/fziJ4QmOxMeC4KPu2S
 3YPNNEQ52dkwQi6lpvH7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XM+PVVDnsmo=:qXkISUT6JwUhk5u93Mvlgt
 nmuXGzsiXhTC+vRUhjLBkqTl+AyJ7DNF8gskieiQ9TqCtsqU2lXKAGR2QUxshueOOpomE0xxW
 tJwF9erpIDCVIJGAPbB3kLcMrAf8dXimr5m8dslUURGw1BOGN6SvXfMAsLKcuBrTRgF6Ay6Ch
 HeH1eg98LMwaOfXORNx9S+CtQRMLmNBaNVdepw1LOpUPQlwzedzrv7C8IFbVZfg1Ok53dTjkJ
 fypNDWmpzrerZ7pZVeG9EOe2tvnlnN0p2vpXnLXXdLofqPtpoW4caLFeMudCmT1LNy/nf5sBy
 WvbJHfL+4NTwsSSt/qbDgz8/7EGgpSoJmeDjmDBNoe0OxxS/qbLBwXMNpq3JRuzVbNNyFHJ9a
 nMTbRjmA4g1kiiABW+Usd2nhUtB6INHrJyeVpsmiXi03E7rtw8+krx2EDEeZCb2C+GgrOEJ6K
 YNVw1j2YnlmkeNvdxb9gl3GqLYPr4b7wU3xTogzVDKGSuzgQo3ZwWQoKkm+/gtJu2DD/J+2va
 MpoO/hr1gT3UYiXf5VOg2wgpWQbkZPv8T4Zgn+4mLa0gpewR2ldrfBtuHA74tl20413NuCh5H
 kPqSAx//5OxCAbv6Ca76K6H+M2aUL0sBNTGoeSoMx9v950rmXtFRu1c3bUGBA0T3WjwoDwMzZ
 Ecx3mXhj4OWgShhxb1BamTFPqs18LM35mAMAZb3MTqRCUprw5tJfcY/dRl+WQuzsy/V95LU+5
 ntYt+UFDrQml7DzdfNuRPb3+CH5bxiOL7/wtP4OpzNTvFsTFz/UnDXZ6Ggc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.19 13:33, Andy Shevchenko wrote:

> It's there from several releases. But it's not a send-email option,
> it's format-patch one.
> send-email passes those commands to format-patch.

oh, wasn't aware of that.
thx.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
