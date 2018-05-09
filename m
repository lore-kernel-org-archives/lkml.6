Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965999AbeEIXjO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 19:39:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45278 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965408AbeEIXjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 19:39:12 -0400
X-Google-Smtp-Source: AB8JxZoBd8N+LIfj6oRECg7VS+ntqPXjbfpIoGsrEKqhPQwvI0TC7CZSGg2mpn5KGXsM99zbZh8kqQ==
Date: Wed, 9 May 2018 16:39:10 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 08/10] drivers: qcom: rpmh: allow requests to be sent
 asynchronously
Message-ID: <20180509233910.GK19594@google.com>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-9-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509170159.29682-9-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:01:57AM -0600, Lina Iyer wrote:
> Platform drivers that want to send a request but do not want to block
> until the RPMH request completes have now a new API -
> rpmh_write_async().
> 
> The API allocates memory and send the requests and returns the control
> back to the platform driver. The tx_done callback from the controller is
> handled in the context of the controller's thread and frees the
> allocated memory. This API allows RPMH requests from atomic contexts as
> well.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
