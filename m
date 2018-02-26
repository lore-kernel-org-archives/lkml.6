Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeBZDpx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:45:53 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36159 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeBZDpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:45:49 -0500
X-Google-Smtp-Source: AG47ELv0EvwfaiTLFuS7FXJBnS3xcOrBWRItKWD8Kmx0QJhGALjAZexAndYWUjmEV27F0eaxHVhRnonKQNAbWYKGfaA=
MIME-Version: 1.0
In-Reply-To: <61e56a69-5722-138e-481e-44473a79b388@linaro.org>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
 <CAMRc=Mct60LMcr-CGJue1dTK+XNwz=dmkm2arTGeN1czeN9JoA@mail.gmail.com> <61e56a69-5722-138e-481e-44473a79b388@linaro.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sun, 25 Feb 2018 19:45:48 -0800
Message-ID: <CAHQ1cqGp3jPvb1FNd9SoP_t-hzAHZazAOobrgM2yustrZ5ja6w@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] Verbatim device names and devm_nvmem_(un)register()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 1:17 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 24/01/18 11:13, Bartosz Golaszewski wrote:
>>>
>>>
>> Hi Srinivas,
>>
>> I don't see this series in next - is it going to miss this merge window?
>>
>
> Thanks for your patience.
>
> In general, I pick stuff which are sent before rc5-rc6 and send it to Greg
> KH for inclusion in char-misc tree.
>
> These patches will be queued for next release cycle..
>

Srinivas:

Correct me if I am wrong, but doesn't seem like these patches made it
to char-misc tree yet. I was recently rebasing them on top of Linus'
master and ended up having to resolve a couple of merge conflicts, so
would you like me to re-spin v4 on top of 4.16-rc1 (or any other
version) and re-submit the series?

Thanks,
Andrey Smirnov
