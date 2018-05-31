Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755782AbeEaRQn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:16:43 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34626 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbeEaRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:16:42 -0400
X-Google-Smtp-Source: ADUXVKL8cd7763jVdw96DIbOGnKKAP+5fKc9X4nyzKBU8zny7mTvjoGBhwxwpfcmN9SUAYnR0jRD5g==
Date: Thu, 31 May 2018 12:16:39 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: Add vendor prefix for ArcherMind
Message-ID: <20180531171639.GA23016@rob-hp-laptop>
References: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
 <20180529045258.1415-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529045258.1415-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:22:57AM +0530, Manivannan Sadhasivam wrote:
> Add vendor prefix for ArcherMind Technology (Nanjing) Co., Ltd.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

I've applied this while you all debate the dts file.

Rob
