Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeEDVjy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:39:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42875 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeEDVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:39:52 -0400
X-Google-Smtp-Source: AB8JxZqyyTSS+X0bM2YbRpYO6D923bl4bgkZVsJ+5pi3v4DS3bMMTpiCWC+RrdQgnL5cMl2b+ilvAw==
Date: Fri, 4 May 2018 14:39:50 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v7 07/10] drivers: qcom: rpmh: cache sleep/wake state
 requests
Message-ID: <20180504213950.GD19594@google.com>
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-8-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502193749.31004-8-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 01:37:46PM -0600, Lina Iyer wrote:
> Active state requests are sent immediately to the RSC controller, while
> sleep and wake state requests are cached in this driver to avoid taxing
> the RSC controller repeatedly. The cached values will be sent to the
> controller when the rpmh_flush() is called.
> 
> Generally, flushing is a system PM activity and may be called from the
> system PM drivers when the system is entering suspend or deeper sleep
> modes during cpuidle.
> 
> Also allow invalidating the cached requests, so they may be re-populated
> again.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
