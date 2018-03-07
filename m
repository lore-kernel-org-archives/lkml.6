Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbeCGCsh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:48:37 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35444 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeCGCse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:48:34 -0500
X-Google-Smtp-Source: AG47ELv6bY3ytPtQ/hl+sbEO1y17bTZY4kz03PfR2V1OuHlNlHySYrZ6LX7+spbXWw/Bh/05tdhrO5MZZ4lTT125+AQ=
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
 <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
 <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 7 Mar 2018 08:18:33 +0530
X-Google-Sender-Auth: 07qTKbnlknuqL3vDHf3C-GXTB6U
Message-ID: <CAOh2x=n0zQMCtC2=NF9rRbSkNUrUJBxu1KWAoOpDh3CBDkCFgQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: msm8916: Add cpu cooling maps
To: Rob Herring <robh+dt@kernel.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 8:13 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Mar 6, 2018 at 7:05 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:

>>         model = "Qualcomm Technologies, Inc. MSM8916";
>> @@ -115,6 +116,10 @@
>>                         cpu-idle-states = <&CPU_SPC>;
>>                         clocks = <&apcs 0>;
>>                         operating-points-v2 = <&cpu_opp_table>;
>> +                       /* cooling options */
>> +                       cooling-min-level = <0>;
>> +                       cooling-max-level = <7>;
>
> Viresh is working on removing these from the binding...

Yep, just drop all cooling-{min|max}-level lines from your code. That
is not used
anywhere by the kernel.
