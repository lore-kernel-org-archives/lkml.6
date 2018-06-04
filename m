Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeFDO4R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:56:17 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43631 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeFDO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:56:15 -0400
X-Google-Smtp-Source: ADUXVKL829Y3I3JVEBAjiiYhDcD3sV1m7D9d4UwAntfRNKKK6cE5oe5iC8yl9M1tcpQS81pvVzdwvg==
Date: Mon, 4 Jun 2018 09:56:10 -0500
From: Rob Herring <robh@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v5 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180604145610.GA8926@rob-hp-laptop>
References: <cover.1527901471.git.collinsd@codeaurora.org>
 <af7152133afd7bbf9ad207905ec4e8d5cbe4e718.1527901471.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7152133afd7bbf9ad207905ec4e8d5cbe4e718.1527901471.git.collinsd@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:34:05PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>  create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

Reviewed-by: Rob Herring <robh@kernel.org>
