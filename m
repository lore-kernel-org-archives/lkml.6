Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeCZWWv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:22:51 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35789 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeCZWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:22:48 -0400
X-Google-Smtp-Source: AG47ELvNdRNKttSalQn3Xy4GJVJJilc4+kHr4kfSs1s0MovaLYDoUzmejpuuLvPv25kItjxGNcN33Q==
Date: Mon, 26 Mar 2018 17:22:46 -0500
From: Rob Herring <robh@kernel.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180326222246.zjildcniv4lquxft@rob-hp-laptop>
References: <20180309232543.24636-1-ilina@codeaurora.org>
 <20180309232543.24636-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309232543.24636-3-ilina@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 04:25:35PM -0700, Lina Iyer wrote:
> Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
> driver. The driver is used for communicating resource state requests for
> shared resources.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v3:
> 	- Move to soc/qcom
> 	- Amend text per Stephen's suggestions
> 
> Changes in v2:
> 	- Amend text to describe the registers in reg property
> 	- Add reg-names for the registers
> 	- Update examples to use GIC_SPI in interrupts instead of 0
> 	- Rephrase incorrect description
> 
> Changes in v3:
> 	- Fix unwanted capitalization
> 	- Remove clients from the examples, this doc does not describe
> 	  them
> 	- Rephrase introductory paragraph
> 	- Remove hardware specifics from DT bindings
> ---
>  .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
