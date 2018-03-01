Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966488AbeCAIlM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:41:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:9315 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964939AbeCAIlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:41:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="22009769"
Date: Thu, 1 Mar 2018 14:14:56 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, dmaengine@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        yanhe@quicinc.com, ramkri@qti.qualcomm.com, sdharia@quicinc.com
Subject: Re: [PATCH v3 0/5] dmaengine: qcom: bam_dma: fixes for remotely
 controlled bam
Message-ID: <20180301084456.GG15443@localhost>
References: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 12:25:06PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Hi Andy,
> 
> I did hit few issues while trying out SLIMBus BAM on DB820c, this BAM instance
> is remotely controlled and powered up after ADSP is booted using QMI commands.
> 
> Firstly some of the master registers are written even when the BAM is remotely
> controlled, and secondly reading registers when bam is not ready yet.
> 
> These 4 patches address these issues, there are few more issues like doing PM
> in simillar usecase, these will be addressed soon.

Applied all, thanks

-- 
~Vinod
