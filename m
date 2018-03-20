Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCTDgn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:36:43 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37395 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCTDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:36:37 -0400
X-Google-Smtp-Source: AG47ELtmnRnFMw5OxU0vbz/sm9Vj013ZrnLbqf/sZuuRfz/pqYzH7xorzbRB9OlJdWe8ZuEBFrELdnHdzW/oPdhv8D8=
MIME-Version: 1.0
In-Reply-To: <20180126011400.2191-2-sboyd@codeaurora.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org> <20180126011400.2191-2-sboyd@codeaurora.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Mar 2018 04:36:35 +0100
Message-ID: <CACRpkdbAYPpcoyVkMm=yKABMByJuCyXdYifuFdYhV4g6CU3sEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: Add a reserved-gpio-ranges property
To: Stephen Boyd <sboyd@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Timur Tabi <timur@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

thanks for the patch and hope you have a good time at your new
workplace!

On Fri, Jan 26, 2018 at 2:13 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues.
> Introduce a DT property to describe the set of GPIOs that are
> available for use so that higher level OSes are able to know what
> pins to avoid reading/writing.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This looks fine except Andy's note to rename this ranges
to gpio-reserved-ranges for namespacing.

Are you reposting this series as v3 with this fixed or does someone
else need to pick it up?

Yours,
Linus Walleij
