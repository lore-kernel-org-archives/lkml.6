Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCTIal (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:30:41 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:60238 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCTIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:30:37 -0400
Subject: Re: [PATCH] pcie: qcom: Add support to enable pcie refclk
To: srinivas.kandagatla@linaro.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <09b50715-5835-bf85-b53b-12b4b839ca10@mm-sol.com>
Date: Tue, 20 Mar 2018 10:30:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 03/15/2018 04:41 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to enable 100MHz pcie refclk,
> On some boards like DB600c this clock is not enabled by default.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt |  1 +
>  drivers/pci/dwc/pcie-qcom.c                         | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
