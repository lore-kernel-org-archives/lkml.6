Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeCUCmY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:42:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeCUCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:42:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 10:42:21 +0800
From: cang@codeaurora.org
To: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Support for Qualcomm UFS QMP PHY on SDM845
In-Reply-To: <20180320113051.14444-1-cang@codeaurora.org>
References: <20180320113051.14444-1-cang@codeaurora.org>
Message-ID: <c14de7cf5c497de1d3ee1b0217438116@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 19:30, Can Guo wrote:
> This patch series adds support for UFS QMP PHY on SDM845 and updates 
> the
> compitable string for it.
> 
> Can Guo (2):
>   phy: Add QMP phy based UFS phy support for sdm845
>   dt-bindings: phy-qcom-qmp: Update UFS phy compitable string for 
> sdm845
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   3 +-
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 120 
> ++++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |   8 ++
>  3 files changed, 128 insertions(+), 3 deletions(-)
