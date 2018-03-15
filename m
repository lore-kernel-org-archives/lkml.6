Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCOVYI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbeCOVYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:24:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF5520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Linus Walleij <linus.walleij@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CACRpkdbd-Zz-JRC-_OfKtx28OvDcf0af93pqraP=XPpAN-geVg@mail.gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-15-git-send-email-patrice.chotard@st.com>
 <fb3b26e8-0102-122b-1386-68a661139706@st.com>
 <CACRpkdbd-Zz-JRC-_OfKtx28OvDcf0af93pqraP=XPpAN-geVg@mail.gmail.com>
Message-ID: <152114904300.111154.16697790469167766472@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 14/15] clk: stm32: Add clk entry for SDMMC2 on stm32F769
Date: Thu, 15 Mar 2018 14:24:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-03-01 01:12:30)
> On Mon, Feb 26, 2018 at 9:41 AM, Patrice CHOTARD <patrice.chotard@st.com> wrote:
> 
> > Hi Stephen, Michael
> >
> > It's a gentle reminder as this patch is present on mailing list and
> > acked-by since 01/12/2018
> 
> You need Stephen's new kernel.org mail address to reach him.
> (Added on TO:)
> 

Thanks. Both work now after I've setup filters to catch everything.
