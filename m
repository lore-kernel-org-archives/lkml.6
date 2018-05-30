Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935901AbeE3IIh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:08:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34499 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935832AbeE3IIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:08:20 -0400
X-Google-Smtp-Source: ADUXVKKUR/tntYkFf37y0aUzzbJ0VOrvyLOI1lw+740h/ds7NV50KgtTgJ2KT/zG98R9D2/G9MDUBRp7Odiq6m1p0WI=
MIME-Version: 1.0
In-Reply-To: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 May 2018 10:08:19 +0200
X-Google-Sender-Auth: 65Yh-x3La_PEGQsOPIsGTeFpG04
Message-ID: <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com>
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 2:07 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> [v14]
>  * Addressed comment from Sudeep about DT compatible
>  * Added MAINTAINERS entry

This causes a build issue to occur in my bleeding-edge branch.

Does it depend on anything new in arm-soc?

Thanks,
Rafael
