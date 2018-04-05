Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeDER7z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:59:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40278 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeDER7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:59:54 -0400
X-Google-Smtp-Source: AIpwx49psR8KYjkebTgit6f3rF+Bzl9gE1bG48S9Ab1VySXgtq2rRs83+D9fw91AC9ss4AeAuz7GKg==
Date: Thu, 5 Apr 2018 10:59:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v6 1/2] drivers: qcom: add command DB driver
Message-ID: <20180405175950.GI18510@minitux>
References: <20180405160459.16693-1-ilina@codeaurora.org>
 <20180405160459.16693-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405160459.16693-2-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Apr 09:04 PDT 2018, Lina Iyer wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
