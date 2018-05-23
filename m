Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbeEWQWx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:22:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39557 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754797AbeEWQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:22:49 -0400
X-Google-Smtp-Source: AB8JxZqEYtLJ1QBxAhPk+SEx239fOazgNXMEBVLhCtoeqvVLuXr+BBcbqVcFLWUlh1Q+9Uw1NeT3nw==
Date: Wed, 23 May 2018 11:22:46 -0500
From: Rob Herring <robh@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180523162246.GA31202@rob-hp-laptop>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 07:43:17PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 185 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>  create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

Reviewed-by: Rob Herring <robh@kernel.org>
