Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeDFXPN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:15:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34256 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeDFXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:15:12 -0400
X-Google-Smtp-Source: AIpwx4/4SI1LAqBZ+HidOgJewHonfU915EuzgPCg7/0EH6qBZ3omlFAkCtINMzHbwwVo5z9KE7kBLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180406151356.7818-2-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180406151356.7818-1-ilina@codeaurora.org>
 <20180406151356.7818-2-ilina@codeaurora.org>
Message-ID: <152305651008.94378.1234920046794943153@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 [RESEND] 1/2] drivers: qcom: add command DB driver
Date: Fri, 06 Apr 2018 16:15:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36NFIiq008734

Quoting Lina Iyer (2018-04-06 08:13:55)
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB is a simple database in the shared memory of QCOM SoCs, that
> provides information regarding shared resources. Some shared resources
> in the SoC have properties that are probed dynamically at boot by the
> remote processor. The information pertaining to the SoC and the platform
> are made available in the shared memory. Drivers can query this
> information using predefined strings.
> 
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
