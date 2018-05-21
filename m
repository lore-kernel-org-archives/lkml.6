Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeEUJGD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:06:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43352 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeEUJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:05:57 -0400
X-Google-Smtp-Source: AB8JxZq5jX7Q8tFzECNjWMDu9iaAzjngthVv0Zde+K/myqCBRicgQ3PzUrgpqBQa2yGfS3Xezo6dVA==
Date: Mon, 21 May 2018 14:35:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: ilialin@codeaurora.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, nm@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180521090553.6wervk335scgnko6@vireshk-i7>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org>
 <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <20180518014538.duphof6enscpm5vp@vireshk-i7>
 <019201d3ef66$db97aed0$92c70c70$@codeaurora.org>
 <20180521044938.bnr2sdkmvdorfxqm@vireshk-i7>
 <000501d3f0e2$23500c00$69f02400$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501d3f0e2$23500c00$69f02400$@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18, 12:00, ilialin@codeaurora.org wrote:
> Final version (addressing Russel's comment as well):

Sorry, can't review it like this. At least you should be posting your
diff here and you also need to do that from a sane email client like
mutt, which wouldn't auto-fix/update the code. Doing it from gmail or
thunderbird will ofcourse screw it.

Or a simple way is to send the patch again (alone) using in-reply-to
field.

-- 
viresh
