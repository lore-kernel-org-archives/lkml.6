Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeBSUQJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:16:09 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42719 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753550AbeBSUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:16:07 -0500
X-Google-Smtp-Source: AH8x224cFhzfcAhP4Elo2XIKPLPRhVaPTNLx5PLC/ytZCd2+gAVWziilcYpF+RIc8eL7s637zWlPwA==
Date: Mon, 19 Feb 2018 14:16:05 -0600
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, mark.rutland@arm.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net
Subject: Re: [PATCH v3 1/2] dt-bindings: net: Add bindings for National
 Instruments XGE netdev
Message-ID: <20180219201605.f7lhgcqxpcjh2ujc@rob-hp-laptop>
References: <20180216170033.3834-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216170033.3834-1-mdf@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 09:00:32AM -0800, Moritz Fischer wrote:
> This adds bindings for the NI XGE 1G/10G network device.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes from v2:
> - Addressed Rob's comments w.r.t to IRQ names and typo
> 
> Changes from v1:
> - Corrected from nixge -> nixge.txt
> 
> ---
>  Documentation/devicetree/bindings/net/nixge.txt | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nixge.txt

Reviewed-by: Rob Herring <robh@kernel.org>
