Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeBEGGz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:06:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35379 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeBEGGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:06:48 -0500
X-Google-Smtp-Source: AH8x224pyWmNlU0f1eGZrVLXYCrZcpAb2+JCDIZ1SPGbXw28v8IhxPuOSqRn+Sv5/Gr6csiQmQK8vQ==
Date: Mon, 5 Feb 2018 00:06:45 -0600
From: Rob Herring <robh@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: update the binding to
 reflect data cells
Message-ID: <20180205060546.qmifjvovungdomnr@rob-hp-laptop>
References: <1516865849-26191-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516865849-26191-1-git-send-email-aisheng.dong@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 03:37:28PM +0800, Dong Aisheng wrote:
> imx-ocotp is implemented based on nvmem which can have data cells
> as child node. Update the binding doc to reflect it to be more easily
> understood by users.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.txt        | 23 ++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
