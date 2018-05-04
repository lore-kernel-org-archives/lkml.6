Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEDHEA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:04:00 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:44405 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeEDHD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:03:57 -0400
X-Google-Smtp-Source: AB8JxZpSP/GL+967mH5jOtUv2SOcBp+ERVee+NtfGcsL+Y31FTIEBG3hYBJhU3oekxXvilCl8Efbhw==
Date: Fri, 4 May 2018 12:33:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: ilialin@codeaurora.org
Cc: "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>, "'Rob Herring'" <robh@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Liam Girdwood'" <lgirdwood@gmail.com>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Andy Gross'" <andy.gross@linaro.org>,
        "'David Brown'" <david.brown@linaro.org>,
        "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Will Deacon'" <will.deacon@arm.com>,
        "'Linux Clock List'" <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "'open list:ARM/QUALCOMM SUPPORT'" <linux-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "'Nayak, Rajendra'" <rnayak@codeaurora.org>,
        "'Amit Kucheria'" <amit.kucheria@linaro.org>,
        "'Nicolas Dechesne'" <nicolas.dechesne@linaro.org>,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the msm8996
Message-ID: <20180504070354.jvdxlh3nj42rr64x@vireshk-i7>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-9-git-send-email-ilialin@codeaurora.org>
 <20180402091617.GA3572@vireshk-i7>
 <CAKohpo=cw+2Leuwa6XjEYh4kVYK093A5eckUmPBDutgqeqpvog@mail.gmail.com>
 <003001d3e373$f94db540$ebe91fc0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003001d3e373$f94db540$ebe91fc0$@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-18, 09:48, ilialin@codeaurora.org wrote:
> Kryo has single clock per cluster. I define here a shared OPP table per cluster.

Thanks for clarifying.

-- 
viresh
