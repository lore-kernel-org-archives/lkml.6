Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeENTY5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:24:57 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33315 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeENTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:24:56 -0400
X-Google-Smtp-Source: AB8JxZq7qFDi2oSdxVZq1yZTdBJI2LysibDBi06/l0YqsK4lr++tsrPN5+83oTjxBQFR5CxyVPpl1WTmrWG1hQ0LMF8=
MIME-Version: 1.0
In-Reply-To: <bd9f9811-bec7-5394-30d4-5db833ecf5b4@kernel.dk>
References: <20180509013358.16399-1-kent.overstreet@gmail.com> <bd9f9811-bec7-5394-30d4-5db833ecf5b4@kernel.dk>
From: Kent Overstreet <kent.overstreet@gmail.com>
Date: Mon, 14 May 2018 15:24:53 -0400
Message-ID: <CAC7rs0vTjxkiM3yUuReO848_i7SOD7ZD4NOHcP9bFoxK706-Bg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Mon, May 14, 2018 at 3:24 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 5/8/18 7:33 PM, Kent Overstreet wrote:
>>  - Add separately allowed mempools, biosets: bcachefs uses both all over the
>>    place
>>
>>  - Bit of utility code - bio_copy_data_iter(), zero_fill_bio_iter()
>>
>>  - bio_list_copy_data(), the bi_next check - defensiveness because of a bug I
>>    had fun chasing down at one point
>>
>>  - add some exports, because bcachefs does dio its own way
>>  - show whether fua is supported in sysfs, because I don't know of anything that
>>    exports whether the _block layer_ specifically thinks fua is supported.
>
> Thanks Kent, applied for 4.18 with the update patch 1.
>
> --
> Jens Axboe
>
