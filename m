Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeB0VOy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:14:54 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:52089 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeB0VOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:14:53 -0500
X-Google-Smtp-Source: AH8x226Xn5yy7y5uVtVA0ca18seDptIR/YrNVBqK3cSg8dvbsr/gxKgVaxWBN2a8U4j1BCqvH6nglMb4NjZBrjGM1l4=
MIME-Version: 1.0
References: <20180220225146.27650-1-mjg59@google.com>
In-Reply-To: <20180220225146.27650-1-mjg59@google.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 27 Feb 2018 21:14:41 +0000
Message-ID: <CACdnJus8ukCH_GutjNJpN2qHD1k6FvmeOqO69E27SqL3y_hf-Q@mail.gmail.com>
Subject: Re: [PATCH V2] Allow configuring whether unsigned modules taint the kernel
To: jeyu@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 2:51 PM Matthew Garrett <mjg59@google.com> wrote:

> Distributions build kernels that are intended to satisfy multiple
> use-cases. One is that kernels must be usable in scenarios where module
> signing is required (such as many Secure Boot policies) and scenarios
> where it isn't (such as booting the same kernel on a legacy BIOS
> system). This requires that CONFIG_MODULE_SIG be set, but this causes a
> change in behaviour for the legacy platform case - loading an unsigned
> module now taints the kernel. This is a change in behaviour, and may
> cause users to file bugs, increasing distribution support load.

Sorry, just realised I sent the wrong version of this - I'll resend.
