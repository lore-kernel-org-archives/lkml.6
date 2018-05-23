Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeEWNgh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933127AbeEWNgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:36:23 -0400
Date: Wed, 23 May 2018 19:06:19 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] PCI: qcom: add runtime pm support to pcie_port
Message-ID: <20180523133619.GL20991@vkoul-mobl>
References: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523104425.6650-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 11:44, Srinivas Kandagatla wrote:
> This patch is required when the pcie controller sits on a bus with
> its own power domain and clocks which are controlled via a bus driver
> like simple pm bus. As these bus driver have runtime pm enabled, it makes
> sense to update the usage counter so that the runtime pm does not suspend
> the clks or power domain associated with the bus driver.

FWIW:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
