Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeENTYH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:24:07 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37775 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeENTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:24:05 -0400
X-Google-Smtp-Source: AB8JxZpcAMbjtGf2acf8OsNpv/Q8j1NUiiLay0iA7N8CSGxqKYMNADKdAcDsKTAFWeXX8JOjcAp9dg==
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
To: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd9f9811-bec7-5394-30d4-5db833ecf5b4@kernel.dk>
Date: Mon, 14 May 2018 13:24:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/18 7:33 PM, Kent Overstreet wrote:
>  - Add separately allowed mempools, biosets: bcachefs uses both all over the
>    place
> 
>  - Bit of utility code - bio_copy_data_iter(), zero_fill_bio_iter()
> 
>  - bio_list_copy_data(), the bi_next check - defensiveness because of a bug I
>    had fun chasing down at one point
> 
>  - add some exports, because bcachefs does dio its own way
>  - show whether fua is supported in sysfs, because I don't know of anything that
>    exports whether the _block layer_ specifically thinks fua is supported.

Thanks Kent, applied for 4.18 with the update patch 1.

-- 
Jens Axboe
