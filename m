Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCTVf4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbeCTVfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:35:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5192177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Linus Walleij <linus.walleij@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CACRpkdbAYPpcoyVkMm=yKABMByJuCyXdYifuFdYhV4g6CU3sEg@mail.gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-2-sboyd@codeaurora.org>
 <CACRpkdbAYPpcoyVkMm=yKABMByJuCyXdYifuFdYhV4g6CU3sEg@mail.gmail.com>
Message-ID: <152158175270.198100.17839151793045734833@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: Add a reserved-gpio-ranges property
Date: Tue, 20 Mar 2018 14:35:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-03-19 20:36:35)
> Hi Stephen,
> 
> thanks for the patch and hope you have a good time at your new
> workplace!
> 
> On Fri, Jan 26, 2018 at 2:13 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > Some qcom platforms make some GPIOs or pins unavailable for use
> > by non-secure operating systems, and thus reading or writing the
> > registers for those pins will cause access control issues.
> > Introduce a DT property to describe the set of GPIOs that are
> > available for use so that higher level OSes are able to know what
> > pins to avoid reading/writing.
> >
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> This looks fine except Andy's note to rename this ranges
> to gpio-reserved-ranges for namespacing.

Ok! I'll rename to gpio-reserved-ranges.

> 
> Are you reposting this series as v3 with this fixed or does someone
> else need to pick it up?

Yes I can do it today or tomorrow.
