Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbeCRMvK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:51:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33276 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbeCRMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:49:33 -0400
X-Google-Smtp-Source: AG47ELufg2KUmRIonDcOvmdmnVUsvxiXwS0ZuNExwtFADxGGGA+VuIm6fHTgZLkYKF5TWIWd8P0Dqw==
Date: Sun, 18 Mar 2018 07:49:30 -0500
From: Rob Herring <robh@kernel.org>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/8] dt-bindings: stm32-dma: introduce DMA features
 bitfield
Message-ID: <20180318124930.tgd4llar3zat7idx@rob-hp-laptop>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
 <1520959327-25760-2-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520959327-25760-2-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 05:42:00PM +0100, Pierre-Yves MORDRET wrote:
> This bitfield intends to address features to be activated within the
> driver. Initially the mask was only meant for FIFO Threshold management.
> Backward compatibility is preserved but the meaning of this field has been
> extended to features instead of only threshold.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
