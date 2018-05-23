Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeEWLqT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:46:19 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34813 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeEWLqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:46:16 -0400
X-Google-Smtp-Source: ADUXVKKfwvy1T6jKyvLk8rWSMEY8xvde2M/PDQ53LqZ6VO+c8QQiSJlLWd+aR3F2iI+PDJ2UjYrWXf1r44sq1ujjLFY=
MIME-Version: 1.0
In-Reply-To: <002b01d3f28a$0d033900$2709ab00$@codeaurora.org>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
 <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
 <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com> <002901d3f286$198878b0$4c996a10$@codeaurora.org>
 <CAKohponbpErCeTYu9iQm_-dupz5SUr+TKsYXzqmmARB-pq95iA@mail.gmail.com> <002b01d3f28a$0d033900$2709ab00$@codeaurora.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 23 May 2018 17:16:14 +0530
Message-ID: <CAKohponruWpcjuSDg-=ZbZ1=qm2iPZs36mfKYJ3nQZREkc3JCw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2018 at 17:04,  <ilialin@codeaurora.org> wrote:
> You are right. I already checked that in the code...
> However, with module_init() the driver fails on reading the nvmem.

And why is it failing ?
