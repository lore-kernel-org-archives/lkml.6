Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeCEVKh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:10:37 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35161 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeCEVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:10:35 -0500
X-Google-Smtp-Source: AG47ELtsCdO3AK6CKVVbSJ8SYpjKyDW453lRjvPQbWzH5fgBTAtQeIe0t3LHnNcez3M+t7ioG590Qg==
Date: Mon, 5 Mar 2018 15:10:33 -0600
From: Rob Herring <robh@kernel.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180305211033.ejubka6265hmvtze@rob-hp-laptop>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226175802.20052-3-ilina@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:58:02AM -0700, Lina Iyer wrote:
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB provides information on shared resources like clocks,
> regulators etc., probed at boot by the remote subsytem and made
> available in shared memory.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v4:
> 	- Fix unwanted capitalization
> 	- Add reg property
> ---
>  .../devicetree/bindings/arm/msm/cmd-db.txt         | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt

Reviewed-by: Rob Herring <robh@kernel.org>
