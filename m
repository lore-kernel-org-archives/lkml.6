Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933099AbeEWNyg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:54:36 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:43721 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932900AbeEWNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:54:35 -0400
Subject: Re: [PATCH v2] PCI: qcom: add runtime pm support to pcie_port
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, vkoul@kernel.org
References: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <30d3e568-4e17-4991-70d6-e86e10ef4dea@mm-sol.com>
Date: Wed, 23 May 2018 16:54:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 05/23/2018 01:44 PM, Srinivas Kandagatla wrote:
> This patch is required when the pcie controller sits on a bus with
> its own power domain and clocks which are controlled via a bus driver
> like simple pm bus. As these bus driver have runtime pm enabled, it makes
> sense to update the usage counter so that the runtime pm does not suspend
> the clks or power domain associated with the bus driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
