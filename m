Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2965218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBKMlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:41:49 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:36017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfBKMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:41:48 -0500
Received: from [192.168.1.110] ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mcp7M-1hT3t42V8c-00Zztm; Mon, 11 Feb 2019 13:41:44 +0100
Subject: Re: [PATCH] checkpatch: Add test for SPDX-License-Identifier on wrong
 line #
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
 <dfd0101f4a596600e2f0f8cf36886cf01c7dcb67.camel@perches.com>
 <9b74ee87f8c1b8fd310e213fcb4994d58610fcb6.camel@perches.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e64adaf7-d7e2-76b7-cfe3-0cbb5c32c79d@metux.net>
Date:   Mon, 11 Feb 2019 13:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9b74ee87f8c1b8fd310e213fcb4994d58610fcb6.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FyO00gSKspRrn3msREYhe8CxkpJom+GkVulF5Z/mGSDbvSMcyDM
 5DroIq8wleRIfhFB2/F6A1omg2QNl4lYjLoy5dSrL5TkHsLu4+Aw1axljkjm/+02YxUmuHo
 q26AM6ekr4ZAXx8AzwGBVDAEfc0tz8QpQdh7ehGPypWsRw18u31EqmI1JdKK+EdtBrqmr++
 h5LZsPOGImdWNXkhNv8Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:02lYvicO80U=:P0k/3VOwItiYH1cj+X5dm/
 mNDMjcBMSBRzjNWFUZPY4orwezb/30pgASer/IDe5AOsCVn4GNZnLhsAAdqW0XuZzXksDH1Vn
 VClJ1ZJJlg9lTnmsgulWjm6rguQH8gpPpCsvAp1JAVG6wCq9/dYQ5imYHJfYuh971y5HbyEc+
 1zIeYfDQ3/Lf7qe0tjtuCeRfTHpAm6RVSm/cv/V/asDxfF+/MjKssuJnblqt7ciVnC2SvgyXt
 zOodXPuVFNFabkU5JLUXzaG+mYLWOR7A3LO70GkKmrmQx0GozMSKefrX3Ib9TbdO/E8+cBYZf
 2nUhPPdJ3BUypCXFahIhdkgv4Xwm0XK/Ka+7bkjUY5OofitKKzqoNkGXS6W9DN3wvHG51k3z5
 hwAm0TlnLbMAF4zgFMKzWDlQQHL82MXcGtqrt0zx5qtUar2mXSxUWIWetJKG1yh6bUwH+ysH+
 GLygOztYa8LEkzbXVGRBzEnrR4viSElWPRWTLhsd+muKeoR8wls2atDTDou+kF4T0q/k016x+
 pUJZCX6AtHSUqnp39xMwnjufLo70AEMbasjGM+eWTFiLHuv5vPxu6UG8MlUpHXn0rYT5PX9QW
 Xd2mZVFksSpo7dtIe1WvBljRkQq08YTW3z8EIUmH9hEgFgvnaehQ2KWXfQ0+SYH8WKtYpl1TG
 BWJMpWf4FMq+XV1yllM11EjKUujm79oer6qPGyNJvMw+CNZMYm3dhnLekFk5sSR8Heum7ZtCN
 xioMkGqCPzQiwWntGIRVHNKQIcxu8AuDdX73XlyyD/iK46GqxpYmjGYDP/g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.19 21:44, Joe Perches wrote:
> Warn when any SPDX-License-Identifier: tag is not created
> on the proper line number.

By the way: there are corner cases, which can't have it at the first
line, eg. scripts.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
