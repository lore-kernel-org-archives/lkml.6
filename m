Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeDZBO2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:14:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39852 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeDZBOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:14:23 -0400
X-Google-Smtp-Source: AB8JxZp5l7kgdrpx6WsV/tplIH1ICPcEtJ1b6SfmOSUB2xp69xSs5XmgxBhsyIy4qUqqZp77uhkSbQ==
Date: Wed, 25 Apr 2018 18:14:21 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 10/10] drivers: qcom: rpmh-rsc: allow active requests
 from wake TCS
Message-ID: <20180426011421.GF243180@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-11-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419221635.17849-11-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:16:35PM -0600, Lina Iyer wrote:
> Some RSCs may only have sleep and wake TCS, i.e, there is no dedicated
> TCS for active mode request, but drivers may still want to make active
> requests from these RSCs. In such cases re-purpose the wake TCS to send
> active state requests.
> 
> The requirement for this is that the driver is aware that the wake TCS
> is being repurposed to send active request, hence the sleep and wake
> TCSes be invalidated before the active request is sent.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
