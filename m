Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEROb7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:31:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33760 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeEROb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:31:56 -0400
X-Google-Smtp-Source: AB8JxZqc7IMeIHVbOSLNur+luT96clhcdp1AkKNuB8pr8kznNP+ChqLAmgAe9pNjaKaELUnHItWC6Q==
Date: Fri, 18 May 2018 09:31:54 -0500
From: Rob Herring <robh@kernel.org>
To: rishabhb@codeaurora.org
Cc: Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
Message-ID: <20180518143154.GA6224@rob-hp-laptop>
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
 <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
 <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
 <385198cbb91c4a36ad758997916ad271@codeaurora.org>
 <152649413707.210890.2655572242392552759@swboyd.mtv.corp.google.com>
 <079348edcb511cefb9f4d76877d50cb7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079348edcb511cefb9f4d76877d50cb7@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 04:32:27PM -0700, rishabhb@codeaurora.org wrote:
> On 2018-05-16 11:08, Stephen Boyd wrote:
> > Quoting rishabhb@codeaurora.org (2018-05-16 10:33:14)
> > > On 2018-05-16 10:03, Stephen Boyd wrote:
> > > > Quoting Rishabh Bhatnagar (2018-05-08 13:22:00)
> > > 
> > > >> +
> > > >> +- max-slices:
> > > >> +       usage: required
> > > >> +       Value Type: <u32>
> > > >> +       Definition: Number of cache slices supported by hardware
> > > >> +
> > > >> +Example:
> > > >> +
> > > >> +       llcc: qcom,llcc@1100000 {
> > > >
> > > > cache-controller@1100000 ?
> > > >
> > > We have tried to use consistent naming convention as in llcc_*
> > > everywhere.
> > > Using cache-controller will mix and match the naming convention.
> > > Also in
> > > the documentation it is explained what llcc is and its full form.
> > > 
> > 
> > DT prefers standard node names as opposed to vendor specific node names.
> > Isn't it a cache controller? I fail to see why this can't be done.
> Hi Stephen,
> The driver is vendor specific and also for uniformity purposes we preferred
> to go with this name.

Almost *every* node and driver is vendor specific. Please do as Stephen 
suggested.

Rob
