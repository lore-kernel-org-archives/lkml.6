Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbeCZJrv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:47:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46686 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCZJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:47:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Mar 2018 15:17:46 +0530
From: sricharan@codeaurora.org
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Subject: Re: [v9,04/15] clk: qcom: Add HFPLL driver
In-Reply-To: <20180325193341.27845-1-ctatlor97@gmail.com>
References: <520347148-27852-5-git-send-email-sricharan@codeaurora.org>
 <20180325193341.27845-1-ctatlor97@gmail.com>
Message-ID: <0132a9e1371c7e690d174cb4d65bc951@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-26 01:03, Craig Tatlor wrote:
> This doesn't seem to work correctly with the higher clocks on 8974pro,
> specifically 2150400000 hz or above, maybe its something to do with
> being bigger than an unsigned long.
> 
> When i try to set any higher frequency it jumps down to 300mhz.


  Thanks for testing this series. Not sure i got dropped from the list.
  So i will check on this and come back.

Regards,
  Sricharan
