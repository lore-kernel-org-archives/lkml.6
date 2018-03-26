Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeCZWY3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:24:29 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36768 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeCZWYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:24 -0400
X-Google-Smtp-Source: AIpwx4+CZurK+v7tv2OFFcvnUlWnH+YqFN0V2Kom/tw8PfagXfasCrkARZEHGybxo80bfqM1+Qy9JQ==
Date: Mon, 26 Mar 2018 17:24:22 -0500
From: Rob Herring <robh@kernel.org>
To: Can Guo <cang@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: phy-qcom-qmp: Add UFS phy compitable
 string for sdm845
Message-ID: <20180326061514.3rgc5ucww5gwqboi@rob-hp-laptop>
References: <20180321053720.12780-1-cang@codeaurora.org>
 <20180321053720.12780-3-cang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321053720.12780-3-cang@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 01:37:20PM +0800, Can Guo wrote:
> Update the compatible string for UFS QMP PHY on SDM845.

typo in the subject.

> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
