Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967377AbeBPMmS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:42:18 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:38985 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967151AbeBPMmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:42:16 -0500
Subject: Re: [PATCH v3] PCI: qcom: add missing supplies required for msm8996
To: srinivas.kandagatla@linaro.org, stanimir.varbanov@linaro.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20180215132248.5572-1-srinivas.kandagatla@linaro.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <e7f1ae50-3bf2-de7c-270d-5d06dac25e78@mm-sol.com>
Date: Fri, 16 Feb 2018 14:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180215132248.5572-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 02/15/2018 03:22 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds supplies that are required for msm8996. vdda
> is analog supply that go in to controller, and vddpe_3v3 is
> supply to PCIe endpoint.
> 
> Without these supplies PCIe endpoints which require power supplies are
> not enumerated at all, as there is no one to power it up.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> changes since v2:
> 	Add back empty line suggested by Stan
> 	use ARRAY_SIZE
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  4 ++++
>  drivers/pci/dwc/pcie-qcom.c                        | 23 +++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
