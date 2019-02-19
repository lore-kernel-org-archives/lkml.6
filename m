Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFC3C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62821773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfBSKLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:11:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41820 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSKLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:11:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so22455992qtp.8;
        Tue, 19 Feb 2019 02:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKEeWi6nyKswsgXAGVDZ/Sod1fD7earVCrPKBugb258=;
        b=UTywGYnTBj4yenQMQ4+/DxcDru79m7BoAbHYTcHx85ulgtiCdGTJ0h4SNg8lhS6k3y
         dLw8zR2lhUQ/KVUyaE5GPwTavIWt2gc6K1Tz8+dtbLCnyAk+FGK8VAT31RKaWG4C+z2P
         Utscjlq4kDa78OiXEmTHodDJP5QPwd5iAJjX9rSJekIUrXCgxT+ZeCIYUx03A2raQNTh
         DlolXnJhsBIH/QazBnOj2ThI+ye1Ij2LfpftSpGy0k1mSGGGMGem8iUhXuLYqhelVBsl
         sSORbB+OPEt8mERTQHW1+cSE2iB7zgxIOX9AZ6aVOgO0p3q7kn/Jo6FvAg5h2R1m05yo
         +3/g==
X-Gm-Message-State: AHQUAuaUq9kfRFTx1q7nF5b2eMBLVZpnMOP4zAO077G6mPBUEq1naBbJ
        la/iSyZAMMjJFOZFPbi9562Sd5nP6XL0tihgwF8=
X-Google-Smtp-Source: AHgI3IZ+O8tl4JFIwKUJGm109X1HiP9tOENsBjOokyVsOlFY8bSic4ZEhYijWiv8JO4Tfket02xvbWKDw02pQoEBC9g=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr21565641qtn.212.1550571099770;
 Tue, 19 Feb 2019 02:11:39 -0800 (PST)
MIME-Version: 1.0
References: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a15mLEgVAh1+jQ+GqOcQa0zhrePWofo8iGkTs5_bd=TmQ@mail.gmail.com> <ba5bb646-7fa6-e98f-4ac2-47c55c8f82ba@socionext.com>
In-Reply-To: <ba5bb646-7fa6-e98f-4ac2-47c55c8f82ba@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 11:11:23 +0100
Message-ID: <CAK8P3a0H3wYKqiV6XZe9V_y8rjDTFHcU_jq7+HkwX+6dnXvU9Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 6:11 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
> Thank you for you comments.
>
> On 2019/02/18 21:09, Arnd Bergmann wrote:
> > On Fri, Feb 8, 2019 at 1:28 PM Sugaya Taichi
> > <sugaya.taichi@socionext.com> wrote:
> >> +
> >> +       aliases {
> >> +               serial1 = &uart1;
> >> +       };
> >
> > Maybe start with serial0 here? It seems unusual to start
> > counting at 1.
> >
>
> The M10V evaluation board(EVB) uses a console with uart ch1, so this
> alias number is derived from the used channel one.
> Therefore it is no problem to change the alias number to 0.

The alias should normally reflect whatever is printed on the board,
if there are no labels, the convention is to start with zero, regardless
of what internal uart is connected to it.

     Arnd
