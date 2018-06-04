Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeFDHOl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:14:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42147 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeFDHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:14:38 -0400
X-Google-Smtp-Source: ADUXVKJnfMHOFhGkWuGCiGHlJ13VqTfmCMcS3DIma+wk1WKGMkFsOoBem0pWVeq7eenunsBKzXECgA==
Date: Mon, 4 Jun 2018 12:44:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: arm-soc <arm@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: socionext: Add missing cooling device
 properties for CPUs
Message-ID: <20180604071435.moiw5t44yn3wvrvo@vireshk-i7>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <744f4c0a9a6f0d3acfc36e49ef62f17f53831b3b.1527225682.git.viresh.kumar@linaro.org>
 <CAK7LNASv90x3QKPYEy-3Msow0wi99hV8aRiU32aAjS7jMJKydA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASv90x3QKPYEy-3Msow0wi99hV8aRiU32aAjS7jMJKydA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-18, 12:25, Masahiro Yamada wrote:
> 2018-05-25 14:40 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> > The cooling device properties, like "#cooling-cells" and
> > "dynamic-power-coefficient", should either be present for all the CPUs
> > of a cluster or none. If these are present only for a subset of CPUs of
> > a cluster then things will start falling apart as soon as the CPUs are
> > brought online in a different order. For example, this will happen
> > because the operating system looks for such properties in the CPU node
> > it is trying to bring up, so that it can register a cooling device.
> >
> > Add such missing properties.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 
> Applied to linux-uniphier.
> 
> I had already sent a PR for v4.18-rc1 before I received this patch.
> Please wait for v4.19-rc1.

Sure, no hurry. Though I thought this kind of fixes can go in 4.18-rc2 as well,
isn't it ?

-- 
viresh
