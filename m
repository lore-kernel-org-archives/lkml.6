Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeEDGBC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:01:02 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36871 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDGA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:00:59 -0400
X-Google-Smtp-Source: AB8JxZrhe4H1M9W+bCxEBNXA7/eEPJCA9xOzlYWKJZRriTuHD5yCSa+csNwzCqOC1nHFhJYqQ1hazw==
Date: Fri, 4 May 2018 11:30:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v5 00/14] CPU scaling support for msm8996
Message-ID: <20180504060055.2pdb6tirhjboy2rq@vireshk-i7>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-18, 14:52, Ilia Lin wrote:
> [v5]
>  * Rebased
>  * Adressed comments from Bjorn
>  * Adressed comments from Viresh
>  * Adressed comments from Sricharan
>  * Adressed comments from Nicolas
>  * Adressed comments from Rob
>  * Adressed comments from Mark

s/Adressed/Addressed/

And that's not how the history should be present here. I don't have
any clue on what I commented on in the previous versions. Now that
there is no clear history available, I need to go look at my previous
replies to understand that. That's not right.

You should mention the exact changes here and you can include the name
of the reviewer in parenthesis. Like this:

* Replaced kmalloc with kzalloc (Viresh).

-- 
viresh
