Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeE3Ut6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:49:58 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35408 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbeE3Ut4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:49:56 -0400
X-Google-Smtp-Source: ADUXVKI+Op6u+F4KL9J5tJIzizEQKQMncfYKNlq+8Iof5f+rWGowKlZexKFtUp1p+12p/pS+heOA2QBshV4MO7rpXTA=
MIME-Version: 1.0
In-Reply-To: <20180530160843.GG3539@twin.jikos.cz>
References: <20180529234459.GA15302@beast> <20180530151455.GE3539@twin.jikos.cz>
 <20180530160843.GG3539@twin.jikos.cz>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 May 2018 13:49:53 -0700
X-Google-Sender-Auth: nM1TmMXCN9Prh1eIbPkDr0X2uCY
Message-ID: <CAGXu5j+ZuPAfiTHTZ2KuHn76SxaBBqOnFCiK8q0umHcMT3EPyw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: raid56: Remove VLA usage
To: dsterba@suse.cz, Kees Cook <keescook@chromium.org>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 9:08 AM, David Sterba <dsterba@suse.cz> wrote:
> On Wed, May 30, 2018 at 05:14:56PM +0200, David Sterba wrote:
>> On Tue, May 29, 2018 at 04:44:59PM -0700, Kees Cook wrote:
>> > In the quest to remove all stack VLA usage from the kernel[1], this
>> > allocates the working buffers during regular init, instead of using stack
>> > space. This refactors the allocation code a bit to make it easier
>> > to review.
>> >
>> > [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> For the record, so this was the last use of VLA in fs/btrfs/ .

Correct. And fs/ntfs/ has the last remaining VLAs in fs/.

-Kees

-- 
Kees Cook
Pixel Security
