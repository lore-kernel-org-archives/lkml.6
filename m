Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeFEPCX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:02:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35125 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeFEPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:02:21 -0400
X-Google-Smtp-Source: ADUXVKJ/NfLDlSQfmJCjdaih5ftdaVCOyuj25tMwbAX9E7FkENOhyer4gldPCphoS1ixzh+9lKHjB+m/XjUk5OCc5r0=
MIME-Version: 1.0
In-Reply-To: <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com> <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Jun 2018 17:02:19 +0200
X-Google-Sender-Auth: SneAchJ8k6Xjmq5KGmMcWombYNY
Message-ID: <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Currently, ARM64 doesn't support updating the CPU topology masks on
> CPU hotplug operations. ACPI PPTT support rely on that missing feature
> which is technically not incorrect. Instead of reverting all the PPTT
> support, let's keep it simple and disable ACPI PPTT support on ARM64
> for time-being until the topology updates are added for CPU hotplug
> operations.

When is that going to happen?

Nobody else uses PPTT now.
