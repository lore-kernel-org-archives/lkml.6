Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeBFQIJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752649AbeBFQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:07:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31425217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x224VLYS/1vZ9SaZW/H+8zS02vR/07ol4MF9bqJT5RL4Ssjts4B+A26maU4V67lI44VFI9kOsCyt+oaJ/keJPV30=
MIME-Version: 1.0
In-Reply-To: <422a4ff024038db02a2952158b0babe5b9281b2b.1517922544.git.robin.murphy@arm.com>
References: <422a4ff024038db02a2952158b0babe5b9281b2b.1517922544.git.robin.murphy@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Feb 2018 10:06:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZ8xzKD=ncTyT1LzCe0+gRL1pzcjDVOyBv61hUTGESnA@mail.gmail.com>
Message-ID: <CAL_JsqKZ8xzKD=ncTyT1LzCe0+gRL1pzcjDVOyBv61hUTGESnA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Remove last trace of GENERIC_IO
To: Robin Murphy <robin.murphy@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 7:11 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Since commit 9de8da47742b ("kconfig: kill off GENERIC_IO option"), this
> select has done nothing, and is now just confusing. Clean it up.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  lib/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

We already have:

https://lkml.org/lkml/2018/1/17/924

and this series:

https://lkml.org/lkml/2018/2/4/208

Rob
