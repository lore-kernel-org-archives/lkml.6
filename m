Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbeE2EGJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:06:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34284 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeE2EGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:06:03 -0400
X-Google-Smtp-Source: AB8JxZojIXIsgDrn0Gao6lLmmkzuLxTXUxc5SFNITQc7iFdB8HMwiORNyh0NPidDoqKPuZ74iO4glw==
Date: Mon, 28 May 2018 21:07:42 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Vinod <vkoul@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] remoteproc: qcom: Introduce Hexagon V5 based
 WCSS driver
Message-ID: <20180529040742.GD2259@tuxbook-pro>
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-6-bjorn.andersson@linaro.org>
 <20180523060516.GD20991@vkoul-mobl>
 <20180523065815.GZ14924@minitux>
 <20180523073723.GF20991@vkoul-mobl>
 <fa0af8c1-f635-13e7-e600-4c1f91a48351@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0af8c1-f635-13e7-e600-4c1f91a48351@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23 May 07:48 PDT 2018, Sricharan R wrote:
> On 5/23/2018 1:07 PM, Vinod wrote:
> > On 22-05-18, 23:58, Bjorn Andersson wrote:
> >> On Tue 22 May 23:05 PDT 2018, Vinod wrote:
> >>> On 22-05-18, 22:20, Bjorn Andersson wrote:
[..]
> >>> Looking at the patch, few other comments would be applicable too, so would be
> >>> great if you/Sricharan can update this
> >>>
> >>
> >> I agree, the primary purpose of this patch was rather to get feedback on
> >> the structure of the drivers, I do expect this to take another round
> >> through the editor to get some polishing touches. Sorry if this wasn't
> >> clear from the description.
> > 
> > Since Sricharan replied to comments, I though they would be fixed. Yeah this is
> > fine from RFC..
> > 
> 
>  Thanks for this.
> 
>  Tested this on ipq8074 and wcss rproc is up with this.
> 
>  Tested-by: Sricharan R <sricharan@codeaurora.org>
> 

Thanks Sricharan!

>  So regarding the cleanup, as i see, this consolidates the code much better.
> 
>  so about the point of avoiding duplication for soc specific functions like
>  qcv5_wcss_reset common between qcv5_wcss and qcv5_pil drivers as done in my
>  series, with a second thought that feels it might be difficult to maintain
>  in the longer run. Since the sequences are specific to each soc and for now
>  although some part of it is common, for a minor update in one soc, common
>  code needs to reworked every time and tested on all boards that share them.
> 
>  So feels like having the duplication for hw init sequences is the cleaner way.
> 

Sounds good, then let's go with this approach!

>  Apart from that for other comments on the q6v5 wcss driver, i can address them
>  on this final patch that you have posted and same can be included in your
>  next version. Please let me know how you want to go about it.
> 

If you can help me review the first 4 patches and fix up and resend the
5th that would be greatly appreciated.

Regards,
Bjorn
