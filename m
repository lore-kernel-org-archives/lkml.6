Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758189AbeDXNrW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:47:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53995 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758162AbeDXNrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:47:14 -0400
X-Google-Smtp-Source: AIpwx4/tRgjKnYB72lcemEA3EqZiD9TVyYeeX5Ila60NR0uzcgJ5ZhaeNmufnExf23q3nTMMDR3hXyldsTMyQ+0DHRw=
MIME-Version: 1.0
In-Reply-To: <20180424133527.GB24599@arm.com>
References: <20171223004323.1986-1-Jason@zx2c4.com> <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
 <20180424133527.GB24599@arm.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 24 Apr 2018 15:47:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9pB-CobQCsm2nNHZq_o8qn2+Fff3cGgshyTaQVXtZpWHg@mail.gmail.com>
Message-ID: <CAHmME9pB-CobQCsm2nNHZq_o8qn2+Fff3cGgshyTaQVXtZpWHg@mail.gmail.com>
Subject: Re: [PATCH] arm64: support __int128 with clang
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 3:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Sun, Apr 15, 2018 at 06:20:11PM +0200, Jason A. Donenfeld wrote:
>> Would you review/merge this when you have a chance?
>
> No real objection from me, but does the arm64 kernel actually build with
> clang?

I've been told that Android is moving their kernel builds over to
clang entirely.
