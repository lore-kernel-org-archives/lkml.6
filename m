Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934555AbeBMLQC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:16:02 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37676 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934226AbeBMLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:16:01 -0500
X-Google-Smtp-Source: AH8x227FrhyYd8QcdYmzAoavft4y4pmOfdhb76ZXoWprwqQxbG7FZ3UUkvOgdhvOta0YFDb0oqH/Kw==
MIME-Version: 1.0
In-Reply-To: <20180213221019.24527c07@canb.auug.org.au>
References: <20180213221019.24527c07@canb.auug.org.au>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 13 Feb 2018 19:15:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v658XJEsV+9-Cou-oDq3t-7YhOvsQ+EgLn7nMvkeSB8QwQ@mail.gmail.com>
Message-ID: <CAGb2v658XJEsV+9-Cou-oDq3t-7YhOvsQ+EgLn7nMvkeSB8QwQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the sunxi tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:10 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commit
>
>   d7b1e9fa9536 ("ARM: dts: sun[4-7]i: Remove "cooling-{min|max}-level" for CPU nodes")
>
> is missing a Signed-off-by from its committer.

My bad. I rebased one of the sunxi branches to clean up some commit subjects,
and missed a patch when adding my SoBs.

It's all fixed now.

ChenYu
