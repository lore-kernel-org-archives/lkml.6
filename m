Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034256AbeCBQib (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:38:31 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39039 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936690AbeCBQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:36:29 -0500
X-Google-Smtp-Source: AG47ELvM0JbgFtlLoOZIkSkZlJ4Qg6oWgmV0N5e1CSwd2ThXLUVSnsXsg1YqrIj2Gko8OHcfQW7TNA==
Date: Fri, 2 Mar 2018 10:36:27 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] dt-bindings: xilinx: Add description for ZynqMP
Message-ID: <20180302163627.d33qdksp7i6xhnhm@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <0bff485b7ad09c0f1e23e82464382b43a918b84d.1519396753.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bff485b7ad09c0f1e23e82464382b43a918b84d.1519396753.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:40:23PM +0100, Michal Simek wrote:
> Record xlnx,zynqmp compatible string.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - New patch in this series
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org> 
