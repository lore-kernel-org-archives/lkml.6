Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeC0M3v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:29:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45706 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeC0M3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:29:49 -0400
X-Google-Smtp-Source: AG47ELtufNDpEc+u4ozAfPHBNxqfx5SrU090s1Tk85IYtasv7q5ct0faTDNO2fEUk/S3lrISvseGWLaatoiyqpsF+JQ=
MIME-Version: 1.0
In-Reply-To: <20180320013731.olxjil4qfj6ppjsl@vireshk-mac-ubuntu>
References: <cover.1518166039.git.viresh.kumar@linaro.org> <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
 <20180320013731.olxjil4qfj6ppjsl@vireshk-mac-ubuntu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 14:29:48 +0200
X-Google-Sender-Auth: yPTJVcMlOv31XLWaT3H8_NO3yeM
Message-ID: <CAK8P3a2CvoXxbDAopT7Gt5eHx-0bKabP8dYc8_ObtDrd6Q2Tuw@mail.gmail.com>
Subject: Re: [PATCH 06/10] ARM64: dts: meson: Remove "cooling-{min|max}-level"
 for CPU nodes
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:ARM/Amlogic Meson SoC support"
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 2:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-02-18, 14:28, Viresh Kumar wrote:
>> The "cooling-min-level" and "cooling-max-level" properties are not
>> parsed by any part of the kernel currently and the max cooling state of
>> a CPU cooling device is found by referring to the cpufreq table instead.
>>
>> Remove the unused properties from the CPU nodes.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
>>  1 file changed, 4 deletions(-)
>
> @Arnd: Can you please pick this and patch 8/10 from this series for 4.17 ? Both
> are already Acked by Neil. I have just re-bounced both the messages to
> arm@kernel.org. Thanks.

Picked up patches 6, 7 and 8 now. For some reason I didn't see patch 8
in my arm@kernel.org inbox, but I found it on the mailing list.

       Arnd
