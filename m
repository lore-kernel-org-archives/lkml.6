Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEVRRN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:17:13 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34562 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeEVRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:17:09 -0400
X-Google-Smtp-Source: AB8JxZrFQQPzRVnILE2AHH6FwB7MKxhPa77+OYiI73KiNX7LwBaeSnpZfaFQQ+v9D+n8bsTdjDDCVQ==
Date: Tue, 22 May 2018 12:17:05 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: update stm32-rtc documentation
 for stm32mp1 rtc
Message-ID: <20180522171705.GA22550@rob-hp-laptop>
References: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
 <1526558666-24243-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526558666-24243-4-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 02:04:25PM +0200, Amelie Delaunay wrote:
> RTC embedded in stm32mp1 SoC is slightly different from stm32h7 one, it
> doesn't require to disable backup domain write protection, and rtc_ck
> parent clock assignment isn't allowed.
> To sum up, stm32mp1 RTC requires 2 clocks, pclk and rtc_ck, and an RTC
> alarm interrupt.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
