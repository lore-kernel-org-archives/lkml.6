Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeBFSyv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:54:51 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:37011 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeBFSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:54:44 -0500
X-Google-Smtp-Source: AH8x226R22FN581Uh71IyfJkHsLyda2ykmfOwB1ZXyD4tbPYCPdc9rd1wV2lpTWRYfeGpDXgFjRMCg==
Date: Tue, 6 Feb 2018 10:54:40 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
Message-ID: <20180206185440.GJ9465@builder>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125163216.29018-2-rnayak@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jan 08:32 PST 2018, Rajendra Nayak wrote:
> +		spmi_bus: qcom,spmi@c440000 {
[..]
> +		};
> +

While we have the chance, please remove this empty line.

> +	};
> +};

Regards,
Bjorn
