Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965298AbeE3JPn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:15:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35920 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965041AbeE3JPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:15:39 -0400
X-Google-Smtp-Source: ADUXVKIjPXd1vZXYcIt58uMehXotbOSL8jAtx4uYqgCVL6K7ys94mNDlyFEcGFNXyBA9ZJecqpeS+g==
Date: Wed, 30 May 2018 14:45:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
Message-ID: <20180530091535.bzvhg4bvn32mqwgq@vireshk-i7>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
 <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-18, 10:08, Rafael J. Wysocki wrote:
> On Fri, May 25, 2018 at 2:07 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> > [v14]
> >  * Addressed comment from Sudeep about DT compatible
> >  * Added MAINTAINERS entry
> 
> This causes a build issue to occur in my bleeding-edge branch.
> 
> Does it depend on anything new in arm-soc?

He already sent a v15 and the changelog suggest he fixed that build
issue.

-- 
viresh
